import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/nearby_repeaters.dart';
import 'package:meshcore_open/models/wardrive.dart';
import 'package:meshcore_open/screens/nearby_repeater_test_screen.dart';
import 'package:meshcore_open/services/nearby_repeater_probe.dart';
import 'package:provider/provider.dart';

Contact _rpt(int first, String name) => Contact(
  publicKey: Uint8List.fromList([first, ...List.filled(31, 7)]),
  name: name,
  type: advTypeRepeater,
  pathLength: 0,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  final frames = StreamController<Uint8List>.broadcast();
  final sent = <Uint8List>[];
  final known = [_rpt(0xAB, 'Hilltop')];
  bool connected = true;

  @override
  bool get isConnected => connected;
  @override
  List<Contact> get allContacts => known;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;
  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(data);
    final tag = ByteData.sublistView(data).getUint32(3, Endian.little);
    frames.add(_reply(tag, [0xAB, 7, 7, 7, 7, 7, 7, 7], here: 28, there: 20));
    frames.add(_reply(tag + 1, [0xCD, 1, 1, 1, 1, 1, 1, 1]));
    frames.add(_reply(tag, [0xEF, 2, 2, 2, 2, 2, 2, 2], here: -40, there: 8));
  }
}

Uint8List _reply(int tag, List<int> prefix, {int here = 24, int there = 12}) {
  final b = BytesBuilder()
    ..add([pushCodeControlData, here & 0xFF, 0xA4, 0])
    ..addByte((controlSubtypeDiscoverResp << 4) | advTypeRepeater)
    ..addByte(there & 0xFF);
  final t = ByteData(4)..setUint32(0, tag, Endian.little);
  b
    ..add(t.buffer.asUint8List())
    ..add(prefix);
  return b.toBytes();
}

WardriveReply _r(String prefix, double here, double there) => WardriveReply(
  prefix: prefix,
  snrHere: here,
  snrThere: there,
  rssiHere: -90,
);

void main() {
  test('ranks by the weaker direction and names known repeaters', () {
    final ranked = rankNearbyRepeaters(
      [_r('ef02', -10, 2), _r('ab0707', 7, 5), _r('cd01', 1, -3)],
      [_rpt(0xAB, 'Hilltop')],
    );
    expect(ranked.map((r) => r.prefix), ['ab0707', 'cd01', 'ef02']);
    expect(ranked.first.name, 'Hilltop');
    expect(ranked.first.link, NearbyLink.strong);
    expect(ranked[1].link, NearbyLink.usable);
    expect(ranked[2].link, NearbyLink.weak);
    expect(ranked[1].name, isNull);
  });

  test(
    'probe sends one zero-hop discover and keeps only its answers',
    () async {
      final radio = _Radio();
      final replies = await NearbyRepeaterProbe(
        radio,
        listen: const Duration(milliseconds: 10),
      ).run();
      expect(radio.sent, hasLength(1));
      expect(radio.sent.single[0], cmdSendControlData);
      expect(radio.sent.single[1] >> 4, controlSubtypeDiscoverReq);
      expect(replies.map((r) => r.prefix).toSet(), {
        'ab07070707070707',
        'ef02020202020202',
      });
      radio.dispose();
    },
  );

  testWidgets('one tap lists responders with spoken signal', (tester) async {
    final radio = _Radio();
    var now = DateTime(2026, 11, 13, 12);
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NearbyRepeaterTestScreen(
            clock: () => now,
            probe: () async => [_r('ab070707', 7, 5), _r('cd010101', -9, 3)],
          ),
        ),
      ),
    );
    await tester.tap(find.text('Test now'));
    await tester.pump();
    expect(find.text('Repeaters that answered: 2'), findsOneWidget);
    expect(find.text('Hilltop · Strong'), findsOneWidget);
    expect(find.text('Repeater CD010101 · Weak'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp(r'^Hilltop, Strong\. It heard you at 5\.0')),
      findsOneWidget,
    );
    expect(find.textContaining('Next test in 30 s'), findsOneWidget);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    now = now.add(NearbyRepeaterProbe.spacing);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Test now'), findsOneWidget);
    handle.dispose();
    await tester.pumpWidget(const SizedBox());
    radio.dispose();
  });

  testWidgets('disabled with a hint while disconnected', (tester) async {
    final radio = _Radio()..connected = false;
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NearbyRepeaterTestScreen(),
        ),
      ),
    );
    expect(find.text('Connect your radio to run the test.'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    radio.dispose();
  });
}
