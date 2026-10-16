import '../connector/meshcore_connector.dart';
import '../models/channel_message.dart';
import '../models/path_graph.dart';

/// Every distinct path heard on saved channel messages since [since]
/// (all of them when null). Each copy of a message that arrived by another
/// route counts as its own observation.
Future<List<PathObservation>> collectChannelPaths(
  MeshCoreConnector connector, {
  DateTime? since,
}) async {
  final out = <PathObservation>[];
  for (final channel in connector.channels) {
    if (channel.isEmpty) continue;
    final name = channel.name.isEmpty
        ? 'Channel ${channel.index}'
        : channel.name;
    for (final m in await connector.loadFullChannelHistory(channel)) {
      if (m.isOutgoing) continue;
      if (since != null && m.timestamp.isBefore(since)) continue;
      out.addAll(
        pathsOf(m, connector.pathHashByteWidth, '${m.senderName} on $name'),
      );
    }
  }
  return out;
}

/// The distinct paths one channel message was heard on.
List<PathObservation> pathsOf(
  ChannelMessage m,
  int fallbackWidth,
  String source,
) {
  final width = (m.pathHashWidth ?? fallbackWidth).clamp(1, 4);
  final seen = <String>{};
  final out = <PathObservation>[];
  for (final bytes in [m.pathBytes, ...m.pathVariants]) {
    if (bytes.isEmpty || bytes.length % width != 0) continue;
    if (!seen.add(bytes.join(','))) continue;
    out.add(
      PathObservation.fromBytes(
        bytes,
        width: width,
        at: m.timestamp,
        source: source,
      ),
    );
  }
  return out;
}
