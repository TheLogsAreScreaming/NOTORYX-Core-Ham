import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'meshcore_protocol.dart';

/// Host name that opens the demo radio instead of a network connection.
/// Never looked up or contacted.
const demoRadioHost = 'demo.notoryx';

/// Whether [host] is the demo radio rather than a real one.
bool isDemoRadioHost(String host) => host.trim().toLowerCase() == demoRadioHost;

class _Peer {
  const _Peer(this.seed, this.name, this.lat, this.lon, {this.type = 1});
  final int seed;
  final String name;
  final double lat;
  final double lon;

  /// 1 chat, 2 repeater, 3 room server.
  final int type;

  Uint8List get key =>
      Uint8List.fromList(List.generate(32, (i) => (seed * 7 + i * 13) & 0xff));
}

const _peers = [
  _Peer(1, 'Ridge Relay', 45.3735, -121.6959, type: 2),
  _Peer(2, 'Camp North', 45.3311, -121.7113),
  _Peer(3, 'Trailhead', 45.3012, -121.7550),
  _Peer(4, 'Fire Lookout', 45.4401, -121.6505, type: 2),
  _Peer(5, 'Valley Room', 45.2804, -121.6100, type: 3),
];

/// Shown as already received when the demo opens, oldest first, so the app
/// isn't empty: (channel, minutes ago, "Sender: text").
const _channelHistory = [
  (0, 95, 'Ann: morning all, heading up the north trail'),
  (0, 80, 'Bo: hut water is running, filter it anyway'),
  (1, 64, 'Cy: snow starts around the second switchback'),
  (0, 51, 'Dee: Ridge Relay is back up, signal is great'),
  (1, 37, 'Ann: passed the bridge, all good'),
  (0, 22, 'Cy: anyone near Fire Lookout? need a weather check'),
  (1, 9, 'Bo: clouds coming in from the west'),
];

/// Direct messages already received from Camp North: (minutes ago, text).
const _directHistory = [
  (44, 'Made it to camp, stove is going'),
  (12, 'Can you bring extra batteries tomorrow?'),
];

const _chatter = [
  'Ann: trail is clear to the second bridge',
  'Bo: water at the hut is running',
  'Cy: heading down before dark',
  'Ann: wind picking up on the ridge',
  'Dee: anyone near the lookout?',
];

const _replies = [
  'Copy that',
  'Got it, thanks',
  'On my way',
  'Signal is good here',
];

/// MeshCore's public channel key, the same on every radio.
const _publicChannelSecret = [
  0x8b, 0x33, 0x87, 0xe9, 0xc5, 0xcd, 0xea, 0x6a, //
  0xc9, 0xe5, 0xed, 0xba, 0xa1, 0x15, 0xcd, 0x72,
];

/// A pretend MeshCore companion radio that lives in the app.
///
/// It answers the app's commands like a v1.18 companion: its own identity,
/// five nearby nodes with positions, two channels with some history,
/// delivery confirmations, replies to direct messages and channel chatter.
/// Nothing is transmitted. Frames in and out are bare companion frames, the
/// same as a TCP or USB link carries once its framing is removed.
class DemoCompanion {
  DemoCompanion({
    this.chatter = const Duration(seconds: 25),
    Random? random,
    DateTime Function()? clock,
  }) : _random = random ?? Random(),
       _clock = clock ?? DateTime.now;

  /// How often someone on the public channel says something.
  final Duration chatter;
  final Random _random;
  final DateTime Function() _clock;

  final StreamController<Uint8List> _frames =
      StreamController<Uint8List>.broadcast();
  final List<Uint8List> _queue = [];
  final List<Timer> _timers = [];
  bool _connected = false;
  bool _directHistorySent = false;
  int _ack = 0x10000;
  int _chatIndex = 0;

  Stream<Uint8List> get frameStream => _frames.stream;
  bool get isConnected => _connected;
  String? get activeEndpoint => _connected ? demoRadioHost : null;

  int get _now => _clock().millisecondsSinceEpoch ~/ 1000;

  Future<void> connect() async {
    _queue.clear();
    _directHistorySent = false;
    for (final (channel, ago, text) in _channelHistory) {
      _queue.add(_channelMessage(channel, text, at: _now - ago * 60));
    }
    _connected = true;
    _timers.add(Timer.periodic(chatter, (_) => _say()));
  }

