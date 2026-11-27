import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/bot_replies.dart';

void main() {
  test('direct or unknown path reads as direct', () {
    expect(pingReply(null), '🎯 Direct.');
    expect(pingReply(0), '🎯 Direct.');
  });

  test('one to ten hops get a number emoji and the count', () {
    expect(pingReply(1), '1⃣ 1 hop.');
    expect(pingReply(3), '3⃣ 3 hops.');
    expect(pingReply(10), '🔟 10 hops.');
  });

  test('eleven or more hops get the kangaroo', () {
    expect(hopEmoji(11), '🦘');
    expect(pingReply(40), '🦘 40 hops.');
  });

  test('the hash size bits are ignored', () {
    expect(pingReply(0x40 | 2), '2⃣ 2 hops.');
  });
}
