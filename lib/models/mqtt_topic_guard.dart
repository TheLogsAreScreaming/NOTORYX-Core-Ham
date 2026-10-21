/// Helpers for validating user-supplied MQTT subscription/publish topics.
/// This does not authorize forwarding encrypted or private MeshCore traffic.
class MqttTopicGuard {
  static bool validPublishTopic(String topic) {
    return topic.isNotEmpty &&
        !topic.startsWith('/') &&
        !topic.endsWith('/') &&
        !topic.contains('#') &&
        !topic.contains('+') &&
        !topic.contains('\\u0000');
  }

  static bool validSubscriptionTopic(String topic) {
    if (topic.isEmpty || topic.contains('\\u0000')) return false;
    final segments = topic.split('/');
    for (var index = 0; index < segments.length; index++) {
      final segment = segments[index];
      if (segment.contains('#') &&
          (segment != '#' || index != segments.length - 1)) {
        return false;
      }
      if (segment.contains('+') && segment != '+') return false;
    }
    return true;
  }
}