  Future<void> disconnect() async {
    for (final t in _timers) {
      t.cancel();
    }
    _timers.clear();
    _connected = false;
  }

  void dispose() {
    unawaited(disconnect());
    unawaited(_frames.close());
  }

  Future<void> write(Uint8List data) async {
    if (!_connected) throw StateError('Demo radio is not connected');
    if (data.isEmpty) return;
    final replies = _answer(data);
    scheduleMicrotask(() => replies.forEach(_deliver));
  }

  void _deliver(Uint8List frame) {
    if (_connected && !_frames.isClosed) _frames.add(frame);
  }

  void _later(Duration d, void Function() run) {
    _timers.add(
      Timer(d, () {
        if (_connected) run();
      }),
    );
  }

  void _queueMessage(Uint8List frame) {
    _queue.add(frame);
    _deliver(Uint8List.fromList([pushCodeMsgWaiting]));
  }

  void _say() {
    _queueMessage(_channelMessage(0, _chatter[_chatIndex++ % _chatter.length]));
  }

  List<Uint8List> _answer(Uint8List cmd) {
    switch (cmd.first) {
      case cmdAppStart:
        return [_selfInfo()];
      case cmdDeviceQuery:
        return [_deviceInfo()];
      case cmdSetDeviceTime || cmdSendSelfAdvert || cmdResetPath:
        return [_ok()];
      case cmdGetDeviceTime:
        return [
          (_Writer()
                ..u8(respCodeCurrTime)
                ..u32(_now))
              .bytes,
        ];
      case cmdGetContacts:
        // Direct messages wait until the app knows who sent them.
        if (!_directHistorySent) {
          _directHistorySent = true;
          _later(const Duration(milliseconds: 300), () {
            for (final (ago, text) in _directHistory) {
              _queueMessage(
                _directMessage(_peers[1], text, at: _now - ago * 60),
              );
            }
          });
        }
        return [
          (_Writer()
                ..u8(respCodeContactsStart)
                ..u32(_peers.length))
              .bytes,
          for (final p in _peers) _contact(p),
          (_Writer()
                ..u8(respCodeEndOfContacts)
                ..u32(_now))
              .bytes,
        ];
      case cmdGetChannel:
        return [_channel(cmd.length > 1 ? cmd[1] : 0)];
      case cmdSyncNextMessage:
        return [
          if (_queue.isNotEmpty)
            _queue.removeAt(0)
          else
            Uint8List.fromList([respCodeNoMoreMessages]),
        ];
      case cmdGetBattAndStorage:
        return [
          (_Writer()
                ..u8(respCodeBattAndStorage)
                ..u16(3900))
              .bytes,
        ];
      case cmdSendTxtMsg:
        return _direct(cmd);
      case cmdSendChannelTxtMsg:
        final channel = cmd.length > 2 ? cmd[2] : 0;
        _later(Duration(seconds: 3 + _random.nextInt(4)), () {
          _queueMessage(
            _channelMessage(
              channel,
              'Bo: ${_replies[_random.nextInt(_replies.length)]}',
            ),
          );
        });
        return [_ok()];
      default:
        // Settings, admin and the rest aren't part of the demo.
        return [
          Uint8List.fromList([respCodeErr, 1]),
        ];
    }
  }

  List<Uint8List> _direct(Uint8List cmd) {
    // [cmd, txt_type, attempt, u32 timestamp, 6-byte key prefix, text...]
    final prefix = cmd.length >= 13
        ? cmd.sublist(7, 13)
        : _peers[1].key.sublist(0, 6);
    final ack = _ack++;
    _later(const Duration(milliseconds: 1500), () {
      _deliver(
        (_Writer()
              ..u8(pushCodeSendConfirmed)
              ..u32(ack)
              ..u32(1400))
            .bytes,
      );
    });
    _later(Duration(seconds: 4 + _random.nextInt(4)), () {
      _queueMessage(
        _directPrefixMessage(
          prefix,
          _replies[_random.nextInt(_replies.length)],
          at: _now,
        ),
      );
    });
    return [
      (_Writer()
            ..u8(respCodeSent)
            ..u8(0)
            ..u32(ack)
            ..u32(9000))
          .bytes,
    ];
  }

  static Uint8List _ok() => Uint8List.fromList([respCodeOk]);

