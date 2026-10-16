import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/storage/draft_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test('keys are per radio and per conversation', () {
    final a = DraftStore.contactKey('aabbccddeeff00', 'c0ffee');
    expect(a, 'draft_aabbccddee_c_c0ffee');
    expect(DraftStore.channelKey('aabbccddeeff00', 2), 'draft_aabbccddee_ch_2');
    expect(DraftStore.contactKey('1122334455667788', 'c0ffee'), isNot(a));
  });

  test('empty text removes the draft', () async {
    await DraftStore.save('k', 'meet at 5');
    expect(DraftStore.load('k'), 'meet at 5');
    await DraftStore.save('k', '   ');
    expect(DraftStore.load('k'), isNull);
  });

  testWidgets('a draft is restored, saved after typing, and cleared on send', (
    tester,
  ) async {
    final first = TextEditingController();
    final keeper = DraftKeeper(first, 'draft_x_c_1')..attach();
    first.text = 'Heading up the ridge';
    await tester.pump(const Duration(milliseconds: 500));
    keeper.dispose();
    first.dispose();
    expect(DraftStore.load('draft_x_c_1'), 'Heading up the ridge');

    // Coming back to the chat restores it with the cursor at the end.
    final second = TextEditingController();
    final again = DraftKeeper(second, 'draft_x_c_1')..attach();
    expect(second.text, 'Heading up the ridge');
    expect(second.selection.baseOffset, second.text.length);

    // Sending clears the field, and the draft with it.
    second.clear();
    await tester.pump();
    expect(DraftStore.load('draft_x_c_1'), isNull);
    again.dispose();
    second.dispose();
  });

  testWidgets('leaving before the save delay still keeps the text', (
    tester,
  ) async {
    final c = TextEditingController();
    final keeper = DraftKeeper(c, 'draft_x_ch_0')..attach();
    c.text = 'half a thought';
    keeper.dispose();
    c.dispose();
    await tester.pump();
    expect(DraftStore.load('draft_x_ch_0'), 'half a thought');
  });
}
