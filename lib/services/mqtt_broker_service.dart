import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_connection_diagnostics.dart';
import '../models/mqtt_connection_policy.dart';
import '../models/mqtt_connection_status.dart';
import '../models/mqtt_mesh_packet.dart';
import '../models/mqtt_packet_deduplicator.dart';
import '../models/mqtt_publish_policy.dart';
import '../models/mqtt_reconnect_policy.dart';
import '../models/mqtt_settings_codec.dart';
import '../models/mqtt_topic_guard.dart';
import '../models/radio_rx_packet.dart';
import 'mqtt_credentials_store.dart';
import 'mqtt_transport.dart';

/// Owns the MQTT broker session, independent of the radio connection.
///
/// Broker settings live in preferences; credentials only in
/// [MqttCredentialsStore]. While connected it subscribes to observer packet
/// topics and emits each distinct MeshCore packet on [packets]; if the user
/// opts in, it also publishes packets the radio hears as an observer.
class MqttBrokerService extends ChangeNotifier {
  MqttBrokerService({
    required SharedPreferences prefs,
    required MqttCredentialsStore credentials,
    required MqttTransportFactory transportFactory,
    MqttReconnectPolicy reconnectPolicy = const MqttReconnectPolicy(),
    this.maxReconnectAttempts = 8,
    this.statsNotifyInterval = const Duration(milliseconds: 250),
    this.maxPublishesPerMinute = 60,
  }) : _prefs = prefs,
       _credentials = credentials,
       _transportFactory = transportFactory,
       _reconnectPolicy = reconnectPolicy;

  static const _settingsKey = 'mqtt_broker_settings';
  static const _allowInsecureLocalKey = 'mqtt_allow_insecure_local_broker';
  static const _clientIdKey = 'mqtt_client_id';
  static const _deliverChannelMessagesKey = 'mqtt_deliver_channel_messages';
  static const _publishEnabledKey = 'mqtt_publish_enabled';
  static const _publishDirectKey = 'mqtt_publish_direct_traffic';
  static const _publishOwnKey = 'mqtt_publish_own_traffic';

  /// Packets kept for the packet feed, newest first.
  static const recentPacketLimit = 100;

  final SharedPreferences _prefs;
  final MqttCredentialsStore _credentials;
  final MqttTransportFactory _transportFactory;
  final MqttReconnectPolicy _reconnectPolicy;
  final MqttConnectionPolicy _connectionPolicy = const MqttConnectionPolicy();
  final MqttSettingsCodec _codec = const MqttSettingsCodec();

  /// Automatic retries before giving up and showing an error.
  final int maxReconnectAttempts;

  /// Packet counters update listeners at most this often, so a busy broker
  /// doesn't rebuild the UI for every packet.
  final Duration statsNotifyInterval;

  /// Upper bound on observer publishes, so a busy channel can't flood the
  /// broker.
  final int maxPublishesPerMinute;
  final MqttPublishPolicy _publishPolicy = const MqttPublishPolicy();
  MqttPublishSettings _publishSettings = const MqttPublishSettings();
  String? _observerKey;
  String? _observerName;
  // Keyed by the whole raw packet: repeats over different paths are distinct
  // receptions worth sharing, an identical one is not.
  final MqttPacketDeduplicator _publishedReceptions = MqttPacketDeduplicator(
    capacity: 512,
  );
  final ListQueue<DateTime> _publishTimes = ListQueue<DateTime>();
  int _packetsPublished = 0;
  final Map<MqttPublishSkip, int> _publishSkips = {};

  final MqttPacketDeduplicator _deduplicator = MqttPacketDeduplicator(
    capacity: 2048,
  );
  final StreamController<MqttMeshPacket> _packets =
      StreamController<MqttMeshPacket>.broadcast();
  final ListQueue<MqttMeshPacket> _recent = ListQueue<MqttMeshPacket>();
  int _packetsReceived = 0;
  int _packetsAccepted = 0;
  int _packetsDuplicate = 0;
  int _packetsRejected = 0;
  String? _subscribedTopic;
  bool _subscriptionFailed = false;
  bool _deliverChannelMessages = false;
  Timer? _statsNotifyTimer;

  MqttBrokerSettings? _settings;
  bool _allowInsecureLocalBroker = false;
  String? _username;
  MqttConnectionStatus _status = MqttConnectionStatus.notConfigured;
  MqttConnectFailure? _lastFailure;
  String? _configurationError;
  int _reconnectAttempt = 0;
  bool _manuallyDisconnected = true;
  MqttTransport? _transport;
  Timer? _reconnectTimer;
  // Bumped whenever a session is abandoned so late results are ignored.
  int _generation = 0;
  bool _disposed = false;

