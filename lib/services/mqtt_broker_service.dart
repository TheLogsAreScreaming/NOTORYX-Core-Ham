import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../connector/radio_signing.dart';
import '../models/mqtt_auth_token.dart';
import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_connection_diagnostics.dart';
import '../models/mqtt_connection_policy.dart';
import '../models/mqtt_connection_status.dart';
import '../models/mqtt_mesh_packet.dart';
import '../models/mqtt_observer_status.dart';
import '../models/mqtt_packet_deduplicator.dart';
import '../models/mqtt_publish_policy.dart';
import '../models/mqtt_reconnect_policy.dart';
import '../models/mqtt_settings_codec.dart';
import '../models/mqtt_topic_guard.dart';
import '../models/radio_rx_packet.dart';
import 'mqtt_credentials_store.dart';
import 'mqtt_transport.dart';
import 'network_monitor.dart';

/// Owns the MQTT broker session, independent of the radio connection.
///
/// Broker settings live in preferences; credentials only in
/// [MqttCredentialsStore]. While connected it subscribes to observer packet
/// topics and emits each distinct MeshCore packet on [packets]; if the user
/// opts in, it also publishes packets the radio hears as an observer, with a
/// retained `online` status and a matching retained `offline` last will.
///
/// In [MqttAuthMode.radioToken] it signs in with a short-lived token signed by
/// the connected radio (see [setRadioSigner]); the radio's private key never
/// enters the app.
class MqttBrokerService extends ChangeNotifier {
  MqttBrokerService({
    required SharedPreferences prefs,
    required MqttCredentialsStore credentials,
    required MqttTransportFactory transportFactory,
    MqttReconnectPolicy reconnectPolicy = const MqttReconnectPolicy(),
    this.maxReconnectAttempts = 8,
    this.statsNotifyInterval = const Duration(milliseconds: 250),
    this.maxPublishesPerMinute = 60,
    NetworkMonitor? networkMonitor,
    this.clientVersion = 'notoryx-core',
    MqttTokenRefreshPolicy tokenPolicy = const MqttTokenRefreshPolicy(),
    DateTime Function() clock = DateTime.now,
  }) : _networkMonitor = networkMonitor,
       _tokenPolicy = tokenPolicy,
       _clock = clock,
       _prefs = prefs,
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
  final NetworkMonitor? _networkMonitor;
  StreamSubscription<NetworkStatus>? _networkChanges;
  NetworkStatus _network = const NetworkStatus({'unknown'});
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

  /// Sent as `client_version` in status messages and `client` in tokens,
  /// like meshcoretomqtt's `meshcoretomqtt/<version>`.
  String clientVersion;
  final MqttTokenRefreshPolicy _tokenPolicy;
  final DateTime Function() _clock;
  MqttTokenSigner? _radioSigner;
  String? _token;
  String? _tokenKey;
  DateTime? _tokenIssuedAt;
  Timer? _tokenRefreshTimer;
  String? _authError;
  bool _waitingForRadio = false;
  MqttObserverDetails _observerDetails = const MqttObserverDetails();
  // The status topic registered as this session's last will, if any.
  String? _sessionStatusTopic;
  bool _statusOnline = false;
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

  MqttAuthMode get authMode => _settings?.authMode ?? MqttAuthMode.password;

  /// The username a radio-signed token signs in with, once the radio's key
  /// is known.
  String? get tokenUsername {
    final key = _observerKey;
    return authMode == MqttAuthMode.radioToken && key != null
        ? MeshCoreAuthToken.usernameFor(key)
        : null;
  }

  /// When the current radio-signed token expires and is due for renewal.
  DateTime? get tokenExpiresAt =>
      _token == null ? null : _tokenIssuedAt?.add(_tokenPolicy.lifetime);
  DateTime? get tokenRefreshAt => _token == null || _tokenIssuedAt == null
      ? null
      : _tokenPolicy.refreshAt(_tokenIssuedAt!);

  /// Whether token sign-in is waiting for the radio to connect.
  bool get waitingForRadio => _waitingForRadio;

  /// Whether a radio is connected that can sign tokens.
  bool get radioCanSign => _radioSigner != null && _observerKey != null;

