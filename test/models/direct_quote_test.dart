import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/direct_quote.dart';
import 'package:meshcore_open/models/message.dart';

Message _m(String text, {required bool out, bool cli = false}) => Message(
  senderKey: Uint8List(32),
  text: text,
  timestamp: DateTime(2026, 11, 8),
  isOutgoing: out,
  isCli: cli,
);

void main() {
  test('a reply answers the other person\'s latest earlier message', () {
    final list = [
      _m('@[Sam] on my way', out: true),
      _m('mine, earlier', out: true),
      _m('where are you?', out: false),
      _m('older', out: false),
    ];
    final quote = directQuoteFor(list, 0)!;
    expect(quote.name, 'Sam');
    expect(quote.body, 'on my way');
    expect(quote.originalText, 'where are you?');
  });

  test('quoting a reply shows its words without the prefix', () {
    final list = [
      _m('@[Me] ok', out: false),
      _m('@[Sam] on my way', out: true),
    ];
    expect(directQuoteFor(list, 0)!.originalText, 'on my way');
  });

  test('the original can be gone and the body still shows', () {
    final quote = directQuoteFor([_m('@[Sam] hi', out: true)], 0)!;
    expect(quote.body, 'hi');
    expect(quote.originalText, isNull);
  });

  test('plain text and CLI output are not replies', () {
    expect(directQuoteFor([_m('hello @[Sam] x', out: true)], 0), isNull);
    expect(directQuoteFor([_m('@[Sam] x', out: false, cli: true)], 0), isNull);
  });
}