  MqttBrokerSettings? get settings => _settings;
  bool get allowInsecureLocalBroker => _allowInsecureLocalBroker;
  String? get username => _username;
  bool get hasCredentials => _username != null;
  MqttConnectionStatus get status => _status;
  int get reconnectAttempt => _reconnectAttempt;

  /// Distinct MeshCore packets heard by observers, after deduplication.
  Stream<MqttMeshPacket> get packets => _packets.stream;

  /// The most recent distinct packets, newest first.
  List<MqttMeshPacket> get recentPackets => List.unmodifiable(_recent);
  int get packetsReceived => _packetsReceived;
  int get packetsAccepted => _packetsAccepted;
  int get packetsDuplicate => _packetsDuplicate;
  int get packetsRejected => _packetsRejected;

  /// The observer topic filter while subscribed.
  String? get subscribedTopic => _subscribedTopic;
  bool get subscriptionFailed => _subscriptionFailed;

  /// Whether channel messages heard via MQTT are added to the user's
  /// channels. Off by default; the packet feed works either way.
  bool get deliverChannelMessages => _deliverChannelMessages;

  MqttPublishSettings get publishSettings => _publishSettings;
  int get packetsPublished => _packetsPublished;

  /// How many heard packets were not published, by reason.
  Map<MqttPublishSkip, int> get publishSkips => Map.unmodifiable(_publishSkips);

  /// Where heard packets are published, or null if sharing can't happen
  /// (off, no region, or no radio identity yet).
  String? get publishTopic {
    final settings = _settings;
    final key = _observerKey;
    if (!_publishSettings.enabled || settings == null || key == null) {
      return null;
    }
    final topic = MqttPacketTopics.publishFor(settings, key);
    return topic != null && MqttTopicGuard.validPublishTopic(topic)
        ? topic
        : null;
  }

  /// The connected radio's identity, used as the observer key and name.
  void setObserverIdentity({String? publicKeyHex, String? name}) {
    final key = publicKeyHex == null || publicKeyHex.isEmpty
        ? null
        : publicKeyHex.toUpperCase();
    if (key == _observerKey && name == _observerName) return;
    _observerKey = key;
    _observerName = name;
    _notify();
  }

  /// Publishes a packet the radio heard if the user's sharing settings allow
  /// it. Returns why it was skipped, or null if it was published.
  MqttPublishSkip? publishRadioPacket(RadioRxPacket packet) {
    final skip = _publish(packet);
    if (skip == null) {
      _packetsPublished++;
    } else if (skip != MqttPublishSkip.disabled) {
      _publishSkips[skip] = (_publishSkips[skip] ?? 0) + 1;
    }
    if (skip != MqttPublishSkip.disabled) _scheduleStatsNotify();
    return skip;
  }

  MqttPublishSkip? _publish(RadioRxPacket packet) {
    if (!_publishSettings.enabled) return MqttPublishSkip.disabled;
    final transport = _transport;
    if (transport == null || _status != MqttConnectionStatus.connected) {
      return MqttPublishSkip.notConnected;
    }
    final topic = publishTopic;
    if (topic == null) return MqttPublishSkip.noTopic;
    final info = MeshPacketInfo.tryParse(packet.raw);
    if (info == null) return MqttPublishSkip.invalid;
    final skip = _publishPolicy.check(
      info,
      fromSelf: packet.fromSelf,
      settings: _publishSettings,
    );
    if (skip != null) return skip;
    final receptionId = crypto.sha256.convert(packet.raw).toString();
    if (!_publishedReceptions.accept(receptionId)) {
      return MqttPublishSkip.alreadyShared;
    }
    final now = packet.receivedAt;
    while (_publishTimes.isNotEmpty &&
        now.difference(_publishTimes.first) >= const Duration(minutes: 1)) {
      _publishTimes.removeFirst();
    }
    if (_publishTimes.length >= maxPublishesPerMinute) {
      return MqttPublishSkip.rateLimited;
    }
    final sent = transport.publish(
      topic,
      encodeObserverPacket(
        packet,
        info,
        origin: _observerName ?? _observerKey!.substring(0, 8),
        originId: _observerKey!,
      ),
    );
    if (!sent) return MqttPublishSkip.notConnected;
    _publishTimes.addLast(now);
    return null;
  }

  /// User-facing reason for the last failure, if any.
  String? get errorMessage =>
      _configurationError ??
      _lastFailure?.message ??
      (_subscriptionFailed
          ? 'The broker refused the packet subscription.'
          : null);

  bool get canConnect =>
      _settings != null &&
      (_status == MqttConnectionStatus.disconnected ||
          _status == MqttConnectionStatus.error);

