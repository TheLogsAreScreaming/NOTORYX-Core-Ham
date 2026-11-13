/// How a readiness check came out.
enum ReadinessLevel {
  /// Fine.
  ok,

  /// Worth fixing; the trip can still start.
  warn,

  /// The trip can't start until this is fixed.
  block,
}

/// The checks run before a trip, in the order they're shown.
enum ReadinessCheck {
  sosRecipients,
  radio,
  radioBattery,
  tripContacts,
  routes,
  notifications,
  batteryOptimisation,
  offlineMap,
  location,
  automation,
}

/// One check's result.
class ReadinessItem {
  const ReadinessItem(this.check, this.level, {this.names = const []});

  final ReadinessCheck check;
  final ReadinessLevel level;

  /// For [ReadinessCheck.routes]: the trip contacts with no known route.
  final List<String> names;
}

/// What the readiness checks look at, gathered by the caller so the rules
/// stay testable.
class ReadinessInputs {
  const ReadinessInputs({
    required this.connected,
    required this.radioBatteryPercent,
    required this.sosUnavailable,
    required this.hasSosChannel,
    required this.tripMembers,
    required this.presentMembers,
    required this.membersWithoutRoute,
    required this.offlineMap,
    required this.shareLocation,
    required this.hasPosition,
    required this.notificationsAllowed,
    required this.batteryOptimisationExempt,
    required this.automationEnabled,
    required this.foreground,
  });

  final bool connected;
  final int? radioBatteryPercent;

  /// Why SOS can't send right now, or null when it can.
  final String? sosUnavailable;

  /// Whether SOS also posts to a channel, which counts as a recipient.
  final bool hasSosChannel;
  final int tripMembers;
  final int presentMembers;
  final List<String> membersWithoutRoute;

  /// Cached tiles for the trip area, or null when no area is set or checked.
  final ({int available, int expected})? offlineMap;
  final bool shareLocation;
  final bool hasPosition;

  /// Null where the platform can't say.
  final bool? notificationsAllowed;

  /// Null off Android.
  final bool? batteryOptimisationExempt;
  final bool automationEnabled;
  final bool foreground;
}

/// The radio battery level below which the check warns.
const readinessMinRadioBattery = 30;

/// Runs every check. Only an SOS with no one to reach blocks the trip: the
/// rest are warnings the user may knowingly accept.
List<ReadinessItem> assessTrip(ReadinessInputs i) {
  ReadinessLevel warnIf(bool bad) =>
      bad ? ReadinessLevel.warn : ReadinessLevel.ok;
  return [
    ReadinessItem(
      ReadinessCheck.sosRecipients,
      // Connected, SOS's own rules decide. Not connected is its own,
      // softer check, so then only "no one at all to send to" blocks.
      (i.connected
              ? i.sosUnavailable != null
              : i.tripMembers == 0 && !i.hasSosChannel)
          ? ReadinessLevel.block
          : ReadinessLevel.ok,
    ),
    ReadinessItem(ReadinessCheck.radio, warnIf(!i.connected)),
    ReadinessItem(
      ReadinessCheck.radioBattery,
      warnIf(
        i.radioBatteryPercent == null ||
            i.radioBatteryPercent! < readinessMinRadioBattery,
      ),
    ),
    ReadinessItem(
      ReadinessCheck.tripContacts,
      warnIf(i.tripMembers == 0 || i.presentMembers < i.tripMembers),
    ),
    ReadinessItem(
      ReadinessCheck.routes,
      warnIf(i.membersWithoutRoute.isNotEmpty),
      names: i.membersWithoutRoute,
    ),
    if (i.notificationsAllowed != null)
      ReadinessItem(
        ReadinessCheck.notifications,
        warnIf(!i.notificationsAllowed!),
      ),
    if (i.batteryOptimisationExempt != null)
      ReadinessItem(
        ReadinessCheck.batteryOptimisation,
        warnIf(!i.batteryOptimisationExempt!),
      ),
    ReadinessItem(
      ReadinessCheck.offlineMap,
      warnIf(
        i.offlineMap == null ||
            i.offlineMap!.available < i.offlineMap!.expected,
      ),
    ),
    ReadinessItem(
      ReadinessCheck.location,
      warnIf(i.shareLocation && !i.hasPosition),
    ),
    ReadinessItem(
      ReadinessCheck.automation,
      warnIf(i.automationEnabled && !i.foreground),
    ),
  ];
}

/// Whether the trip may start: nothing blocks.
bool canStartTrip(List<ReadinessItem> items) =>
    !items.any((r) => r.level == ReadinessLevel.block);

/// The checks that need a look.
List<ReadinessItem> readinessProblems(List<ReadinessItem> items) =>
    items.where((r) => r.level != ReadinessLevel.ok).toList();
