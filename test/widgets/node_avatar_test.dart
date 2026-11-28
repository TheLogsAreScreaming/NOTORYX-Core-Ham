import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/node_look_store.dart';
import 'package:meshcore_open/widgets/mesh_ui.dart';
import 'package:meshcore_open/widgets/node_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late NodeLookStore store;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    store = NodeLookStore(prefs: await SharedPreferences.getInstance());
  });

  Widget host(Widget child) => MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );

  testWidgets('shows the fallback when nothing was picked', (tester) async {
    await tester.pumpWidget(
      host(
        NodeAvatar(
          nodeKey: 'aa',
          name: 'Ridge',
          store: store,
          fallback: const Text('fallback'),
        ),
      ),
    );
    expect(find.text('fallback'), findsOneWidget);
  });

  testWidgets('shows the picked colour, and updates live', (tester) async {
    await tester.pumpWidget(
      host(
        NodeAvatar(
          nodeKey: 'aa',
          name: 'Ridge',
          store: store,
          fallback: const Text('fallback'),
        ),
      ),
    );
    await tester.runAsync(() => store.setColor('aa', 0xFF1E88E5));
    await tester.pump();
    expect(find.text('fallback'), findsNothing);
    final circle = tester.widget<AvatarCircle>(find.byType(AvatarCircle));
    expect(circle.color, const Color(0xFF1E88E5));
  });

  testWidgets('a broken photo falls back to initials', (tester) async {
    await tester.runAsync(
      () => store.setPhoto('aa', Uint8List.fromList([0, 1, 2, 3])),
    );
    await tester.pumpWidget(
      host(NodeAvatar(nodeKey: 'aa', name: 'Ridge Top', store: store)),
    );
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
  });
}