  /// The status topic while a retained `online` status is published there.
  String? get onlineStatusTopic => _statusOnline ? _sessionStatusTopic : null;

  /// The connected radio's identity, used as the observer key and name.
  void setObserverIdentity({
    String? publicKeyHex,
    String? name,
    MqttObserverDetails details = const MqttObserverDetails(),
  }) {
    final key = publicKeyHex == null || publicKeyHex.isEmpty
        ? null
        : publicKeyHex.toUpperCase();
    if (key == _observerKey &&
        name == _observerName &&
        details == _observerDetails) {
      return;
    }
    final keyChanged = key != _observerKey;
    // A token signed for another radio can't sign this one in.
    final tokenStale = key != null && _tokenKey != null && _tokenKey != key;
    _observerKey = key;
    _observerName = name;
    _observerDetails = details;
    if (tokenStale) _clearToken();
    _syncStatus(keyChanged: keyChanged, tokenStale: tokenStale);
    _notify();
  }

  /// Signs token sign-in data with the connected radio's key, or null while
  /// no radio is connected. A waiting token sign-in starts once one is.
  void setRadioSigner(MqttTokenSigner? signer) {
    // Tear-offs of the same method compare equal, so repeated syncs are cheap.
    if (signer == _radioSigner) return;
    final hadSigner = _radioSigner != null;
    _radioSigner = signer;
    if (signer != null && !hadSigner) _resumeWaitingForRadio();
    _notify();
  }

  void _resumeWaitingForRadio() {
    if (!_waitingForRadio || _manuallyDisconnected || _disposed) return;
    if (_radioSigner == null || _observerKey == null) return;
    _reconnectAttempt = 0;
    unawaited(_attempt(MqttConnectionStatus.connecting));
  }

  void _clearToken() {
    _token = null;
    _tokenKey = null;
    _tokenIssuedAt = null;
  }

  String? _statusTopicFor(MqttBrokerSettings settings) {
    final key = _observerKey;
    if (!_publishSettings.enabled || key == null) return null;
    final topic = MqttPacketTopics.statusFor(settings, key);
    return topic != null && MqttTopicGuard.validPublishTopic(topic)
        ? topic
        : null;
  }

  Uint8List _statusPayload(MqttObserverPresence presence) =>
      encodeObserverStatus(
        presence,
        at: _clock(),
        origin: _observerName ?? _observerKey!.substring(0, 8),
        originId: _observerKey!,
        clientVersion: clientVersion,
        details: _observerDetails,
      );

  /// Keeps the retained status in step with the radio while connected: a
  /// radio that goes away is reported offline, and a new status topic (or a
  /// new key for token sign-in) needs a new session with a matching will.
  void _syncStatus({bool keyChanged = false, bool tokenStale = false}) {
    final transport = _transport;
    final settings = _settings;
    if (transport == null ||
        settings == null ||
        _status != MqttConnectionStatus.connected) {
      if (keyChanged) _resumeWaitingForRadio();
      return;
    }
    final topic = _statusTopicFor(settings);
    final session = _sessionStatusTopic;
    final tokenForOldKey =
        settings.authMode == MqttAuthMode.radioToken && tokenStale;
    if (topic == session && !tokenForOldKey) {
      if (topic != null && !_statusOnline) {
        _statusOnline = transport.publish(
          topic,
          _statusPayload(MqttObserverPresence.online),
          retain: true,
        );
      }
      return;
    }
    if (topic == null && !tokenForOldKey) {
      // The radio went away: say so, but keep the session and its will.
      _publishOffline();
      return;
    }
    _publishOffline();
    _reconnectAttempt = 0;
    unawaited(_attempt(MqttConnectionStatus.reconnecting));
  }

  /// Replaces the retained `online` status with `offline` before a clean
  /// disconnect, which doesn't trigger the broker's last will.
  void _publishOffline() {
    final transport = _transport;
    final topic = _sessionStatusTopic;
    if (transport == null || topic == null || !_statusOnline) return;
    if (_observerKey != null) {
      transport.publish(
        topic,
        _statusPayload(MqttObserverPresence.offline),
        retain: true,
      );
    } else {
      // No identity left to describe; reuse the registered will's shape.
      final will = _sessionWill;
      if (will != null) {
        transport.publish(
          topic,
          Uint8List.fromList(utf8.encode(will.payload)),
          retain: true,
        );
      }
    }
    _statusOnline = false;
  }

