/// Bounded message identifier cache to prevent repeated MQTT packet handling.
/// Message identifiers must be derived from authenticated packet metadata.
class MqttPacketDeduplicator {
  MqttPacketDeduplicator({this.capacity = 512})
    : assert(capacity > 0);

  final int capacity;
  final Set<String> _seen = <String>{};
  final List<String> _order = <String>[];

  bool accept(String identifier) {
    if (identifier.isEmpty || _seen.contains(identifier)) return false;
    _seen.add(identifier);
    _order.add(identifier);
    if (_order.length > capacity) {
      _seen.remove(_order.removeAt(0));
    }
    return true;
  }

  void clear() {
    _seen.clear();
    _order.clear();
  }
}
