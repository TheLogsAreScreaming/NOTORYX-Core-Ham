import 'dart:async';
import 'dart:typed_data';

import '../services/app_debug_log_service.dart';
import '../services/tcp_transport_service.dart';
import 'demo_companion.dart';

/// Manages TCP transport for MeshCore devices.
///
/// Owns the [TcpTransportService] and TCP-specific connection state.
/// The main [MeshCoreConnector] delegates all TCP operations here.
class MeshCoreTcpConnector {
  final TcpTransportService _service = TcpTransportService();
  AppDebugLogService? _debugLog;
  StreamSubscription<Uint8List>? _frameSubscription;

  /// Set while the demo radio stands in for a network connection.
  DemoCompanion? _demo;

  // --- Getters ---
  String? get activeEndpoint =>
      _demo?.activeEndpoint ?? _service.activeEndpoint;
  bool get isConnected => _demo?.isConnected ?? _service.isConnected;
  bool get isDemo => _demo != null;

  // --- Configuration ---
  void setDebugLogService(AppDebugLogService? service) {
    _debugLog = service;
    _service.setDebugLogService(service);
  }

  // --- Connection lifecycle ---
  Future<void> connect({required String host, required int port}) async {
    _debugLog?.info('TcpConnector.connect endpoint=$host:$port', tag: 'TCP');
    await _frameSubscription?.cancel();
    _frameSubscription = null;
    _demo?.dispose();
    _demo = null;
    if (isDemoRadioHost(host)) {
      _demo = DemoCompanion();
      await _demo!.connect();
      return;
    }
    await _service.connect(host: host, port: port);
    _debugLog?.info(
      'TcpConnector.connect done, endpoint=${_service.activeEndpoint}',
      tag: 'TCP',
    );
  }

  StreamSubscription<Uint8List> listenFrames({
    required void Function(Uint8List) onFrame,
    required void Function(Object, StackTrace?) onError,
    required void Function() onDone,
  }) {
    _frameSubscription = (_demo?.frameStream ?? _service.frameStream).listen(
      onFrame,
      onError: onError,
      onDone: onDone,
    );
    return _frameSubscription!;
  }

  Future<void> cancelFrameSubscription() async {
    await _frameSubscription?.cancel();
    _frameSubscription = null;
  }

  Future<void> disconnect() async {
    final demo = _demo;
    if (demo != null) {
      _demo = null;
      await _frameSubscription?.cancel();
      _frameSubscription = null;
      demo.dispose();
      return;
    }
    if (!_service.isConnected && _frameSubscription == null) return;
    _debugLog?.info('TcpConnector.disconnect', tag: 'TCP');
    await _frameSubscription?.cancel();
    _frameSubscription = null;
    await _service.disconnect();
  }

  Future<void> write(Uint8List data) =>
      _demo?.write(data) ?? _service.write(data);

  void dispose() {
    _demo?.dispose();
    _frameSubscription?.cancel();
    _service.dispose();
  }
}