  MqttWill? _sessionWill;

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

  /// Whether a session is wanted but paused until a network comes back.
  bool get waitingForNetwork =>
      !_network.available &&
      !_manuallyDisconnected &&
      _settings != null &&
      _status == MqttConnectionStatus.reconnecting;

  /// User-facing reason for the last failure, if any.
  String? get errorMessage =>
      (waitingForNetwork
          ? 'No network connection. MQTT reconnects when it is back.'
          : null) ??
      _configurationError ??
      (_waitingForRadio
          ? const RadioSigningException(
              RadioSigningFailure.notConnected,
            ).message
          : null) ??
      _authError ??
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
    final monitor = _networkMonitor;
    if (monitor != null && _networkChanges == null) {
      _network = await monitor.current();
      _networkChanges = monitor.changes.listen(_onNetworkChanged);
    }
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

    // Radio-token sign-in uses no stored credentials; keep any saved ones
    // for switching back.
    final usesToken = settings.authMode == MqttAuthMode.radioToken;
    final trimmedUser = usesToken ? (_username ?? '') : username.trim();
    if (usesToken) {
      // Nothing to save.
    } else if (trimmedUser.isEmpty) {
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
    _authError = null;
    _waitingForRadio = false;
    _lastFailure = null;
    _clearToken();
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
    if (!_network.available) {
      _waitForNetwork();
      return;
    }
    await _attempt(MqttConnectionStatus.connecting);
  }

  void _waitForNetwork() {
    _abandonSession();
    _reconnectAttempt = 0;
    _status = MqttConnectionStatus.reconnecting;
    _notify();
  }

  void _onNetworkChanged(NetworkStatus network) {
    final previous = _network;
    _network = network;
    if (_disposed || _manuallyDisconnected || _settings == null) {
      _notify();
      return;
    }
    if (!network.available) {
      // Sockets are gone; don't spend retries until a network is back.
      if (_status != MqttConnectionStatus.error ||
          _lastFailure?.retryable == true) {
        _waitForNetwork();
      }
      return;
    }
    final resume =
        !previous.available &&
        (_status == MqttConnectionStatus.reconnecting ||
            (_status == MqttConnectionStatus.error &&
                _lastFailure?.retryable == true));
    final switched =
        previous.available &&
        network.lostInterfaceSince(previous) &&
        (_status == MqttConnectionStatus.connected ||
            _status == MqttConnectionStatus.reconnecting);
    if (resume || switched) {
      _reconnectAttempt = 0;
      unawaited(_attempt(MqttConnectionStatus.reconnecting));
    } else {
      _notify();
    }
  }

