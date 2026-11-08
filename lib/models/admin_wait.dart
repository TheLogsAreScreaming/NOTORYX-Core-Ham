/// How many times a remote admin request (status, neighbours, telemetry)
/// is sent before the app gives up: the first try plus one automatic retry.
const int adminRequestMaxAttempts = 2;

/// A request to a remote node that is waiting for its reply.
///
/// The timeout already comes from the route (hops or flood) and the
/// airtime estimate; this only carries what the waiting UI needs to say.
class AdminWait {
  const AdminWait({
    required this.hops,
    required this.timeout,
    this.attempt = 1,
    this.maxAttempts = adminRequestMaxAttempts,
  });

  /// Hop count of the direct route, or a negative value for flood.
  final int hops;

  /// How long this attempt waits before it counts as no reply.
  final Duration timeout;

  /// This attempt's number, starting at 1.
  final int attempt;

  /// Total attempts allowed, including the first.
  final int maxAttempts;

  /// Whether the request goes out as a flood instead of a direct route.
  bool get isFlood => hops < 0;

  /// Whether this attempt is an automatic retry.
  bool get isRetry => attempt > 1;

  /// Whether another attempt may follow if this one gets no reply.
  bool get canRetry => attempt < maxAttempts;

  /// The timeout rounded up to whole seconds, for display.
  int get timeoutSeconds => (timeout.inMilliseconds / 1000).ceil();
}
