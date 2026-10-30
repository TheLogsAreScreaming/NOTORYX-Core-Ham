import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/widgets/radio_overview_card.dart';

class _Radio extends MeshCoreConnector {
  final sent = <bool>[];
  @override
  Future<void> sendSelfAdvert({bool flood = true}) async => sent.add(flood);
}

Future<_Radio> _open(WidgetTester tester) async {
  final radio = _Radio();
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showAdvertChoice(context, radio),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return radio;
}

void main() {
  testWidgets('a zero-hop advert stays with direct neighbours', (tester) async {
    final radio = await _open(tester);
    await tester.tap(find.byKey(const ValueKey('advert-zero-hop')));
    await tester.pumpAndSettle();
    expect(radio.sent, [false]);
  });

  testWidgets('a flood advert goes across the mesh', (tester) async {
    final radio = await _open(tester);
    await tester.tap(find.byKey(const ValueKey('advert-flood')));
    await tester.pumpAndSettle();
    expect(radio.sent, [true]);
  });

  testWidgets('dismissing the choice sends nothing', (tester) async {
    final radio = await _open(tester);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(radio.sent, isEmpty);
  });
}
