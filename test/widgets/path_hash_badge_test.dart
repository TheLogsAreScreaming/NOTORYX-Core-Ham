import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/widgets/path_hash_badge.dart';

Contact withPath(int hops, int bytes) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, 3)),
  name: 'Ridge',
  type: advTypeRepeater,
  pathLength: hops,
  path: Uint8List(bytes),
  lastSeen: DateTime(2026, 11, 7),
);

Future<void> pump(WidgetTester tester, int width, int radio) =>
    tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: PathHashBadge(width: width, radioWidth: radio),
          ),
        ),
      ),
    );

void main() {
  group('Contact.routeHashWidth', () {
    test('bytes per hop from the learned route', () {
      expect(withPath(3, 3).routeHashWidth, 1);
      expect(withPath(3, 6).routeHashWidth, 2);
      expect(withPath(2, 6).routeHashWidth, 3);
    });

    test('unknown for flood, direct or an uneven route', () {
      expect(withPath(-1, 0).routeHashWidth, isNull);
      expect(withPath(0, 0).routeHashWidth, isNull);
      expect(withPath(3, 0).routeHashWidth, isNull);
      expect(withPath(3, 7).routeHashWidth, isNull);
      expect(withPath(1, 5).routeHashWidth, isNull);
    });
  });

  group('PathHashBadge', () {
    testWidgets('matching width is a quiet tag', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(tester, 2, 2);
      expect(find.text('2B'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Route uses 2-byte path hashes'),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets('a different width says what the radio uses', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(tester, 1, 2);
      expect(find.text('1B'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          'Route uses 1-byte path hashes. Your radio uses 2-byte',
        ),
        findsOneWidget,
      );
      final text = tester.widget<Text>(find.text('1B'));
      expect(text.style?.fontWeight, FontWeight.w700);
      handle.dispose();
    });
  });
}
