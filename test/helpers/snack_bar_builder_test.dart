import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/helpers/snack_bar_builder.dart';

void main() {
  test('friendlyError drops Dart and platform prefixes', () {
    expect(friendlyError(Exception('Radio busy')), 'Radio busy');
    expect(friendlyError(StateError('Not connected')), 'Not connected');
    expect(
      friendlyError(PlatformException(code: 'x', message: 'Permission denied')),
      'Permission denied',
    );
    expect(friendlyError('plain text'), 'plain text');
  });

  testWidgets('meshSnackBar is never persistent and dismisses on tap', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                meshSnackBar(
                  content: const Text('Saved'),
                  action: SnackBarAction(label: 'Undo', onPressed: () {}),
                ),
              ),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsOneWidget);
    await tester.tap(find.text('Saved'));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);

    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);
  });
}
