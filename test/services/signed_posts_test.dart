import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/services/signed_posts.dart';
import 'package:meshcore_open/storage/channel_message_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _ts = 1793210400; // 28 Oct 2026 18:00 UTC

class _Signer {
  _Signer(this.pair, this.publicKey);
  final SimpleKeyPair pair;
  final Uint8List publicKey;

  static Future<_Signer> create(int seed) async {
    final pair = await Ed25519().newKeyPairFromSeed(
      List.generate(32, (i) => (i * 7 + seed) & 0xFF),
    );
    final pub = await pair.extractPublicKey();
    return _Signer(pair, Uint8List.fromList(pub.bytes));
  }

  Future<Uint8List> sign(List<int> data) async =>
      Uint8List.fromList((await Ed25519().sign(data, keyPair: pair)).bytes);

  Future<SignedPostPayload> post(String name, String text, {int ts = _ts}) =>
      sign(signedPostInput(timestamp: ts, senderName: name, text: text)).then(
        (sig) => SignedPostPayload(
          publicKey: publicKey,
          timestamp: ts,
          signature: sig,
        ),
      );
}

Contact _contact(Uint8List key, String name) => Contact(
  publicKey: key,
  name: name,
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

ChannelMessage _msg({
  ChannelSignature signature = ChannelSignature.valid,
  Uint8List? signerKey,
  String sender = 'Alice',
}) => ChannelMessage(
  senderName: sender,
  text: 'hello',
  timestamp: DateTime.now(),
  isOutgoing: false,
  signature: signature,
  signerKey: signerKey,
);

Uint8List _textFrame(int channel, String line, {int ts = _ts}) {
  final w = BufferWriter()
    ..writeByte(respCodeChannelMsgRecv)
    ..writeByte(channel)
    ..writeByte(0)
    ..writeByte(txtTypePlain)
    ..writeUInt32LE(ts)
    ..writeString(line)
    ..writeByte(0);
  return w.toBytes();
}

Uint8List _dataFrame(int channel, Uint8List payload) => Uint8List.fromList([
  27, // RESP_CODE_CHANNEL_DATA_RECV
  0,
  0,
  0,
  channel,
  0,
  dataTypeSignedPost & 0xFF,
  dataTypeSignedPost >> 8,
  payload.length,
  ...payload,
]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the signed bytes are tag, timestamp and "name: text"', () {
    final input = signedPostInput(
      timestamp: 0x01020304,
      senderName: 'Alice',
      text: 'hi',
    );
    expect(input, [
      ...utf8.encode('notoryx-sig/1\n'),
      4,
      3,
      2,
      1,
      ...utf8.encode('Alice: hi'),
    ]);
  });

  test('canSignAs refuses names receivers would split differently', () {
    expect(canSignAs('Alice'), isTrue);
    expect(canSignAs('A:B'), isFalse);
    expect(canSignAs('[base]'), isFalse);
    expect(canSignAs(''), isFalse);
    expect(canSignAs('x' * 50), isFalse);
  });

  test('payload round-trips in 101 bytes and refuses other versions', () {
    final p = SignedPostPayload(
      publicKey: Uint8List.fromList(List.generate(32, (i) => i)),
      timestamp: _ts,
      signature: Uint8List.fromList(List.generate(64, (i) => 255 - i)),
    );
    final bytes = p.encode();
    expect(bytes.length, signedPostPayloadBytes);
    expect(signedPostPayloadBytes, lessThanOrEqualTo(163));
    final back = SignedPostPayload.decode(bytes)!;
    expect(back.publicKey, p.publicKey);
    expect(back.timestamp, _ts);
    expect(back.signature, p.signature);
    expect(
      SignedPostPayload.decode(Uint8List.fromList([2, ...bytes.skip(1)])),
      isNull,
    );
    expect(SignedPostPayload.decode(bytes.sublist(0, 100)), isNull);
  });

  group('verifySignedPost', () {
    test('accepts the post it signed', () async {
      final alice = await _Signer.create(1);
      final p = await alice.post('Alice', 'SOS at the ridge');
      expect(
        await verifySignedPost(
          p,
          senderName: 'Alice',
          text: 'SOS at the ridge',
        ),
        isTrue,
      );
    });

    test('rejects a changed text, a changed name, or another key', () async {
      final alice = await _Signer.create(1);
      final bob = await _Signer.create(2);
      final p = await alice.post('Alice', 'SOS at the ridge');
      expect(
        await verifySignedPost(p, senderName: 'Alice', text: 'SOS at the lake'),
        isFalse,
      );
      expect(
        await verifySignedPost(p, senderName: 'Bob', text: 'SOS at the ridge'),
        isFalse,
      );
      final swapped = SignedPostPayload(
        publicKey: bob.publicKey,
        timestamp: _ts,
        signature: p.signature,
      );
      expect(
        await verifySignedPost(
          swapped,
          senderName: 'Alice',
          text: 'SOS at the ridge',
        ),
        isFalse,
      );
    });
  });

  group('PendingSignatures', () {
    SignedPostPayload payload(int ts, int fill) => SignedPostPayload(
      publicKey: Uint8List(32),
      timestamp: ts,
      signature: Uint8List(64)..fillRange(0, 64, fill),
    );

    test('matches by channel and timestamp, once', () {
      final held = PendingSignatures();
      final now = DateTime(2026, 10, 28, 18);
      final a = payload(_ts, 1);
      held.add(0, a, now);
      held.add(0, a, now); // the same packet heard twice
      held.add(1, payload(_ts, 2), now);
      expect(held.length, 2);
      expect(held.candidates(0, _ts, now), [a]);
      expect(held.candidates(0, _ts + 1, now), isEmpty);
      held.remove(a);
      expect(held.candidates(0, _ts, now), isEmpty);
    });

    test('forgets signatures after maxAge', () {
      final held = PendingSignatures(maxAge: const Duration(minutes: 10));
      final now = DateTime(2026, 10, 28, 18);
      held.add(0, payload(_ts, 1), now);
      expect(
        held.candidates(0, _ts, now.add(const Duration(minutes: 11))),
        isEmpty,
      );
    });
  });

  group('signatureBadgeFor', () {
    final key = Uint8List.fromList(List.filled(32, 9));
    final other = Uint8List.fromList(List.filled(32, 8));

    test('unsigned posts get no badge, failed checks say unverified', () {
      expect(
        signatureBadgeFor(_msg(signature: ChannelSignature.none), []),
        isNull,
      );
      expect(
        signatureBadgeFor(_msg(signature: ChannelSignature.invalid), [])!.badge,
        SignatureBadge.unverified,
      );
    });

    test('a contact\'s key shows that contact', () {
      final b = signatureBadgeFor(_msg(signerKey: key), [
        _contact(key, 'Alice (base)'),
      ])!;
      expect(b.badge, SignatureBadge.known);
      expect(b.signer, 'Alice (base)');
    });

    test('your own key counts as known', () {
      final b = signatureBadgeFor(_msg(signerKey: key), [], selfKey: key)!;
      expect(b.badge, SignatureBadge.known);
    });

    test('an unknown key is signed but not known', () {
      expect(
        signatureBadgeFor(_msg(signerKey: key), [
          _contact(other, 'Bob'),
        ])!.badge,
        SignatureBadge.unknownKey,
      );
    });

    test('an unknown key using a contact\'s name is unverified', () {
      expect(
        signatureBadgeFor(_msg(signerKey: key), [
          _contact(other, 'Alice'),
        ])!.badge,
        SignatureBadge.unverified,
      );
    });
  });

  group('connector', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    Future<ChannelMessage> settle(MeshCoreConnector c) async {
      for (var i = 0; i < 20; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
      }
      return c
          .getChannelMessages(
            Channel(index: 0, name: 'Public', psk: Uint8List(16)),
          )
          .single;
    }

    test('the signature check survives a restart', () async {
      final store = ChannelMessageStore()..setPublicKeyHex = 'a1b2c3d4e5f6';
      final key = Uint8List.fromList(List.filled(32, 3));
      await store.saveChannelMessages(0, [
        _msg(signerKey: key),
        _msg(signature: ChannelSignature.none, sender: 'Bob'),
      ]);
      final back = await store.loadChannelMessages(0);
      expect(back.first.signature, ChannelSignature.valid);
      expect(back.first.signerKey, key);
      expect(back.last.signature, ChannelSignature.none);
      expect(back.last.signerKey, isNull);
    });

    test('signature after the text', () async {
      final alice = await _Signer.create(1);
      final c = MeshCoreConnector();
      c.handleFrameForTest(_textFrame(0, 'Alice: hello'));
      c.handleFrameForTest(
        _dataFrame(0, (await alice.post('Alice', 'hello')).encode()),
      );
      final m = await settle(c);
      expect(m.signature, ChannelSignature.valid);
      expect(m.signerKey, alice.publicKey);
    });

    test('signature before the text', () async {
      final alice = await _Signer.create(1);
      final c = MeshCoreConnector();
      c.handleFrameForTest(
        _dataFrame(0, (await alice.post('Alice', 'hello')).encode()),
      );
      await Future<void>.delayed(const Duration(milliseconds: 20));
      c.handleFrameForTest(_textFrame(0, 'Alice: hello'));
      final m = await settle(c);
      expect(m.signature, ChannelSignature.valid);
    });

    test('a signature for different words marks the post unverified', () async {
      final alice = await _Signer.create(1);
      final c = MeshCoreConnector();
      c.handleFrameForTest(_textFrame(0, 'Alice: all clear'));
      c.handleFrameForTest(
        _dataFrame(0, (await alice.post('Alice', 'hello')).encode()),
      );
      final m = await settle(c);
      expect(m.signature, ChannelSignature.invalid);
    });

    test('an unsigned post stays unsigned', () async {
      final c = MeshCoreConnector();
      c.handleFrameForTest(_textFrame(0, 'Alice: hello'));
      expect((await settle(c)).signature, ChannelSignature.none);
    });
  });

  test('a signed send puts a verifiable signature on air', () async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final me = await _Signer.create(5);
    final radio = _SigningRadio(me);
    final channel = Channel(index: 2, name: 'Ops', psk: Uint8List(16));

    await radio
        .sendChannelMessage(channel, 'SOS at the ridge', sign: true)
        .timeout(const Duration(seconds: 3));

    final text = radio.sent.firstWhere((f) => f[0] == cmdSendChannelTxtMsg);
    final ts = ByteData.sublistView(text, 3, 7).getUint32(0, Endian.little);
    final data = radio.sent.firstWhere((f) => f[0] == 62);
    expect(data[1], 2); // channel
    expect(data[3] | (data[4] << 8), dataTypeSignedPost);
    final payload = SignedPostPayload.decode(data.sublist(5))!;
    expect(payload.timestamp, ts);
    expect(payload.publicKey, me.publicKey);
    expect(
      await verifySignedPost(
        payload,
        senderName: 'Me Radio',
        text: 'SOS at the ridge',
      ),
      isTrue,
    );
    final mine = radio.getChannelMessages(channel).single;
    expect(mine.signature, ChannelSignature.valid);
  });

  test('an unsigned send sends no signature', () async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final radio = _SigningRadio(await _Signer.create(5));
    await radio
        .sendChannelMessage(
          Channel(index: 0, name: 'Public', psk: Uint8List(16)),
          'hello',
        )
        .timeout(const Duration(seconds: 3));
    expect(radio.sent.where((f) => f[0] == 62), isEmpty);
  });
}

