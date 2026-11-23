import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/helpers/reaction_helper.dart';

void main() {
  group('alternate reaction format', () {
    test('hash matches the published test vector', () {
      expect(
        ReactionHelper.computeAlternateReactionHash(1234567890, 'Hello world!'),
        'tyvbkb33',
      );
    });

    test('channel reaction names the author before the emoji', () {
      final info = ReactionHelper.parseReaction('@[Node A 📓]🥳\nb3je6qf7');
      expect(info, isNotNull);
      expect(info!.emoji, '🥳');
      expect(info.targetHash, 'b3je6qf7:Node A 📓');
      expect(info.hashType, ReactionHashType.alternate);
    });

    test('older layout puts the author after the emoji', () {
      final info = ReactionHelper.parseReaction('🥳@[Node A]\nB3JE6QF7');
      expect(info, isNotNull);
      expect(info!.targetHash, 'b3je6qf7:Node A');
    });

    test('direct message reaction has no author', () {
      final info = ReactionHelper.parseReaction('🥳\nb3je6qf7');
      expect(info!.targetHash, 'b3je6qf7:');
    });

    test('composite emoji are accepted', () {
      for (final text in [
        '\u{1f44c}\u{1f3ff}\n01234567',
        '@[Node A]🧑‍🧑‍🧒\n01234567',
        '🧑‍🧑‍🧒‍🧒\n01234567',
      ]) {
        expect(ReactionHelper.parseReaction(text), isNotNull, reason: text);
      }
    });

    test('ordinary text is not read as a reaction', () {
      for (final text in [
        'test\nabcdefgh',
        '🥳\nhashistoolong',
        '🥳\nshort',
        '🥳🥳\n01234567',
        'X\n01234567',
        '🥳\nabcuuxyz',
      ]) {
        expect(ReactionHelper.parseReaction(text), isNull, reason: text);
      }
    });

    test('native reactions still parse as native', () {
      final info = ReactionHelper.parseReaction('r:a1b2:00');
      expect(info!.hashType, ReactionHashType.native);
    });

    test('applies to the channel message it names', () {
      const ts = 1234567890;
      final hash = ReactionHelper.computeAlternateReactionHash(
        ts,
        'Hello world!',
      );
      final messages = [
        ('Node B', ts, 'Hello world!'),
        ('Node A', ts, 'Hello world!'),
        ('Node A', ts + 1, 'Hello world!'),
      ];
      final info = ReactionHelper.parseReaction('@[Node A]👍\n$hash')!;
      int? hit;
      final found = ReactionHelper.applyReaction<(String, int, String)>(
        messages: messages,
        reactionInfo: info,
        getTimestampSecs: (m) => m.$2,
        getSenderName: (m) => m.$1,
        getMessageText: (m) => m.$3,
        getReactions: (_) => {},
        shouldSkip: (_) => false,
        updateMessage: (int i, Map<String, List<String?>> _) => hit = i,
      );
      expect(found, isTrue);
      expect(hit, 1);
    });

    test('applies to a direct message with no author', () {
      const ts = 1700000000;
      final hash = ReactionHelper.computeAlternateReactionHash(ts, 'On my way');
      final info = ReactionHelper.parseReaction('❤️\n$hash')!;
      final found = ReactionHelper.applyReaction<(int, String)>(
        messages: [(ts, 'On my way')],
        reactionInfo: info,
        getTimestampSecs: (m) => m.$1,
        getSenderName: (_) => null,
        getMessageText: (m) => m.$2,
        getReactions: (_) => {},
        shouldSkip: (_) => false,
        updateMessage: (int i, Map<String, List<String?>> _) {},
      );
      expect(found, isTrue);
    });
  });
}