  MqttConnectionDiagnostics get diagnostics => MqttConnectionDiagnostics(
    status: _status,
    host: _settings?.host,
    port: _settings?.port,
    lastErrorCategory: _configurationError != null
        ? 'configuration'
        : _lastFailure?.category,
    reconnectAttempt: _reconnectAttempt,
  );

  Future<void> load() async {
    final raw = _prefs.getString(_settingsKey);
    if (raw != null) {
      try {
        _settings = _codec.decode(jsonDecode(raw) as Map<String, dynamic>);
      } on FormatException {
        _settings = null;
      }
    }
    _allowInsecureLocalBroker = _prefs.getBool(_allowInsecureLocalKey) ?? false;
    _deliverChannelMessages =
        _prefs.getBool(_deliverChannelMessagesKey) ?? false;
    _publishSettings = MqttPublishSettings(
      enabled: _prefs.getBool(_publishEnabledKey) ?? false,
      includeDirectTraffic: _prefs.getBool(_publishDirectKey) ?? false,
      includeOwnTraffic: _prefs.getBool(_publishOwnKey) ?? false,
    );
    _username = (await _credentials.read())?.username;
    _status = _settings == null
        ? MqttConnectionStatus.notConfigured
        : MqttConnectionStatus.disconnected;
    _notify();
  }

  /// Validates and stores broker settings and credentials, ending any
  /// current session. An empty [username] removes saved credentials; a null
  /// [password] keeps the saved password for the same account.
  Future<String?> saveConfiguration(
    MqttBrokerSettings settings, {
    bool allowInsecureLocalBroker = false,
    String username = '',
    String? password,
    bool? deliverChannelMessages,
    MqttPublishSettings? publishSettings,
  }) async {
    final error = _connectionPolicy.validate(
      settings,
      allowInsecureLocalBroker: allowInsecureLocalBroker,
    );
    if (error != null) return error;
    if ((publishSettings ?? _publishSettings).enabled &&
        settings.region.trim().isEmpty) {
      return 'Set a region to share packets as an observer.';
    }

    final trimmedUser = username.trim();
    if (trimmedUser.isEmpty) {
      await _credentials.clear();
    } else {
      final newPassword =
          password ??
          (trimmedUser == _username
              ? (await _credentials.read())?.password
              : null);
      if (newPassword == null || newPassword.isEmpty) {
        return 'Enter the password for $trimmedUser.';
      }
      await _credentials.save(username: trimmedUser, password: newPassword);
    }

    disconnect();
    await _prefs.setString(_settingsKey, jsonEncode(_codec.encode(settings)));
    await _prefs.setBool(_allowInsecureLocalKey, allowInsecureLocalBroker);
    if (deliverChannelMessages != null) {
      await _prefs.setBool(_deliverChannelMessagesKey, deliverChannelMessages);
      _deliverChannelMessages = deliverChannelMessages;
    }
    if (publishSettings != null) {
      await _prefs.setBool(_publishEnabledKey, publishSettings.enabled);
      await _prefs.setBool(
        _publishDirectKey,
        publishSettings.includeDirectTraffic,
      );
      await _prefs.setBool(_publishOwnKey, publishSettings.includeOwnTraffic);
      _publishSettings = publishSettings;
    }
    _settings = settings;
    _allowInsecureLocalBroker = allowInsecureLocalBroker;
    _username = trimmedUser.isEmpty ? null : trimmedUser;
    _configurationError = null;
    _lastFailure = null;
    _resetPacketStats();
    _status = MqttConnectionStatus.disconnected;
    _notify();
    return null;
  }

  /// Starts a broker session. Safe to call repeatedly.
  Future<void> connect() async {
    if (!canConnect) return;
    _manuallyDisconnected = false;
    _reconnectAttempt = 0;
    await _attempt(MqttConnectionStatus.connecting);
  }

  /// Ends the session and stops automatic reconnects.
  void disconnect() {
    _manuallyDisconnected = true;
    _abandonSession();
    _reconnectAttempt = 0;
    if (_settings != null && _status != MqttConnectionStatus.disconnected) {
      _status = MqttConnectionStatus.disconnected;
      _notify();
    }
  }

