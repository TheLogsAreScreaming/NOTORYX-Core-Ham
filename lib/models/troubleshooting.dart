/// A step's live check.
enum StepResult { ok, problem, unchecked }

/// The three guides.
enum TroubleGuide { noDelivery, noConnect, hearNobody }

/// Every step any guide uses.
enum TroubleStep {
  connected,
  routes,
  heardRecently,
  neighbours,
  bluetooth,
  otherApp,
  inRange,
  otherTransport,
  noise,
  region,
  antenna,
}

/// What the live checks look at.
class TroubleSnapshot {
  const TroubleSnapshot({
    required this.connected,
    required this.messagedContacts,
    required this.messagedWithoutRoute,
    required this.messagedNotHeardInDay,
    required this.neighboursLastHour,
    this.noisePoor,
  });

  final bool connected;

  /// People you sent a direct message to in the last week.
  final int messagedContacts;
  final int messagedWithoutRoute;
  final int messagedNotHeardInDay;
  final int neighboursLastHour;

  /// Whether the noise floor grades poor; null without radio stats.
  final bool? noisePoor;
}

/// A guide's steps, in order, with their checks.
List<(TroubleStep, StepResult)> runGuide(
  TroubleGuide guide,
  TroubleSnapshot s,
) {
  StepResult check(bool ok) => ok ? StepResult.ok : StepResult.problem;
  final connected = check(s.connected);
  // Without a connection, radio-side checks can't run.
  StepResult whenConnected(bool ok) =>
      s.connected ? check(ok) : StepResult.unchecked;
  return switch (guide) {
    TroubleGuide.noDelivery => [
      (TroubleStep.connected, connected),
      (
        TroubleStep.routes,
        s.messagedContacts == 0
            ? StepResult.unchecked
            : check(s.messagedWithoutRoute == 0),
      ),
      (
        TroubleStep.heardRecently,
        s.messagedContacts == 0
            ? StepResult.unchecked
            : check(s.messagedNotHeardInDay == 0),
      ),
      (TroubleStep.neighbours, whenConnected(s.neighboursLastHour > 0)),
    ],
    TroubleGuide.noConnect => [
      // Connected means this guide is already solved.
      (TroubleStep.connected, connected),
      (TroubleStep.bluetooth, StepResult.unchecked),
      (TroubleStep.otherApp, StepResult.unchecked),
      (TroubleStep.inRange, StepResult.unchecked),
      (TroubleStep.otherTransport, StepResult.unchecked),
    ],
    TroubleGuide.hearNobody => [
      (TroubleStep.connected, connected),
      (
        TroubleStep.noise,
        s.noisePoor == null || !s.connected
            ? StepResult.unchecked
            : check(!s.noisePoor!),
      ),
      (TroubleStep.neighbours, whenConnected(s.neighboursLastHour > 0)),
      (TroubleStep.region, StepResult.unchecked),
      (TroubleStep.antenna, StepResult.unchecked),
    ],
  };
}

/// The step to start with: the first problem, or else the first step that
/// couldn't be checked; null when every check passed.
TroubleStep? startHere(List<(TroubleStep, StepResult)> steps) {
  for (final (step, result) in steps) {
    if (result == StepResult.problem) return step;
  }
  for (final (step, result) in steps) {
    if (result == StepResult.unchecked) return step;
  }
  return null;
}