  static Uint8List _selfInfo() =>
      (_Writer()
            ..u8(respCodeSelfInfo)
            ..u8(1)
            ..u8(22)
            ..u8(30)
            ..raw(List.generate(32, (i) => (0x51 + i * 3) & 0xff))
            ..i32(45330000)
            ..i32(-121720000)
            ..u8(0)
            ..u8(1)
            ..u8(0x15)
            ..u8(0)
            ..u32(910525)
            ..u32(62500)
            ..u8(7)
            ..u8(5)
            ..raw(utf8.encode('Demo Radio')))
          .bytes;

  static Uint8List _deviceInfo() =>
      (_Writer()
            ..u8(respCodeDeviceInfo)
            ..u8(14)
            ..u8(175)
            ..u8(8)
            ..u32(0)
            ..fixed('01 Nov 2026', 12)
            ..fixed('Demo radio', 40)
            ..fixed('v1.18.0', 20)
            ..u8(0)
            ..u8(0))
          .bytes;

  Uint8List _contact(_Peer p) =>
      (_Writer()
            ..u8(respCodeContact)
            ..raw(p.key)
            ..u8(p.type)
            ..u8(0)
            ..u8(p.type == 1 ? 1 : 0)
            ..raw(Uint8List(64))
            ..fixed(p.name, 32)
            ..u32(_now - 600)
            ..i32((p.lat * 1e6).round())
            ..i32((p.lon * 1e6).round())
            ..u32(_now - 600))
          .bytes;

  static Uint8List _channel(int index) {
    if (index >= 8) return Uint8List.fromList([respCodeErr, 2]);
    final (name, secret) = switch (index) {
      0 => ('Public', _publicChannelSecret),
      1 => ('#trail', _hashtagSecret('#trail')),
      _ => ('', List<int>.filled(16, 0)),
    };
    return (_Writer()
          ..u8(respCodeChannelInfo)
          ..u8(index)
          ..fixed(name, 32)
          ..raw(secret))
        .bytes;
  }

  /// A stand-in key for the demo's hashtag channel. Real hashtag channels
  /// derive theirs from the name; the demo never transmits, so any fixed
  /// non-zero key will do.
  static List<int> _hashtagSecret(String name) {
    final out = List<int>.filled(16, 0);
    final b = utf8.encode(name);
    for (var i = 0; i < 16; i++) {
      out[i] = (b[i % b.length] * 31 + i * 17 + 7) & 0xff;
    }
    return out;
  }

  Uint8List _channelMessage(int channel, String text, {int? at}) =>
      (_Writer()
            ..u8(respCodeChannelMsgRecvV3)
            ..u8((7 * 4) & 0xff)
            ..u8(0)
            ..u8(0)
            ..u8(channel)
            ..u8(1)
            ..u8(txtTypePlain)
            ..u32(at ?? _now)
            ..raw(utf8.encode(text)))
          .bytes;

  Uint8List _directMessage(_Peer from, String text, {required int at}) =>
      _directPrefixMessage(from.key.sublist(0, 6), text, at: at);

  static Uint8List _directPrefixMessage(
    List<int> prefix,
    String text, {
    required int at,
  }) =>
      (_Writer()
            ..u8(respCodeContactMsgRecvV3)
            ..u8((6 * 4) & 0xff)
            ..u8(0)
            ..u8(0)
            ..raw(prefix)
            ..u8(1)
            ..u8(txtTypePlain)
            ..u32(at)
            ..raw(utf8.encode(text)))
          .bytes;
}

/// Little-endian frame builder.
class _Writer {
  final BytesBuilder _b = BytesBuilder();

  Uint8List get bytes => _b.toBytes();

  void u8(int v) => _b.addByte(v & 0xff);

  void u16(int v) {
    u8(v);
    u8(v >> 8);
  }

  void u32(int v) {
    final d = ByteData(4)..setUint32(0, v & 0xffffffff, Endian.little);
    _b.add(d.buffer.asUint8List());
  }

  void i32(int v) {
    final d = ByteData(4)..setInt32(0, v, Endian.little);
    _b.add(d.buffer.asUint8List());
  }

  void raw(List<int> v) => _b.add(v);

  /// [s] as UTF-8, cut or zero-padded to exactly [len] bytes.
  void fixed(String s, int len) {
    final enc = utf8.encode(s);
    final out = Uint8List(len)
      ..setRange(0, min(enc.length, len), enc.take(len));
    _b.add(out);
  }
}
