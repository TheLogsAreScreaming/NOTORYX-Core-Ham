import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/mesh_ui.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  return (la > lb ? la + .05 : lb + .05) / (la > lb ? lb + .05 : la + .05);
}

void main() {
  tearDown(() => MeshPalette.current = BastionTheme.fallback.palette);

  test('onColor picks the more readable of black and white', () {
    expect(MeshPalette.onColor(const Color(0xFF000000)), Colors.white);
    expect(MeshPalette.onColor(const Color(0xFFFFFFFF)), Colors.black);
    expect(MeshPalette.onColor(const Color(0xFFFFD84D)), Colors.black);
    expect(MeshPalette.onColor(const Color(0xFF7022C4)), Colors.white);
  });

  test('readable keeps passing colors and fixes failing ones', () {
    const page = Color(0xFFFFF0FA);
    const ink = Color(0xFF111111);
    expect(MeshPalette.readable(ink, page), ink);
    const pale = Color(0xFFFF8AC8);
    expect(_contrast(pale, page), lessThan(4.5));
    final fixed = MeshPalette.readable(pale, page);
    expect(_contrast(fixed, page), greaterThanOrEqualTo(4.5));
    // Same hue, only lightness moved.
    expect(
      HSLColor.fromColor(fixed).hue,
      closeTo(HSLColor.fromColor(pale).hue, 1),
    );
    // Dark surfaces lighten instead.
    const night = Color(0xFF0A0A0A);
    const dim = Color(0xFF5A1010);
    expect(
      _contrast(MeshPalette.readable(dim, night), night),
      greaterThanOrEqualTo(4.5),
    );
  });

  testWidgets('avatar colors follow a theme switch', (tester) async {
    Future<Color?> initialsColor() async {
      // A new key each time: an identical const widget would not rebuild.
      await tester.pumpWidget(
        MaterialApp(
          home: AvatarCircle(key: UniqueKey(), name: 'Trail Crew'),
        ),
      );
      return tester.widget<Text>(find.text('TC')).style?.color;
    }

    MeshPalette.current = BastionTheme.blaze.palette;
    final blaze = await initialsColor();
    MeshPalette.current = BastionTheme.pinkOverload.palette;
    final pink = await initialsColor();
    expect(pink, isNot(blaze));
  });
}
