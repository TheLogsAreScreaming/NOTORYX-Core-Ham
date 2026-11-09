import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/helpers/chat_scroll_controller.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/widgets/jump_to_bottom_button.dart';

void main() {
  testWidgets('has a spoken name and a full-size tap target', (tester) async {
    final controller = ChatScrollController();
    addTearDown(controller.dispose);
    controller.showJumpToBottom.value = true;
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Stack(
            children: [JumpToBottomButton(scrollController: controller)],
          ),
        ),
      ),
    );
    expect(find.bySemanticsLabel('Jump to the latest message'), findsOneWidget);
    expect(tester.getSize(find.byType(InkWell)), const Size(48, 48));
    handle.dispose();
  });
}
