import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/access_control.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/path_selection.dart';
import 'package:meshcore_open/services/access_control_service.dart';
import 'package:meshcore_open/services/repeater_command_service.dart';

// Answers a binary request the way repeater firmware does: RESP_CODE_SENT
// with a tag, then a binary response carrying the same tag.
class _FakeRadio extends MeshCoreConnector {
  _FakeRadio({this.reply, this.answer = true});

  final Uint8List? reply;
  final bool answer;
  final List<Uint8List> sent = [];
  final List<bool> pathResults = [];
  final _frames = StreamController<Uint8List>.broadcast();

  @override
  bool get isConnected => true;

  @override
  Stream<Uint8List> get receivedFrames => _frames.stream;

  @override
  Future<PathSelection> preparePathForContactSend(Contact contact) async =>
      const PathSelection(pathBytes: [], hopCount: 0, useFlood: false);

  @override
  int calculateTimeout({
    required int pathLength,
    int messageBytes = 100,
    String? contactKey,
    int? deviceTimeoutMs,
  }) => 300;

  @override
  void recordRepeaterPathResult(
    Contact contact,
    PathSelection selection,
    bool success,
    int? tripTimeMs,
  ) => pathResults.add(success);

  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(frame);
    if (!answer) return;
    const tag = [0x11, 0x22, 0x33, 0x44];
    scheduleMicrotask(() {
      // An unrelated binary response with another tag must be ignored.
      _frames.add(Uint8List.fromList([pushCodeBinaryResponse, 0, 9, 9, 9, 9]));
      _frames.add(Uint8List.fromList([respCodeSent, 0, ...tag, 0, 0, 0, 0]));
      _frames.add(
        Uint8List.fromList([pushCodeBinaryResponse, 0, ...tag, ...reply!]),
      );
    });
  }
}

class _FakeCommands extends RepeaterCommandService {
  _FakeCommands(super.connector, this.response);

  final String response;
  final List<String> commands = [];

  @override
  Future<String> sendCommand(
    Contact repeater,
    String command, {
    Function(String)? onResponse,
    Function(int)? onAttempt,
    int retries = RepeaterCommandService.maxRetries,
  }) async {
    commands.add(command);
    return response;
  }
}

final _node = Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => 200 - i)),
  name: 'Hollyburn RPT',
  type: advTypeRepeater,
  pathLength: 0,
  path: Uint8List(0),
  lastSeen: DateTime(2026, 10, 15),
);

void main() {
  test('fetch sends the request and parses the tagged reply', () async {
    final radio = _FakeRadio(
      reply: Uint8List.fromList([1, 2, 3, 4, 5, 6, 3, 7, 7, 7, 7, 7, 7, 1]),
    );
    final service = AccessControlService(radio, _FakeCommands(radio, 'OK'));

    final entries = await service.fetch(_node);

    expect(entries.map((e) => e.role), [AclRole.admin, AclRole.readOnly]);
    expect(radio.sent.single[0], cmdSendBinaryReq);
    expect(radio.sent.single.sublist(33, 37), [reqTypeGetAccessList, 0, 0, 0]);
    expect(radio.pathResults, [true]);
  });

  test('fetch times out and records a failed path', () async {
    final radio = _FakeRadio(answer: false);
    final service = AccessControlService(radio, _FakeCommands(radio, 'OK'));

    await expectLater(service.fetch(_node), throwsA(isA<TimeoutException>()));
    expect(radio.pathResults, [false]);
  });

  test('setRole sends setperm and accepts OK', () async {
    final radio = _FakeRadio();
    final commands = _FakeCommands(radio, 'OK');
    final service = AccessControlService(radio, commands);
    final key = Uint8List.fromList(List.filled(32, 0xab));

    await service.setRole(_node, key, AclRole.admin);

    expect(commands.commands.single, 'setperm ${'ab' * 32} 3');
  });

  test('setRole throws with the node reply when refused', () async {
    final radio = _FakeRadio();
    final service = AccessControlService(
      radio,
      _FakeCommands(radio, 'Err - invalid params'),
    );

    await expectLater(
      service.setRole(_node, Uint8List(6), AclRole.readWrite),
      throwsA(
        isA<AccessControlException>().having(
          (e) => e.reply,
          'reply',
          'Err - invalid params',
        ),
      ),
    );
  });
}