  Future<void> _attempt(MqttConnectionStatus pendingStatus) async {
    final settings = _settings;
    if (settings == null) return;
    _abandonSession();
    final generation = _generation;

    _configurationError = _connectionPolicy.validate(
      settings,
      allowInsecureLocalBroker: _allowInsecureLocalBroker,
    );
    if (_configurationError != null) {
      _status = MqttConnectionStatus.error;
      _notify();
      return;
    }

    _status = pendingStatus;
    _notify();

    final credentials = await _credentials.read();
    if (generation != _generation || _disposed) return;
    final transport = _transport = _transportFactory(settings, _clientId());
    transport.onConnectionLost = () {
      if (generation != _generation || _disposed) return;
      _transport = null;
      _subscribedTopic = null;
      _lastFailure = MqttConnectFailure.unreachable;
      _reconnectAttempt = 0;
      _scheduleReconnect(generation);
    };

    final failure = await transport.connect(
      username: credentials?.username,
      password: credentials?.password,
    );
    if (generation != _generation || _disposed) {
      if (failure == null) transport.disconnect();
      return;
    }
    if (failure == null) {
      _lastFailure = null;
      _reconnectAttempt = 0;
      _status = MqttConnectionStatus.connected;
      _subscribe(transport, settings, generation);
      _notify();
      return;
    }
    _transport = null;
    _lastFailure = failure;
    if (failure.retryable) {
      _scheduleReconnect(generation);
    } else {
      _status = MqttConnectionStatus.error;
      _notify();
    }
  }

  void _scheduleReconnect(int generation) {
    final shouldRetry =
        _reconnectAttempt < maxReconnectAttempts &&
        _reconnectPolicy.shouldRetry(
          manuallyDisconnected: _manuallyDisconnected,
          // TODO: feed real connectivity events once a network monitor exists.
          networkAvailable: true,
          configured: _settings != null,
        );
    if (!shouldRetry) {
      _status = MqttConnectionStatus.error;
      _notify();
      return;
    }
    final delay = _reconnectPolicy.delayForAttempt(_reconnectAttempt);
    _reconnectAttempt++;
    _status = MqttConnectionStatus.reconnecting;
    _notify();
    _reconnectTimer = Timer(delay, () {
      if (generation != _generation || _disposed) return;
      unawaited(_attempt(MqttConnectionStatus.reconnecting));
    });
  }

  void _subscribe(
    MqttTransport transport,
    MqttBrokerSettings settings,
    int generation,
  ) {
    final topic = MqttPacketTopics.subscriptionFor(settings);
    if (!MqttTopicGuard.validSubscriptionTopic(topic)) return;
    transport
      ..onMessage = (topic, payload) {
        if (generation == _generation && !_disposed) {
          _handleMessage(topic, payload);
        }
      }
      ..onSubscribeFailed = (_) {
        if (generation != _generation || _disposed) return;
        _subscriptionFailed = true;
        _subscribedTopic = null;
        _notify();
      }
      ..subscribe(topic);
    _subscriptionFailed = false;
    _subscribedTopic = topic;
  }

  void _handleMessage(String topic, Uint8List payload) {
    _packetsReceived++;
    final packet = MqttMeshPacket.tryParse(topic, payload);
    final ownKey = _observerKey;
    if (packet == null) {
      _packetsRejected++;
    } else if (ownKey != null && packet.observerKey?.toUpperCase() == ownKey) {
      // Our own observer publishes coming back; the radio already had them.
      _packetsDuplicate++;
    } else if (!_deduplicator.accept(packet.hash)) {
      _packetsDuplicate++;
    } else {
      _packetsAccepted++;
      _recent.addFirst(packet);
      while (_recent.length > recentPacketLimit) {
        _recent.removeLast();
      }
      _packets.add(packet);
    }
    _scheduleStatsNotify();
  }

  void _scheduleStatsNotify() {
    _statsNotifyTimer ??= Timer(statsNotifyInterval, () {
      _statsNotifyTimer = null;
      _notify();
    });
  }

  void _resetPacketStats() {
    _deduplicator.clear();
    _recent.clear();
    _packetsReceived = 0;
    _packetsAccepted = 0;
    _packetsDuplicate = 0;
    _packetsRejected = 0;
    _publishedReceptions.clear();
    _publishTimes.clear();
    _packetsPublished = 0;
    _publishSkips.clear();
  }

  void _abandonSession() {
    _generation++;
    _subscribedTopic = null;
    _subscriptionFailed = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    final transport = _transport;
    _transport = null;
    transport
      ?..onConnectionLost = null
      ..onMessage = null
      ..onSubscribeFailed = null
      ..disconnect();
  }

  String _clientId() {
    final existing = _prefs.getString(_clientIdKey);
    if (existing != null) return existing;
    final id =
        'notoryx-${const Uuid().v4().replaceAll('-', '').substring(0, 12)}';
    unawaited(_prefs.setString(_clientIdKey, id));
    return id;
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _abandonSession();
    _statsNotifyTimer?.cancel();
    _disposed = true;
    unawaited(_packets.close());
    super.dispose();
  }
}
