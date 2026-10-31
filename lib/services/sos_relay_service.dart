import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/field_ops.dart';
import '../models/heard_channel_packet.dart';
import '../models/radio_rx_packet.dart';
import '../storage/prefs_manager.dart';
import '../utils/app_logger.dart';

/// SOS relay: passes on an SOS that no repeater seems to have carried.
///
/// A hiker in range of both an injured friend and a repeater is often the
/// only link between them. When this phone hears an SOS straight from the
/// sender's radio (no hops) and then hears no other copy of it before
/// [waitForRepeater] plus a random jitter runs out, it transmits the packet
/// once, byte for byte. The SOS signature packet that follows it is relayed
/// the same way, so the relayed SOS still verifies as the sender's.
///
/// Any second copy of a packet, whether from a repeater or another phone
/// relaying it, cancels the relay. Repeaters drop packets they have already
/// forwarded, so a relay can't loop. Off by default: it costs battery and
/// airtime, and needs firmware v1.16 or newer.
class SosRelayService extends ChangeNotifier {
  SosRelayService({
    required Stream<RadioRxPacket> packets,
    required HeardChannelPacket? Function(Uint8List raw) decode,
    required bool Function() canSend,
    required Future<void> Function(Uint8List raw) send,
    this.waitForRepeater = const Duration(seconds: 12),
    this.maxJitter = const Duration(seconds: 6),
    DateTime Function()? clock,
    math.Random? random,
  }) : _packets = packets,
       _decode = decode,
       _canSend = canSend,
       _send = send,
       _now = clock ?? DateTime.now,
       _random = random ?? math.Random();

  SosRelayService.forConnector(MeshCoreConnector connector)
    : this(
        packets: connector.rxPackets,
        decode: connector.decodeHeardChannelPacket,
        canSend: () => connector.supportsRawPacketSend,
        send: connector.sendRawPacket,
      );

  static const _key = 'notoryx_sos_relay_v1';

  /// At most this many relays in [rateWindow], however many SOS are heard.
  static const maxRelays = 12;
  static const rateWindow = Duration(minutes: 10);

  /// Packet hashes remembered as handled, so a late copy isn't relayed.
  static const _maxRemembered = 500;

  final Stream<RadioRxPacket> _packets;
  final HeardChannelPacket? Function(Uint8List raw) _decode;
  final bool Function() _canSend;
  final Future<void> Function(Uint8List raw) _send;
  final DateTime Function() _now;
  final math.Random _random;

  /// How long to listen for a repeater's copy before relaying.
  final Duration waitForRepeater;

  /// Up to this much extra wait, so phones that heard the same SOS don't
  /// all transmit at once. The first one's copy cancels the rest.
  final Duration maxJitter;

  bool _enabled = false;
  bool _disposed = false;
  StreamSubscription<RadioRxPacket>? _subscription;
  final Map<String, Timer> _pending = {};
  final LinkedHashSet<String> _handled = LinkedHashSet();

  /// "channel:timestamp" of SOS texts heard first-hand, so their signature
  /// packets can be matched to them.
  final LinkedHashSet<String> _sosStamps = LinkedHashSet();
  final List<DateTime> _relayTimes = [];

  int _relayed = 0;
  DateTime? _lastRelayAt;
  String? _lastRelayFrom;

  bool get enabled => _enabled;

  /// SOS packets (texts and signatures) relayed since the app started.
  int get relayed => _relayed;
  DateTime? get lastRelayAt => _lastRelayAt;

  /// Sender name of the last SOS text relayed.
  String? get lastRelayFrom => _lastRelayFrom;

  /// Whether the connected radio can relay (firmware v1.16+).
  bool get radioSupported => _canSend();

  void load() {
    try {
      _enabled = PrefsManager.instance.getBool(_key) ?? false;
    } catch (_) {
      _enabled = false;
    }
    if (_enabled) _listen();
  }

  Future<void> setEnabled(bool on) async {
    if (on == _enabled) return;
    _enabled = on;
    if (on) {
      _listen();
    } else {
      _stop();
    }
    _notify();
    await PrefsManager.instance.setBool(_key, on);
  }

  void _listen() {
    _subscription ??= _packets.listen(_onPacket);
  }

  void _stop() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    for (final timer in _pending.values) {
      timer.cancel();
    }
    _pending.clear();
  }

  void _onPacket(RadioRxPacket rx) {
    if (rx.fromSelf) return;
    final heard = _decode(rx.raw);
    if (heard == null) return;
    final hash = heard.packetHash;
    if (_handled.contains(hash)) return;

    final waiting = _pending.remove(hash);
    if (waiting != null) {
      // A second copy: a repeater or another phone already carried it.
      waiting.cancel();
      _remember(_handled, hash);
      return;
    }

    final stamp = '${heard.channelIndex}:${heard.timestamp}';
    if (heard.isText ? !isSosText(heard.text!) : !_sosStamps.contains(stamp)) {
      return; // not an SOS, or a signature for one not heard first-hand
    }
    if (heard.hopCount > 0) {
      // Already went through a repeater before it reached this phone.
      _remember(_handled, hash);
      return;
    }
    if (heard.isText) _remember(_sosStamps, stamp);

    final jitter = maxJitter.inMilliseconds <= 0
        ? Duration.zero
        : Duration(milliseconds: _random.nextInt(maxJitter.inMilliseconds));
    final raw = Uint8List.fromList(rx.raw);
    _pending[hash] = Timer(
      waitForRepeater + jitter,
      () => unawaited(_relay(hash, raw, heard)),
    );
  }

  Future<void> _relay(
    String hash,
    Uint8List raw,
    HeardChannelPacket heard,
  ) async {
    _pending.remove(hash);
    _remember(_handled, hash);
    if (!_enabled || _disposed) return;
    final now = _now();
    _relayTimes.removeWhere((t) => now.difference(t) >= rateWindow);
    if (_relayTimes.length >= maxRelays) {
      appLogger.warn('SOS relay: rate limit reached, not relaying $hash');
      return;
    }
    if (!_canSend()) {
      appLogger.warn('SOS relay: radio cannot send raw packets');
      return;
    }
    try {
      await _send(raw);
      _relayTimes.add(now);
      _relayed++;
      _lastRelayAt = now;
      if (heard.isText) _lastRelayFrom = heard.senderName;
      appLogger.info('SOS relay: relayed $hash');
      _notify();
    } catch (e) {
      appLogger.warn('SOS relay: could not relay $hash: $e');
    }
  }

  void _remember(LinkedHashSet<String> set, String value) {
    set.remove(value);
    set.add(value);
    while (set.length > _maxRemembered) {
      set.remove(set.first);
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _stop();
    super.dispose();
  }
}
