import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/screens/channel_directory_screen.dart';
import 'package:meshcore_open/services/channel_directory_service.dart';
import 'package:provider/provider.dart';

class _FakeConnector extends MeshCoreConnector {
  _FakeConnector({this.connected = true});

  final bool connected;
  final List<Channel> joined = [
    Channel(index: 0, name: 'Public', psk: Uint8List(16)),
    Channel(index: 1, name: '#test', psk: Channel.derivePskFromHashtag('test')),
  ];
  final List<(int, String, Uint8List)> setCalls = [];

  @override
  bool get isConnected => connected;
  @override
  List<Channel> get channels => joined;
  @override
  int get maxChannels => 8;
  @override
  double? get selfLatitude => 47.62;
  @override
  double? get selfLongitude => -122.35;
  @override
  Future<void> setChannel(int index, String name, Uint8List psk) async {
    setCalls.add((index, name, psk));
    joined.add(Channel(index: index, name: name, psk: psk));
    notifyListeners();
  }
}

const _list = '''
{"channels": [
  {"name": "#test", "category": "test", "description": "Checks"},
  {"name": "#emergency", "category": "emergency"},
  {"name": "#seattle", "category": "local", "description": "Seattle chat",
   "area": {"name": "Seattle", "center": [47.6062, -122.3321], "radiusKm": 50}}
]}''';

Future<void> _pump(WidgetTester tester, _FakeConnector connector) async {
  final service = ChannelDirectoryService(
    httpClient: MockClient((_) async => http.Response('offline', 503)),
    loadBundled: () async => _list,
  );
  addTearDown(service.dispose);
  await tester.pumpWidget(
    ChangeNotifierProvider<MeshCoreConnector>.value(
      value: connector,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ChannelDirectoryScreen(service: service),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('lists nearby channels first and marks joined ones', (
    tester,
  ) async {
    await _pump(tester, _FakeConnector());
    expect(find.text('Near you'.toUpperCase()), findsOneWidget);
    final seattle = tester.getTopLeft(find.text('#seattle'));
    final emergency = tester.getTopLeft(find.text('#emergency'));
    expect(seattle.dy, lessThan(emergency.dy));
    expect(find.text('Joined'), findsOneWidget); // #test
  });

  testWidgets('join puts the hashtag key in the first free slot', (
    tester,
  ) async {
    final connector = _FakeConnector();
    await _pump(tester, connector);
    await tester.tap(find.widgetWithText(FilledButton, 'Join').first);
    await tester.pumpAndSettle();
    final (index, name, psk) = connector.setCalls.single;
    expect(index, 2);
    expect(name, '#seattle');
    expect(psk, Channel.derivePskFromHashtag('seattle'));
    expect(find.text('Joined'), findsNWidgets(2));
  });

  testWidgets('search and category filter the list', (tester) async {
    await _pump(tester, _FakeConnector());
    await tester.enterText(
      find.byKey(const ValueKey('channel-directory-search')),
      'emerg',
    );
    await tester.pumpAndSettle();
    expect(find.text('#emergency'), findsOneWidget);
    expect(find.text('#seattle'), findsNothing);
    await tester.enterText(
      find.byKey(const ValueKey('channel-directory-search')),
      '',
    );
    await tester.tap(find.widgetWithText(ChoiceChip, 'Testing'));
    await tester.pumpAndSettle();
    expect(find.text('#test'), findsOneWidget);
    expect(find.text('#seattle'), findsNothing);
  });

  testWidgets('without a radio, join is disabled and explained', (
    tester,
  ) async {
    await _pump(tester, _FakeConnector(connected: false));
    expect(find.text('Connect your radio to join channels.'), findsOneWidget);
    final join = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Join').first,
    );
    expect(join.onPressed, isNull);
  });
}
