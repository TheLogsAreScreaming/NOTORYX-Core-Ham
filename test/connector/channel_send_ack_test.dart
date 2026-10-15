import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Answers every frame the way companion firmware answers
// CMD_SEND_CHANNEL_TXT_MSG: with RESP_CODE_OK (writeOKFrame).
class _OkRadioConnector extends MeshCoreConnector {
  final StreamController<Uint8List> _frames =
      StreamController<Uint8List>.broadcast();
  final List<Uint8List> sentFrames = [];

  @override
  bool get isConnected => true;

  @override
  Stream<Uint8List> get receivedFrames => _frames.stream;

  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sentFrames.add(frame);
    scheduleMicrotask(() => _frames.add(Uint8List.fromList([respCodeOk])));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test(
    'channel send completes on RESP_CODE_OK instead of timing out',
    () async {
      final connector = _OkRadioConnector();
      final channel = Channel(index: 0, name: 'Public', psk: Uint8List(16));

      // The command ack timeout is 5 s; an OK reply must finish well before it.
      await connector
          .sendChannelMessage(channel, 'hello')
          .timeout(const Duration(seconds: 2));
      await connector
          .sendChannelMessage(channel, 'again')
          .timeout(const Duration(seconds: 2));

      expect(
        connector.sentFrames.where((f) => f[0] == cmdSendChannelTxtMsg),
        hasLength(2),
      );
    },
  );
}