/// Answers like companion firmware: OK for sends, and a real Ed25519
/// signature over whatever was streamed with CMD_SIGN_DATA.
class _SigningRadio extends MeshCoreConnector {
  _SigningRadio(this.signer);
  final _Signer signer;
  final _frames = StreamController<Uint8List>.broadcast();
  final sent = <Uint8List>[];
  final _buffer = <int>[];

  @override
  bool get isConnected => true;
  @override
  bool get supportsChannelData => true;
  @override
  Uint8List? get selfPublicKey => signer.publicKey;
  @override
  String? get selfName => 'Me Radio';
  @override
  Stream<Uint8List> get receivedFrames => _frames.stream;

  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(frame);
    Future<Uint8List> reply() async {
      switch (frame[0]) {
        case cmdSignStart:
          _buffer.clear();
          return Uint8List.fromList([respCodeSignStart, 0, 0, 2, 0, 0]);
        case cmdSignData:
          _buffer.addAll(frame.skip(1));
          return Uint8List.fromList([respCodeOk]);
        case cmdSignFinish:
          return Uint8List.fromList([
            respCodeSignature,
            ...await signer.sign(_buffer),
          ]);
        default:
          return Uint8List.fromList([respCodeOk]);
      }
    }

    unawaited(reply().then(_frames.add));
  }
}
