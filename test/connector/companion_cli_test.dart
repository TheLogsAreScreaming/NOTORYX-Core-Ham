import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';

// Replies to CMD_RUN_CLI_COMMAND like companion firmware: it echoes an
// "xy|" prefix in front of the reply.
class _CliRadio extends MeshCoreConnector {
  _CliRadio(this.handler);

  final String? Function(String command) handler;
  final List<String> commands = [];
  final _frames = StreamController<Uint8List>.broadcast();

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
    expect(frame[0], cmdRunCliCommand);
    final text = utf8.decode(frame.sublist(1));
    final prefix = text.substring(0, 3);
    final command = text.substring(3);
    commands.add(command);
    final reply = handler(command);
    if (reply == null) return;
    // Reply a little later so concurrent commands would overlap if they
    // weren't serialized.
    Timer(const Duration(milliseconds: 20), () {
      _frames.add(
        Uint8List.fromList([respCodeCliReply, ...utf8.encode('$prefix$reply')]),
      );
    });
  }
}

void main() {
  test('frame, reply value and unknown-command helpers', () {
    expect(buildRunCliCommandFrame('ver'), [
      cmdRunCliCommand,
      ...'ver'.codeUnits,
    ]);
    expect(cliReplyValue('> connected'), 'connected');
    expect(cliReplyValue('OK'), 'OK');
    expect(isUnknownCliCommandReply('Unknown command'), isTrue);
    expect(isUnknownCliCommandReply('> 1'), isFalse);
  });

  test('runCliCommand strips the echoed prefix', () async {
    final radio = _CliRadio((c) => c == 'get name' ? '> Trail Lead' : null);
    expect(await radio.runCliCommand('get name'), '> Trail Lead');
  });

  test(
    'concurrent commands run one at a time with their own replies',
    () async {
      final radio = _CliRadio((c) => '> $c done');
      final results = await Future.wait([
        radio.runCliCommand('get wifi.enabled'),
        radio.runCliCommand('get wifi.ssid'),
      ]);
      expect(results, ['> get wifi.enabled done', '> get wifi.ssid done']);
      expect(radio.commands, ['get wifi.enabled', 'get wifi.ssid']);
    },
  );

  test('a command without a reply times out and frees the queue', () async {
    final radio = _CliRadio((c) => c == 'reboot' ? null : '> ok');
    await expectLater(
      radio.runCliCommand('reboot', timeout: const Duration(milliseconds: 50)),
      throwsA(isA<TimeoutException>()),
    );
    expect(await radio.runCliCommand('ver'), '> ok');
  });
}
