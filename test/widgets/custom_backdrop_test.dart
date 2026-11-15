import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/backdrop_store.dart';
import 'package:meshcore_open/widgets/custom_backdrop.dart';

void main() {
  Widget host(BackdropStyle style) => MaterialApp(
    home: SizedBox(
      width: 300,
      height: 500,
      child: CustomBackdrop(style: style, ground: const Color(0xFF101010)),
    ),
  );

  for (final kind in BackdropKind.values) {
    testWidgets('draws $kind without errors', (tester) async {
      await tester.pumpWidget(host(BackdropStyle(kind: kind)));
      expect(tester.takeException(), isNull);
      expect(find.byType(CustomBackdrop), findsOneWidget);
    });
  }

  testWidgets('lays the dim layer over the background', (tester) async {
    await tester.pumpWidget(
      host(const BackdropStyle(kind: BackdropKind.solid, dim: 0.5)),
    );
    final layers = tester
        .widgetList<ColoredBox>(find.byType(ColoredBox))
        .map((b) => b.color)
        .toList();
    expect(layers, contains(const Color(0xFF101010).withValues(alpha: 0.5)));
  });

  test('mesh painter repaints only when colours change', () {
    final a = MeshGradientPainter(Colors.red, Colors.blue);
    expect(
      a.shouldRepaint(MeshGradientPainter(Colors.red, Colors.blue)),
      false,
    );
    expect(
      a.shouldRepaint(MeshGradientPainter(Colors.red, Colors.green)),
      true,
    );
  });
}
