/// The station log: one entry per exchange of direct messages with a
/// station whose node name starts with a call sign. Kept on this device and
/// exported as ADIF for logging programs, or CSV.
library;

/// Messages with the same call sign closer together than this belong to
/// the same entry.
const Duration stationLogGap = Duration(minutes: 30);

/// The newest entries kept; older ones drop off.
const int stationLogMax = 2000;

/// One exchange with [call], from [start] to [end] (UTC).
class StationLogEntry {
  const StationLogEntry({
    required this.call,
    required this.start,
    required this.end,
    this.freqKhz,
    this.sent = 0,
    this.received = 0,
  });

  /// The other station's call sign, upper-cased.
  final String call;

  /// First and last message of the exchange, UTC.
  final DateTime start;
  final DateTime end;

  /// The radio's frequency when the exchange started, or null if unknown.
  final int? freqKhz;

  /// Messages sent to and received from [call].
  final int sent;
  final int received;

  /// The ADIF band name for [freqKhz]: "70cm", "33cm", or null.
  String? get band => bandFor(freqKhz);

  StationLogEntry copyWith({DateTime? end, int? sent, int? received}) =>
      StationLogEntry(
        call: call,
        start: start,
        end: end ?? this.end,
        freqKhz: freqKhz,
        sent: sent ?? this.sent,
        received: received ?? this.received,
      );

  Map<String, dynamic> toJson() => {
    'call': call,
    'start': start.toUtc().toIso8601String(),
    'end': end.toUtc().toIso8601String(),
    if (freqKhz != null) 'khz': freqKhz,
    'sent': sent,
    'rcvd': received,
  };

