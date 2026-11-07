import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/ui/mesh_states.dart';

Widget _app(Widget child) => MaterialApp(
  theme: MeshTheme.forPalette(MeshPalette.current),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  testWidgets('the theme carries status colours and the type scale', (
    tester,
  ) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (c) {
            ctx = c;
            return const SizedBox();
          },
        ),
      ),
    );
    final status = MeshStatusColors.of(ctx);
    expect(status.color(MeshStatus.error), Theme.of(ctx).colorScheme.error);
    expect(Theme.of(ctx).textTheme.titleLarge!.fontSize, 20);
  });

  testWidgets('empty and error states show their text and retry', (
    tester,
  ) async {
    var retried = 0;
    await tester.pumpWidget(
      _app(
        MeshErrorState(
          title: 'Could not load',
          message: 'Check the connection',
          onRetry: () => retried++,
        ),
      ),
    );
    expect(find.text('Could not load'), findsOneWidget);
    expect(find.text('Check the connection'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retried, 1);
  });

  testWidgets('status banner shows title, message and action', (tester) async {
    await tester.pumpWidget(
      _app(
        MeshStatusBanner(
          status: MeshStatus.warning,
          title: 'Low battery',
          message: '12% left',
          action: TextButton(onPressed: () {}, child: const Text('Saver')),
        ),
      ),
    );
    expect(find.text('Low battery'), findsOneWidget);
    expect(find.text('12% left'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });

  testWidgets('confirmDestructive returns true only on confirm', (
    tester,
  ) async {
    bool? result;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async =>
                result = await confirmDestructive(context, title: 'Delete?'),
            child: const Text('go'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isFalse);

    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });
}
