import '../connector/meshcore_connector.dart';

/// Why the connection changed state, when the app knows.
enum ConnectionCause {
  /// The user tapped connect or disconnect.
  user,

  /// The radio link dropped without anyone asking (out of range, radio
  /// restarted, Bluetooth turned off).
  linkLost,

  /// The app is trying again after a drop.
  reconnect,

  /// "Connect to my radio automatically" connected the saved radio, for
  /// example when the app started.
  autoConnect,

  /// The app closed the link itself, for example after a failed handshake.
  app,

  /// Not recorded.
  unknown,
}

/// One state change of the radio connection.
class ConnectionEvent {
  const ConnectionEvent({
    required this.at,
    required this.state,
    required this.transport,
    required this.cause,
  });

  final DateTime at;
  final MeshCoreConnectionState state;
  final MeshCoreTransportType transport;
  final ConnectionCause cause;

  /// One line for a support file, in English so whoever reads it can.
  String toLogLine() =>
      '${at.toIso8601String()}  ${state.name.padRight(13)} '
      '${transport.name.padRight(9)} ${cause.name}';
}

/// The last [capacity] connection state changes, newest last, kept in
/// memory only. Used for the diagnostics screen and the support bundle.
class ConnectionTimeline {
  ConnectionTimeline({this.capacity = 200, DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final int capacity;
  final DateTime Function() _clock;
  final List<ConnectionEvent> _events = [];

  List<ConnectionEvent> get events => List.unmodifiable(_events);

  void record(
    MeshCoreConnectionState state,
    MeshCoreTransportType transport,
    ConnectionCause cause,
  ) {
    _events.add(
      ConnectionEvent(
        at: _clock(),
        state: state,
        transport: transport,
        cause: cause,
      ),
    );
    if (_events.length > capacity) {
      _events.removeRange(0, _events.length - capacity);
    }
  }

  /// How many times the link dropped on its own in the last [window].
  int dropsWithin(Duration window) {
    final since = _clock().subtract(window);
    return _events
        .where(
          (e) =>
              e.cause == ConnectionCause.linkLost &&
              e.state == MeshCoreConnectionState.disconnected &&
              e.at.isAfter(since),
        )
        .length;
  }
}
