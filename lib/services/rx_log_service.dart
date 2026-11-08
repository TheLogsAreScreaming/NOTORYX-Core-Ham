import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_protocol.dart';
import '../models/mqtt_mesh_packet.dart';
import '../models/radio_rx_packet.dart';

/// What kind of packet an RX log row is, for filtering and labels.
enum RxKind { advert, channel, direct, ack, path, trace, control, other }

/// Sorts a MeshCore payload type into an [RxKind].
RxKind rxKindFor(int payloadType) => switch (payloadType) {
  payloadTypeADVERT => RxKind.advert,
  payloadTypeGRPTXT || payloadTypeGRPDATA => RxKind.channel,
  payloadTypeTXTMSG ||
  payloadTypeREQ ||
  payloadTypeRESPONSE ||
  payloadTypeANONREQ ||
  payloadTypeMULTIPART => RxKind.direct,
  payloadTypeACK => RxKind.ack,
  payloadTypePATH => RxKind.path,
  payloadTypeTRACE => RxKind.trace,
  payloadTypeCONTROL => RxKind.control,
  _ => RxKind.other,
};

/// One packet the radio heard, with its header decoded.
@immutable
class RxLogEntry {
  const RxLogEntry({
    required this.receivedAt,
    required this.snr,
    required this.rssi,
    required this.raw,
    required this.info,
    this.fromSelf = false,
  });

  /// Decodes [packet]; null when its header is malformed.
  static RxLogEntry? from(RadioRxPacket packet) {
    final info = MeshPacketInfo.tryParse(packet.raw);
    if (info == null) return null;
    return RxLogEntry(
      receivedAt: packet.receivedAt,
      snr: packet.snr,
      rssi: packet.rssi,
      raw: packet.raw,
      info: info,
      fromSelf: packet.fromSelf,
    );
  }

  final DateTime receivedAt;
  final double snr;
  final int rssi;
  final Uint8List raw;
  final MeshPacketInfo info;

  /// Whether this looks like this radio's own traffic heard back.
  final bool fromSelf;

  RxKind get kind => rxKindFor(info.payloadType);

  /// Flood (0, 1) or source-routed (2, 3).
  bool get isDirect => info.isDirect;

  int get hops => info.hopCount;

  /// The path as upper-case hex hashes, for example `A1 → 3F`.
  List<String> get pathHashes {
    final width = info.pathHashWidth;
    final path = info.path;
    return [
      for (var i = 0; i + width <= path.length; i += width)
        hex(Uint8List.sublistView(path, i, i + width)),
    ];
  }

  /// [bytes] as upper-case hex with no separators.
  static String hex(Uint8List bytes) => bytes
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join()
      .toUpperCase();
}

/// Keeps the last [capacity] packets the radio heard, newest first, in
/// memory only. Nothing is stored or sent anywhere.
class RxLogService extends ChangeNotifier {
  RxLogService(Stream<RadioRxPacket> packets, {this.capacity = 2000})
    : assert(capacity > 0) {
    _subscription = packets.listen(add);
  }

  final int capacity;
  late final StreamSubscription<RadioRxPacket> _subscription;
  final ListQueue<RxLogEntry> _entries = ListQueue();
  Timer? _notifyTimer;
  bool _paused = false;
  int _total = 0;

  /// Newest first.
  List<RxLogEntry> get entries => List.unmodifiable(_entries);

  /// Whether new packets are being ignored.
  bool get paused => _paused;

  /// Packets logged since the app started or the log was cleared.
  int get total => _total;

  set paused(bool value) {
    if (_paused == value) return;
    _paused = value;
    notifyListeners();
  }

  /// Logs [packet] unless paused or malformed.
  @visibleForTesting
  void add(RadioRxPacket packet) {
    if (_paused) return;
    final entry = RxLogEntry.from(packet);
    if (entry == null) return;
    _entries.addFirst(entry);
    while (_entries.length > capacity) {
      _entries.removeLast();
    }
    _total++;
    // A busy mesh can deliver many packets a second; redraw at most 4 times.
    _notifyTimer ??= Timer(const Duration(milliseconds: 250), () {
      _notifyTimer = null;
      notifyListeners();
    });
  }

  void clear() {
    _entries.clear();
    _total = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _notifyTimer?.cancel();
    unawaited(_subscription.cancel());
    super.dispose();
  }
}

/// [entries] as CSV, oldest first, with the raw packet in hex.
String rxLogCsv(Iterable<RxLogEntry> entries) {
  final rows = <String>[
    'time_utc,kind,payload_type,route,hops,path,snr,rssi,bytes,hash,own,raw_hex',
  ];
  for (final e in entries.toList().reversed) {
    rows.add(
      [
        e.receivedAt.toUtc().toIso8601String(),
        e.kind.name,
        e.info.payloadType,
        e.isDirect ? 'direct' : 'flood',
        e.hops,
        e.pathHashes.join(' '),
        e.snr.toStringAsFixed(2),
        e.rssi,
        e.raw.length,
        e.info.hash,
        e.fromSelf ? 1 : 0,
        RxLogEntry.hex(e.raw),
      ].join(','),
    );
  }
  return '${rows.join('\n')}\n';
}
