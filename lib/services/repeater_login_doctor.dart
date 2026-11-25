/// Works out which step of a repeater login failed, and checks that a
/// `set` command actually took by reading the value back.
library;

/// The step a repeater login stopped at.
enum LoginFailure {
  /// The companion radio isn't connected, so nothing was sent.
  radioOffline,

  /// The companion radio didn't accept the login frame.
  sendFailed,

  /// The repeater answered and refused the password.
  rejected,

  /// No answer over a saved direct path; the path may be stale.
  noAnswerPath,

  /// No answer by flood; out of range, off, busy, or a wrong password
  /// (repeaters stay silent on one).
  noAnswerFlood,
}

/// Picks the failure to explain from what the login attempt saw.
/// [result] is true for a login-success push, false for a login-fail push
/// and null when nothing came back in time.
LoginFailure? diagnoseLogin({
  required bool radioConnected,
  required bool sendFailed,
  required bool? result,
  required bool usedFlood,
}) {
  if (result == true) return null;
  if (!radioConnected) return LoginFailure.radioOffline;
  if (sendFailed) return LoginFailure.sendFailed;
  if (result == false) return LoginFailure.rejected;
  return usedFlood ? LoginFailure.noAnswerFlood : LoginFailure.noAnswerPath;
}

/// What reading a value back after `set` showed.
sealed class ReadBack {
  const ReadBack();
}

/// The repeater reports the value that was set.
class ReadBackMatch extends ReadBack {
  const ReadBackMatch();
}

/// The repeater reports a different value.
class ReadBackMismatch extends ReadBack {
  const ReadBackMismatch(this.actual);
  final String actual;
}

/// The reply had no value to compare.
class ReadBackUnreadable extends ReadBack {
  const ReadBackUnreadable();
}

/// Settings whose `get` reply can be compared with what was set. Secrets,
/// the private key, radio parameters (applied on reboot) and free text
/// that the firmware rewrites are left out.
const _verifiable = {
  'name',
  'tx',
  'lat',
  'lon',
  'repeat',
  'allow.read.only',
  'advert.interval',
  'flood.advert.interval',
  'flood.max',
  'radio.rxgain',
  'multi.acks',
  'loop.detect',
  'dutycycle',
  'path.hash.mode',
  'txdelay',
  'direct.txdelay',
  'int.thresh',
  'agc.reset.interval',
};

/// The `get` command that reads back [setCommand], or null when that
/// setting isn't checked.
String? readBackCommand(String setCommand) {
  final key = _setKey(setCommand);
  return key != null && _verifiable.contains(key) ? 'get $key' : null;
}

String? _setKey(String setCommand) {
  final c = setCommand.trim();
  if (!c.startsWith('set ')) return null;
  final rest = c.substring(4);
  final space = rest.indexOf(' ');
  return (space == -1 ? rest : rest.substring(0, space)).toLowerCase();
}

/// Compares the value in [setCommand] with a `get` reply (`> value`).
/// Numbers compare by value (`8` = `8.0`), and on/off by meaning
/// (`on` = `1` = `true`).
ReadBack checkReadBack(String setCommand, String getResponse) {
  final c = setCommand.trim();
  final space = c.indexOf(' ', 4);
  final expected = space == -1 ? '' : c.substring(space + 1).trim();
  String? actual;
  for (final line in getResponse.split('\n')) {
    final t = line.trim();
    if (t.startsWith('>')) {
      final v = t.substring(1).trim();
      if (v.isNotEmpty) {
        actual = v;
        break;
      }
    }
  }
  if (actual == null) return const ReadBackUnreadable();
  return _same(expected, actual)
      ? const ReadBackMatch()
      : ReadBackMismatch(actual);
}

bool _same(String expected, String actual) {
  final a = expected.toLowerCase(), b = actual.toLowerCase();
  if (a == b) return true;
  final na = _number(a), nb = _number(b);
  if (na != null && nb != null) return (na - nb).abs() < 1e-6;
  final fa = _flag(a), fb = _flag(b);
  if (fa != null && fb != null) return fa == fb;
  return false;
}

// Some replies carry a unit ("22 dBm"); compare the number in front.
double? _number(String s) =>
    double.tryParse(RegExp(r'^-?\d+(\.\d+)?').stringMatch(s) ?? '');

bool? _flag(String s) => switch (s) {
  'on' || '1' || 'true' || 'enabled' => true,
  'off' || '0' || 'false' || 'disabled' => false,
  _ => null,
};
