import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_packet_deduplicator.dart';

void main() {
  test('accepts an identifier once', () {
    final dedup = MqttPacketDeduplicator();
    expect(dedup.accept('a'), isTrue);
    expect(dedup.accept('a'), isFalse);
    expect(dedup.accept('b'), isTrue);
  });

  test('rejects empty identifiers', () {
    expect(MqttPacketDeduplicator().accept(''), isFalse);
  });

  test('evicts the oldest identifier past capacity', () {
    final dedup = MqttPacketDeduplicator(capacity: 2);
    expect(dedup.accept('a'), isTrue);
    expect(dedup.accept('b'), isTrue);
    expect(dedup.accept('c'), isTrue);
    expect(dedup.accept('b'), isFalse);
    expect(dedup.accept('c'), isFalse);
    expect(dedup.accept('a'), isTrue);
  });

  test('clear forgets every identifier', () {
    final dedup = MqttPacketDeduplicator()..accept('a');
    dedup.clear();
    expect(dedup.accept('a'), isTrue);
  });
}