  /// Ends the session and stops automatic reconnects.
  void disconnect() {
    _manuallyDisconnected = true;
    _waitingForRadio = false;
    _publishOffline();
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
    _waitingForRadio = false;
    _authError = null;
    _notify();

    final ({String username, String password})? credentials;
    if (settings.authMode == MqttAuthMode.radioToken) {
      credentials = await _tokenCredentials(settings, generation);
      if (credentials == null) return;
    } else {
      credentials = await _credentials.read();
    }
    if (generation != _generation || _disposed) return;
    final statusTopic = _statusTopicFor(settings);
    final will = statusTopic == null
        ? null
        : MqttWill(
            topic: statusTopic,
            payload: utf8.decode(_statusPayload(MqttObserverPresence.offline)),
          );
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
      will: will,
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
      if (statusTopic != null) {
        _sessionStatusTopic = statusTopic;
        _sessionWill = will;
        _statusOnline = transport.publish(
          statusTopic,
          _statusPayload(MqttObserverPresence.online),
          retain: true,
        );
      }
      if (settings.authMode == MqttAuthMode.radioToken) {
        _scheduleTokenRefresh(generation);
      }
      _notify();
      return;
    }
    if (settings.authMode == MqttAuthMode.radioToken &&
        (failure == MqttConnectFailure.badCredentials ||
            failure == MqttConnectFailure.notAuthorized)) {
      // Never retry a refused token; sign a fresh one next time.
      _clearToken();
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

  /// A fresh or still-valid radio-signed token, or null if signing can't
  /// happen now (the status then says why).
  Future<({String username, String password})?> _tokenCredentials(
    MqttBrokerSettings settings,
    int generation,
  ) async {
    final key = _observerKey;
    final signer = _radioSigner;
    if (key == null || signer == null) {
      _waitForRadio();
      return null;
    }
    final now = _clock();
    final issuedAt = _tokenIssuedAt;
    final cached = _token;
    if (cached != null &&
        _tokenKey == key &&
        issuedAt != null &&
        _tokenPolicy.isFresh(issuedAt, now)) {
      return (username: MeshCoreAuthToken.usernameFor(key), password: cached);
    }
    try {
      final token = await _signToken(settings, key, signer, now);
      if (generation != _generation || _disposed) return null;
      return (username: MeshCoreAuthToken.usernameFor(key), password: token);
    } on RadioSigningException catch (error) {
      if (generation != _generation || _disposed) return null;
      if (error.failure == RadioSigningFailure.notConnected) {
        _waitForRadio();
      } else {
        _authError = error.message;
        _status = MqttConnectionStatus.error;
        _notify();
      }
      return null;
    }
  }

  Future<String> _signToken(
    MqttBrokerSettings settings,
    String key,
    MqttTokenSigner signer,
    DateTime now,
  ) async {
    final token = await MeshCoreAuthToken.create(
      publicKeyHex: key,
      issuedAt: now,
      sign: signer,
      lifetime: _tokenPolicy.lifetime,
      audience: settings.host.trim(),
      client: clientVersion,
    );
    _token = token;
    _tokenKey = key;
    _tokenIssuedAt = now;
    return token;
  }

  void _waitForRadio() {
    _abandonSession();
    _waitingForRadio = true;
    _status = MqttConnectionStatus.error;
    _notify();
  }

  void _scheduleTokenRefresh(int generation, {Duration? after}) {
    _tokenRefreshTimer?.cancel();
    final issuedAt = _tokenIssuedAt;
    if (issuedAt == null) return;
    final delay = after ?? _tokenPolicy.delayUntilRefresh(issuedAt, _clock());
    _tokenRefreshTimer = Timer(delay, () {
      if (generation != _generation || _disposed) return;
      unawaited(_renewToken(generation));
    });
  }

  /// Signs a new token before the current one expires, then swaps to a new
  /// session with it. The current session stays up until the new token is
  /// ready; if signing fails it tries again after a short delay.
  Future<void> _renewToken(int generation) async {
    final settings = _settings;
    final key = _observerKey;
    final signer = _radioSigner;
    if (settings == null) return;
    if (key == null || signer == null) {
      _scheduleTokenRefresh(generation, after: _tokenPolicy.retryDelay);
      _notify();
      return;
    }
    try {
      await _signToken(settings, key, signer, _clock());
    } on RadioSigningException {
      if (generation != _generation || _disposed) return;
      _scheduleTokenRefresh(generation, after: _tokenPolicy.retryDelay);
      return;
    }
    if (generation != _generation || _disposed) return;
    // A clean disconnect leaves the last will unsent, and the new session
    // publishes `online` again.
    _reconnectAttempt = 0;
    await _attempt(MqttConnectionStatus.reconnecting);
  }

  void _scheduleReconnect(int generation) {
    if (!_network.available && !_manuallyDisconnected && _settings != null) {
      _waitForNetwork();
      return;
    }
    final shouldRetry =
        _reconnectAttempt < maxReconnectAttempts &&
        _reconnectPolicy.shouldRetry(
          manuallyDisconnected: _manuallyDisconnected,
          networkAvailable: _network.available,
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
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = null;
    _sessionStatusTopic = null;
    _sessionWill = null;
    _statusOnline = false;
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
    unawaited(_networkChanges?.cancel());
    _publishOffline();
    _abandonSession();
    _statsNotifyTimer?.cancel();
    _disposed = true;
    unawaited(_packets.close());
    super.dispose();
  }
}
