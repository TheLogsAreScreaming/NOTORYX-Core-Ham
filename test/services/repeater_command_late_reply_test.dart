import 'dart:convert';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/path_selection.dart';
import 'package:meshcore_open/services/repeater_command_service.dart';

final _repeater = Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i + 3)),
  name: 'Repeater A',
  type: advTypeRepeater,
  pathLength: 1,
  path: Uint8List.fromList([0x11]),
  lastSeen: DateTime.utc(2026),
);

class _Radio extends MeshCoreConnector {
  final List<String> sentCommands = [];

  @override
  bool get isConnected => true;

  @override
  Future<PathSelection> preparePathForContactSend(Contact contact) async =>
      const PathSelection(pathBytes: [0x11], hopCount: 1, useFlood: false);

  @override
  int calculateTimeout({
    required int pathLength,
    int messageBytes = 100,
    String? contactKey,
    int? deviceTimeoutMs,
  }) => 3000;

  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    // [cmd][txt type][attempt][timestamp x4][key prefix x6][text\0]
    sentCommands.add(utf8.decode(data.sublist(13, data.length - 1)));
  }
}

String _tagOf(String sent) => sent.substring(0, 3);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('waits at least 12 s direct and 20 s flood', () {
    expect(
      RepeaterCommandService.waitFor(const Duration(seconds: 3), flood: false),
      const Duration(seconds: 12),
    );
    expect(
      RepeaterCommandService.waitFor(const Duration(seconds: 3), flood: true),
      const Duration(seconds: 20),
    );
    expect(
      RepeaterCommandService.waitFor(const Duration(seconds: 40), flood: false),
      const Duration(seconds: 40),
    );
  });

  test('a retry accepts the reply to the earlier attempt', () {
    fakeAsync((async) {
      final radio = _Radio();
      final service = RepeaterCommandService(radio);
      String? result;
      service.sendCommand(_repeater, 'ver', retries: 2).then((r) => result = r);
      async.elapse(const Duration(seconds: 13)); // first attempt times out
      expect(radio.sentCommands, hasLength(2));
      final firstTag = _tagOf(radio.sentCommands.first);
      service.handleResponse(_repeater, '${firstTag}v1.18.0');
      async.flushMicrotasks();
      expect(result, 'v1.18.0');
      service.dispose();
    });
  });

  test('a late reply is reported, not given to the next command', () {
    fakeAsync((async) {
      final radio = _Radio();
      final late = <String>[];
      final service = RepeaterCommandService(
        radio,
        onLateReply: (command, reply) => late.add('$command=$reply'),
      );
      Object? error;
      service.sendCommand(_repeater, 'clock', retries: 1).catchError((
        Object e,
      ) {
        error = e;
        return '';
      });
      async.elapse(const Duration(seconds: 13));
      expect(error.toString(), contains('timeout'));
      final clockTag = _tagOf(radio.sentCommands.single);

      String? nameReply;
      service
          .sendCommand(_repeater, 'get name', retries: 1)
          .then((r) => nameReply = r);
      async.flushMicrotasks();
      service.handleResponse(_repeater, '${clockTag}20:19 - 23/11/2026 UTC');
      async.flushMicrotasks();
      expect(late, ['clock=20:19 - 23/11/2026 UTC']);
      expect(nameReply, isNull);

      final nameTag = _tagOf(radio.sentCommands.last);
      service.handleResponse(_repeater, '$nameTag> Repeater A');
      async.flushMicrotasks();
      expect(nameReply, '> Repeater A');
      service.dispose();
    });
  });

  test('a reply with a tag we never sent answers nothing', () {
    fakeAsync((async) {
      final radio = _Radio();
      final service = RepeaterCommandService(radio);
      String? result;
      service
          .sendCommand(_repeater, 'ver', retries: 1)
          .then((r) => result = r)
          .catchError((Object _) => '');
      async.flushMicrotasks();
      final ours = _tagOf(radio.sentCommands.single);
      final other = ours == 'ZZ|' ? 'YY|' : 'ZZ|';
      service.handleResponse(_repeater, '${other}someone else');
      async.flushMicrotasks();
      expect(result, isNull);
      service.handleResponse(_repeater, '${ours}v1.18.0');
      async.flushMicrotasks();
      expect(result, 'v1.18.0');
      service.dispose();
    });
  });

  test('two services never use the same reply tag', () {
    fakeAsync((async) {
      final radio = _Radio();
      final a = RepeaterCommandService(radio);
      final b = RepeaterCommandService(radio);
      a.sendCommand(_repeater, 'ver', retries: 1).catchError((Object _) => '');
      b.sendCommand(_repeater, 'ver', retries: 1).catchError((Object _) => '');
      async.flushMicrotasks();
      expect(
        _tagOf(radio.sentCommands[0]),
        isNot(_tagOf(radio.sentCommands[1])),
      );
      async.elapse(const Duration(seconds: 30));
      a.dispose();
      b.dispose();
    });
  });
}