  /// Null for a malformed entry, so one bad row doesn't lose the log.
  static StationLogEntry? fromJson(Object? j) {
    if (j is! Map) return null;
    final call = j['call'];
    final start = DateTime.tryParse('${j['start']}');
    final end = DateTime.tryParse('${j['end']}');
    if (call is! String || call.isEmpty || start == null || end == null) {
      return null;
    }
    return StationLogEntry(
      call: call,
      start: start.toUtc(),
      end: end.toUtc(),
      freqKhz: (j['khz'] as num?)?.toInt(),
      sent: (j['sent'] as num?)?.toInt() ?? 0,
      received: (j['rcvd'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is StationLogEntry &&
      other.call == call &&
      other.start == start &&
      other.end == end &&
      other.freqKhz == freqKhz &&
      other.sent == sent &&
      other.received == received;

  @override
  int get hashCode => Object.hash(call, start, end, freqKhz, sent, received);
}

/// The ADIF band for [khz]: the two bands the ham firmware allows.
String? bandFor(int? khz) {
  if (khz == null) return null;
  if (khz >= 420000 && khz <= 450000) return '70cm';
  if (khz >= 902000 && khz <= 928000) return '33cm';
  return null;
}

/// [log] (newest first) with a message to or from [call] at [at] added:
/// it extends the newest entry for [call] when that ended less than
/// [stationLogGap] earlier, and starts a new entry otherwise.
List<StationLogEntry> logMessage(
  List<StationLogEntry> log, {
  required String call,
  required DateTime at,
  required bool outgoing,
  int? freqKhz,
}) {
  final when = at.toUtc();
  final upper = call.toUpperCase();
  final i = log.indexWhere((e) => e.call == upper);
  if (i >= 0 && when.difference(log[i].end) < stationLogGap) {
    final e = log[i];
    final updated = e.copyWith(
      end: when.isAfter(e.end) ? when : e.end,
      sent: e.sent + (outgoing ? 1 : 0),
      received: e.received + (outgoing ? 0 : 1),
    );
    return [updated, ...log.sublist(0, i), ...log.sublist(i + 1)];
  }
  final entry = StationLogEntry(
    call: upper,
    start: when,
    end: when,
    freqKhz: freqKhz,
    sent: outgoing ? 1 : 0,
    received: outgoing ? 0 : 1,
  );
  final out = [entry, ...log];
  return out.length > stationLogMax ? out.sublist(0, stationLogMax) : out;
}

String _two(int n) => n.toString().padLeft(2, '0');
String _date(DateTime t) => '${t.year}${_two(t.month)}${_two(t.day)}';
String _time(DateTime t) => '${_two(t.hour)}${_two(t.minute)}${_two(t.second)}';

/// One ADIF field: `<NAME:length>value`, the length counted in bytes of the
/// ASCII value.
String _field(String name, String value) => '<$name:${value.length}>$value';

/// [log] as an ADIF 3.1 file (.adi), oldest first, for [stationCall].
///
/// ADIF has no LoRa mode, so MODE is left out rather than guessed; the
/// app-defined APP_NOTORYXHAM_MODE field and the comment say LoRa.
String stationLogAdif(
  List<StationLogEntry> log, {
  required String stationCall,
  required String programVersion,
  DateTime? now,
}) {
  final created = (now ?? DateTime.now()).toUtc();
  final b = StringBuffer()
    ..writeln('NOTORYX Core Ham station log')
    ..writeln(_field('ADIF_VER', '3.1.5'))
    ..writeln(_field('PROGRAMID', 'NOTORYX Core Ham'))
    ..writeln(_field('PROGRAMVERSION', programVersion))
    ..writeln(
      _field('CREATED_TIMESTAMP', '${_date(created)} ${_time(created)}'),
    )
    ..writeln('<EOH>');
  for (final e in log.reversed) {
    final s = e.start.toUtc(), t = e.end.toUtc();
    b
      ..write(_field('CALL', e.call))
      ..write(_field('QSO_DATE', _date(s)))
      ..write(_field('TIME_ON', _time(s)))
      ..write(_field('QSO_DATE_OFF', _date(t)))
      ..write(_field('TIME_OFF', _time(t)));
    if (e.band case final band?) b.write(_field('BAND', band));
    if (e.freqKhz case final khz?) {
      b.write(_field('FREQ', (khz / 1000).toStringAsFixed(3)));
    }
    if (stationCall.isNotEmpty) {
      b.write(_field('STATION_CALLSIGN', stationCall.toUpperCase()));
    }
    b
      ..write(_field('APP_NOTORYXHAM_MODE', 'LORA'))
      ..write(
        _field(
          'COMMENT',
          'MeshCore LoRa text, ${e.sent} sent, ${e.received} received',
        ),
      )
      ..writeln('<EOR>');
  }
  return b.toString();
}

/// [log] as CSV, newest first.
String stationLogCsv(List<StationLogEntry> log) {
  final b = StringBuffer(
    'call,start_utc,end_utc,band,frequency_mhz,sent,received\n',
  );
  for (final e in log) {
    // Call signs are letters and digits only, so no quoting is needed.
    final call = e.call.replaceAll(RegExp('[^A-Z0-9/-]'), '');
    b.writeln(
      [
        call,
        e.start.toUtc().toIso8601String(),
        e.end.toUtc().toIso8601String(),
        e.band ?? '',
        e.freqKhz == null ? '' : (e.freqKhz! / 1000).toStringAsFixed(3),
        e.sent,
        e.received,
      ].join(','),
    );
  }
  return b.toString();
}

/// One message an automation rule sent on air. Kept apart from the
/// exchanges above so the operator can always see what the station sent
/// without a person at the keyboard.
class AutomatedTransmission {
  const AutomatedTransmission({
    required this.at,
    required this.rule,
    required this.to,
    required this.text,
    this.station = '',
    this.freqKhz,
  });

  /// When it was handed to the radio, UTC.
  final DateTime at;

  /// The rule that sent it.
  final String rule;

  /// Where it went: a contact's name or a channel's name.
  final String to;

  /// The text sent, prefix included.
  final String text;

  /// This station's call sign at the time.
  final String station;
  final int? freqKhz;

  String? get band => bandFor(freqKhz);

  Map<String, dynamic> toJson() => {
    'at': at.toUtc().toIso8601String(),
    'rule': rule,
    'to': to,
    'text': text,
    'station': station,
    'khz': ?freqKhz,
  };

  static AutomatedTransmission? fromJson(Object? j) {
    if (j is! Map) return null;
    final at = DateTime.tryParse('${j['at']}');
    final rule = j['rule'], to = j['to'], text = j['text'];
    if (at == null || rule is! String || to is! String || text is! String) {
      return null;
    }
    return AutomatedTransmission(
      at: at.toUtc(),
      rule: rule,
      to: to,
      text: text,
      station: j['station'] as String? ?? '',
      freqKhz: (j['khz'] as num?)?.toInt(),
    );
  }
}

String _csvField(String v) =>
    // Formula characters are escaped so a spreadsheet shows the text.
    '"${(RegExp(r'^[=+\-@]').hasMatch(v) ? "'$v" : v).replaceAll('"', '""')}"';

/// [log] (newest first) as CSV.
String automatedTransmissionsCsv(List<AutomatedTransmission> log) {
  final b = StringBuffer('time_utc,station,rule,to,band,frequency_mhz,text\n');
  for (final e in log) {
    b.writeln(
      [
        e.at.toUtc().toIso8601String(),
        _csvField(e.station),
        _csvField(e.rule),
        _csvField(e.to),
        e.band ?? '',
        e.freqKhz == null ? '' : (e.freqKhz! / 1000).toStringAsFixed(3),
        _csvField(e.text),
      ].join(','),
    );
  }
  return b.toString();
}
