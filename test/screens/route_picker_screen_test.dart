import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/path_history.dart';
import 'package:meshcore_open/screens/route_picker_screen.dart';
import 'package:meshcore_open/services/path_history_service.dart';
import 'package:meshcore_open/services/route_link_service.dart';
import 'package:meshcore_open/services/storage_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact _node(int first, String name, int type, {List<int> path = const []}) =>
    Contact(
      publicKey: Uint8List.fromList([first, ...List.filled(31, 3)]),
      name: name,
      type: type,
      pathLength: path.length,
      path: Uint8List.fromList(path),
      lastSeen: DateTime.now(),
    );

final _alice = _node(0x11, 'Alice', advTypeChat, path: [0xCC]);

class _Radio extends MeshCoreConnector {
  final frames = StreamController<Uint8List>.broadcast();
  final sent = <Uint8List>[];
  final overrides = <List<int>>[];
  Contact alice = _alice;
  final nodes = [
    _node(0xAA, 'Hilltop', advTypeRepeater),
    _node(0xBB, 'Valley', advTypeRepeater),
    _node(0xCC, 'Ridge', advTypeRepeater),
  ];

  @override
  bool get isConnected => true;
  @override
  int get pathHashByteWidth => 1;
  @override
  List<Contact> get allContacts => [...nodes, alice];
  @override
  Contact? getContactByPubKeyHex(String hex) =>
      hex == alice.publicKeyHex ? alice : null;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;
  @override
  Future<void> setPathOverride(
    Contact contact, {
    int? pathLen,
    Uint8List? pathBytes,
  }) async {
    overrides.add(pathBytes ?? const []);
    alice = alice.copyWith(pathOverride: pathLen, pathOverrideBytes: pathBytes);
    notifyListeners();
  }

  @override
  Future<bool> verifyContactPathOnDevice(
    Contact contact,
    Uint8List expectedPath, {
    Duration timeout = const Duration(seconds: 3),
  }) async => true;

  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(data);
    if (data[0] != cmdSendTracePath) return;
    final tag = data.sublist(1, 5);
    final flag = data[9];
    final payload = data.sublist(10);
    // A one-hop out-and-back trace: Ridge heard us at -14, we heard it at -13.
    frames.add(
      Uint8List.fromList([
        pushCodeTraceData,
        0,
        payload.length,
        flag,
        ...tag,
        0,
        0,
        0,
        0,
        ...payload,
        -56 & 0xFF,
        -52 & 0xFF,
      ]),
    );
  }
}

class _History extends PathHistoryService {
  _History() : super(StorageService());
  final now = DateTime.now();
  @override
  List<PathRecord> getRecentPaths(String contactPubKeyHex) => [
    PathRecord(
      hopCount: 1,
      tripTimeMs: 900,
      timestamp: now,
      wasFloodDiscovery: false,
      pathBytes: [0xCC],
      successCount: 1,
      failureCount: 3,
    ),
    PathRecord(
      hopCount: 2,
      tripTimeMs: 1500,
      timestamp: now,
      wasFloodDiscovery: false,
      pathBytes: [0xAA, 0xBB],
      successCount: 4,
      failureCount: 0,
    ),
  ];
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  test('measure stores both directions of each link', () async {
    final radio = _Radio();
    final links = RouteLinkService(radio);
    expect(await links.measure([0xCC], 1), isTrue);
    final sent = radio.sent.single;
    expect(sent[0], cmdSendTracePath);
    expect(sent.sublist(10), [0xCC]);
    final link = links.links['ME>CC']!;
    expect(link.snrOut, -14);
    expect(link.snrBack, -13);
    expect(RouteLinkService(radio).links['ME>CC']?.snrBack, -13);
    radio.dispose();
  });

  testWidgets('charts hops, measures, suggests and applies a route', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(500, 1800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final radio = _Radio();
    final history = _History();
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider<PathHistoryService>.value(value: history),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: RoutePickerScreen(contact: _alice),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Route to Alice'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp(r'^Hop 1: Ridge\. Link Not measured yet')),
      findsOneWidget,
    );
    expect(find.text('Hilltop → Valley'), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('route-measure')));
    // The trace answer and the saved readings resolve on real futures.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Measured just now.'), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        RegExp(r'^Hop 1: Ridge\. Link Weak, -14\.0 decibels out, -13\.0'),
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('route-suggestion')), findsOneWidget);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    await tester.tap(
      find.descendant(
        of: find.byKey(const ValueKey('route-suggestion')),
        matching: find.text('Use'),
      ),
    );
    await tester.pumpAndSettle();
    expect(radio.overrides.single, [0xAA, 0xBB]);
    expect(find.byKey(const ValueKey('route-suggestion')), findsNothing);
    handle.dispose();
    await tester.pumpWidget(const SizedBox());
    history.dispose();
    radio.dispose();
  });
}
