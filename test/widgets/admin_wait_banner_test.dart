import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/admin_wait.dart';
import 'package:meshcore_open/widgets/admin_wait_banner.dart';

Future<void> pump(WidgetTester tester, AdminWait wait) => tester.pumpWidget(
  MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: AdminWaitBanner(wait: wait)),
  ),
);

void main() {
  group('AdminWait', () {
    test('first attempt can retry once, second cannot', () {
      const first = AdminWait(hops: 3, timeout: Duration(seconds: 12));
      const second = AdminWait(
        hops: 3,
        timeout: Duration(seconds: 12),
        attempt: 2,
      );
      expect(adminRequestMaxAttempts, 2);
      expect(first.isRetry, isFalse);
      expect(first.canRetry, isTrue);
      expect(second.isRetry, isTrue);
      expect(second.canRetry, isFalse);
    });

    test('negative hops means flood; seconds round up', () {
      const flood = AdminWait(hops: -1, timeout: Duration(milliseconds: 9100));
      expect(flood.isFlood, isTrue);
      expect(flood.timeoutSeconds, 10);
    });
  });

  group('AdminWaitBanner', () {
    testWidgets('direct route shows hops and time limit', (tester) async {
      await pump(
        tester,
        const AdminWait(hops: 3, timeout: Duration(milliseconds: 11200)),
      );
      expect(find.text('Waiting for a reply'), findsOneWidget);
      expect(find.text('Direct, 3 hops · up to 12 s'), findsOneWidget);
      await tester.pump(const Duration(seconds: 13));
    });

    testWidgets('single hop and zero hops read naturally', (tester) async {
      await pump(
        tester,
        const AdminWait(hops: 1, timeout: Duration(seconds: 4)),
      );
      expect(find.text('Direct, 1 hop · up to 4 s'), findsOneWidget);
      await pump(
        tester,
        const AdminWait(hops: 0, timeout: Duration(seconds: 3)),
      );
      expect(find.text('Direct · up to 3 s'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('flood route and retry wording', (tester) async {
      await pump(
        tester,
        const AdminWait(hops: -1, timeout: Duration(seconds: 20), attempt: 2),
      );
      expect(find.text('No reply yet. Trying again (2 of 2)'), findsOneWidget);
      expect(find.text('Flood · up to 20 s'), findsOneWidget);
      expect(find.byIcon(Icons.replay), findsOneWidget);
      await tester.pump(const Duration(seconds: 21));
    });

    testWidgets('progress bar fills over the timeout', (tester) async {
      await pump(
        tester,
        const AdminWait(hops: 2, timeout: Duration(seconds: 10)),
      );
      await tester.pump(const Duration(seconds: 5));
      final bar = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(bar.value, closeTo(0.5, 0.05));
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('screen readers hear one combined announcement', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await pump(
        tester,
        const AdminWait(hops: 3, timeout: Duration(seconds: 12)),
      );
      expect(
        find.bySemanticsLabel(
          'Waiting for a reply. Direct, 3 hops · up to 12 s',
        ),
        findsOneWidget,
      );
      await tester.pump(const Duration(seconds: 13));
      handle.dispose();
    });
  });
}
