import 'package:connectivity_plus/connectivity_plus.dart';

/// Which network interfaces are up. Says nothing about whether the internet
/// or the broker is actually reachable.
class NetworkStatus {
  const NetworkStatus(this.kinds);

  static const offline = NetworkStatus({});

  /// Interface kinds such as `wifi`, `mobile` or `ethernet`.
  final Set<String> kinds;

  bool get available => kinds.isNotEmpty;

  /// Whether an interface that was up before is gone, which usually kills
  /// sockets that were using it (Wi-Fi to cellular, for example).
  bool lostInterfaceSince(NetworkStatus previous) =>
      !kinds.containsAll(previous.kinds);
}

/// Source of network changes, so services can be tested without a device.
abstract class NetworkMonitor {
  Future<NetworkStatus> current();

  Stream<NetworkStatus> get changes;
}

/// [NetworkMonitor] backed by connectivity_plus.
class ConnectivityNetworkMonitor implements NetworkMonitor {
  ConnectivityNetworkMonitor([Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<NetworkStatus> current() async {
    try {
      return _status(await _connectivity.checkConnectivity());
    } on Object {
      // Unknown is treated as online so a broken plugin never blocks MQTT.
      return const NetworkStatus({'unknown'});
    }
  }

  @override
  Stream<NetworkStatus> get changes =>
      _connectivity.onConnectivityChanged.map(_status);

  static NetworkStatus _status(List<ConnectivityResult> results) =>
      NetworkStatus({
        for (final result in results)
          if (result != ConnectivityResult.none) result.name,
      });
}
