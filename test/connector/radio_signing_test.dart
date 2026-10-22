import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/connector/radio_signing.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Plays the companion firmware's side of CMD_SIGN_* (MyMesh.cpp).
class _FakeRadio {
  _FakeRadio(this.connector, {this.maxLength = 8 * 1024});

  final MeshCoreConnector connector;
  final int maxLength;
  final List<Uint8List> sent = [];
  final List<int> buffered = [];
  List<int>? Function(Uint8List frame)? override;
  bool silent = false;

  static final signature = Uint8List.fromList(List.generate(64, (i) => i));

  Future<void> write(Uint8List frame) async {
    sent.add(frame);
    if (silent) return;
    final reply = override?.call(frame) ?? _reply(frame);
    if (reply != null) {
      scheduleMicrotask(() => connector.handleFrameForTest(reply));
    }
  }

  List<int>? _reply(Uint8List frame) {
    switch (frame[0]) {
      case cmdSignStart:
        buffered.clear();
        final max = ByteData(4)..setUint32(0, maxLength, Endian.little);
        return [respCodeSignStart, 0, ...max.buffer.asUint8List()];
      case cmdSignData:
        buffered.addAll(frame.sublist(1));
        return [respCodeOk];
      case cmdSignFinish:
        return [respCodeSignature, ...signature];
    }
    return null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MeshCoreConnector connector;
  late _FakeRadio radio;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    connector = MeshCoreConnector();
    radio = _FakeRadio(connector);
    connector.debugSignFrameWriter = radio.write;
  });

  test('frames start, 128-byte data chunks and finish', () async {
    final data = Uint8List.fromList(List.generate(300, (i) => i % 251));
    final signature = await connector.signWithRadio(data);

    expect(signature, _FakeRadio.signature);
    expect(radio.sent.map((f) => f[0]), [
      cmdSignStart,
      cmdSignData,
      cmdSignData,
      cmdSignData,
      cmdSignFinish,
    ]);
    expect(radio.sent.first, [33]);
    expect(radio.sent.last, [35]);
    expect(radio.sent[1], [34, ...data.sublist(0, 128)]);
    expect(radio.sent[2], [34, ...data.sublist(128, 256)]);
    expect(radio.sent[3], [34, ...data.sublist(256)]);
    expect(radio.buffered, data);
  });

  test('parses the sign start and signature replies', () {
    expect(
      parseSignStartFrame(Uint8List.fromList([19, 0, 0x00, 0x20, 0, 0])),
      8192,
    );
    expect(parseSignStartFrame(Uint8List.fromList([19, 0, 0])), isNull);
    expect(
      parseSignatureFrame(Uint8List.fromList([20, ..._FakeRadio.signature])),
      _FakeRadio.signature,
    );
    expect(parseSignatureFrame(Uint8List.fromList([20, 1, 2])), isNull);
  });

  test('ignores an earlier command\'s OK while waiting to start', () async {
    // The start reply is held back; an unrelated OK arrives first.
    radio.override = (frame) {
      if (frame[0] != cmdSignStart) return null;
      connector.handleFrameForTest([respCodeOk]);
      return const [];
    };
    final pending = connector.signWithRadio(Uint8List.fromList([1, 2, 3]));
    await pumpEventQueue();
    expect(radio.sent, hasLength(1));
    radio.override = null;
    connector.handleFrameForTest([respCodeSignStart, 0, 0, 0x20, 0, 0]);
    expect(await pending, _FakeRadio.signature);
    expect(radio.sent.map((f) => f[0]), [
      cmdSignStart,
      cmdSignData,
      cmdSignFinish,
    ]);
  });

  test('reports firmware without the sign commands', () async {
    radio.override = (_) => [respCodeErr, errCodeUnsupportedCmd];
    await expectLater(
      connector.signWithRadio(Uint8List.fromList([1])),
      throwsA(
        isA<RadioSigningException>()
            .having(
              (e) => e.failure,
              'failure',
              RadioSigningFailure.unsupported,
            )
            .having((e) => e.retryable, 'retryable', isFalse),
      ),
    );
    expect(radio.sent, hasLength(1));
  });

  test('times out when the radio never answers', () async {
    radio.silent = true;
    await expectLater(
      connector.signWithRadio(
        Uint8List.fromList([1]),
        timeout: const Duration(milliseconds: 20),
      ),
      throwsA(
        isA<RadioSigningException>().having(
          (e) => e.failure,
          'failure',
          RadioSigningFailure.timeout,
        ),
      ),
    );
  });

  test('refuses data longer than the radio allows', () async {
    radio = _FakeRadio(connector, maxLength: 4);
    connector.debugSignFrameWriter = radio.write;
    await expectLater(
      connector.signWithRadio(Uint8List(5)),
      throwsA(
        isA<RadioSigningException>().having(
          (e) => e.failure,
          'failure',
          RadioSigningFailure.tooLong,
        ),
      ),
    );
    expect(radio.sent.map((f) => f[0]), [cmdSignStart]);
  });

  test('fails when a data chunk is rejected', () async {
    radio.override = (frame) =>
        frame[0] == cmdSignData ? [respCodeErr, 3] : null;
    await expectLater(
      connector.signWithRadio(Uint8List(10)),
      throwsA(
        isA<RadioSigningException>().having(
          (e) => e.failure,
          'failure',
          RadioSigningFailure.rejected,
        ),
      ),
    );
  });

  test('needs a connected radio', () async {
    connector.debugSignFrameWriter = null;
    await expectLater(
      connector.signWithRadio(Uint8List(1)),
      throwsA(
        isA<RadioSigningException>().having(
          (e) => e.failure,
          'failure',
          RadioSigningFailure.notConnected,
        ),
      ),
    );
  });

  test('runs one signing at a time', () async {
    final first = connector.signWithRadio(Uint8List.fromList([1]));
    final second = connector.signWithRadio(Uint8List.fromList([2]));
    await Future.wait([first, second]);
    expect(radio.sent.map((f) => f[0]), [
      cmdSignStart,
      cmdSignData,
      cmdSignFinish,
      cmdSignStart,
      cmdSignData,
      cmdSignFinish,
    ]);
  });
}
