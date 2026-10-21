import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_connection_diagnostics.dart';
import '../models/mqtt_connection_policy.dart';
import '../models/mqtt_connection_status.dart';
import '../models/mqtt_reconnect_policy.dart';
import '../models/mqtt_settings_codec.dart';
import 'mqtt_credentials_store.dart';
import 'mqtt_transport.dart';

/// Owns the MQTT broker session, independent of the radio connection.
///
/// Broker settings live in preferences; credentials only in
/// [MqttCredentialsStore]. Subscriptions and publishing build on this later.
class MqttBrokerService extends ChangeNotifier {
  MqttBrokerService({
    required SharedPreferences prefs,
    required MqttCredentialsStore credentials,
    required MqttTransportFactory transportFactory,
    MqttReconnectPolicy reconnectPolicy = const MqttReconnectPolicy(),
    this.maxReconnectAttempts = 8,
  }) : _prefs = prefs,
       _credentials = credentials,
       _transportFactory = transportFactory,
       _reconnectPolicy = reconnectPolicy;

  static const _settingsKey = 'mqtt_broker_settings';
  static const _allowInsecureLocalKey = 'mqtt_allow_insecure_local_broker';
  static const _clientIdKey = 'mqtt_client_id';

  final SharedPreferences _prefs;
  final MqttCredentialsStore _credentials;
  final MqttTransportFactory _transportFactory;
  final MqttReconnectPolicy _reconnectPolicy;
  final MqttConnectionPolicy _connectionPolicy = const MqttConnectionPolicy();
  final MqttSettingsCodec _codec = const MqttSettingsCodec();

  /// Automatic retries before giving up and showing an error.
  final int maxReconnectAttempts;

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

  /// User-facing reason for the last failure, if any.
  String? get errorMessage => _configurationError ?? _lastFailure?.message;

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
  }) async {
    final error = _connectionPolicy.validate(
      settings,
      allowInsecureLocalBroker: allowInsecureLocalBroker,
    );
    if (error != null) return error;

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
    _settings = settings;
    _allowInsecureLocalBroker = allowInsecureLocalBroker;
    _username = trimmedUser.isEmpty ? null : trimmedUser;
    _configurationError = null;
    _lastFailure = null;
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

  void _abandonSession() {
    _generation++;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    final transport = _transport;
    _transport = null;
    transport?.onConnectionLost = null;
    transport?.disconnect();
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
    _disposed = true;
    super.dispose();
  }
}
