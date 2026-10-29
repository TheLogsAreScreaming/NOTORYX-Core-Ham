import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/channel.dart';
import '../models/channel_directory.dart';
import '../models/radio_rx_packet.dart';
import '../storage/prefs_manager.dart';
import 'channel_directory_service.dart';

/// A public channel this radio has heard traffic on but hasn't joined.
class DiscoveredChannel {
  final ChannelDirectoryEntry entry;
  final DateTime firstHeard;
  DateTime lastHeard;
  int heard;

  DiscoveredChannel(this.entry, DateTime at)
    : firstHeard = at,
      lastHeard = at,
      heard = 1;
}

/// Notices traffic on directory channels you haven't joined. A group
/// message only carries a one-byte channel hash, so each candidate is
/// confirmed by its MAC before it's offered. Channels you ignore stay
/// hidden.
class ChannelDiscoveryService extends ChangeNotifier {
  ChannelDiscoveryService(
    this.connector, {
    Future<List<ChannelDirectoryEntry>> Function()? entries,
  }) : _entries = entries ?? _directoryEntries;

  final MeshCoreConnector connector;
  final Future<List<ChannelDirectoryEntry>> Function() _entries;

  static const _ignoredKey = 'notoryx_ignored_channels_v1';

  static Future<List<ChannelDirectoryEntry>> _directoryEntries() async {
    final directory = ChannelDirectoryService();
    await directory.load();
    return directory.entries;
  }

  /// Candidates by channel hash: name and key.
  final Map<int, List<({ChannelDirectoryEntry entry, Uint8List psk})>> _byHash =
      {};
  final Map<String, DiscoveredChannel> _found = {};
  final Set<String> _ignored = {};
  StreamSubscription<RadioRxPacket>? _sub;
  bool _disposed = false;

  /// Heard, not joined and not ignored, most recently heard first.
  List<DiscoveredChannel> get discovered {
    final joined = {for (final c in connector.channels) c.name};
    return _found.values
        .where(
          (d) =>
              !joined.contains(d.entry.name) &&
              !_ignored.contains(d.entry.name),
        )
        .toList()
      ..sort((a, b) => b.lastHeard.compareTo(a.lastHeard));
  }

  Future<void> load() async {
    _ignored.addAll(
      PrefsManager.instance.getStringList(_ignoredKey) ?? const [],
    );
    try {
      for (final e in await _entries()) {
        final psk = Channel.derivePskFromHashtag(e.name);
        _byHash.putIfAbsent(MeshCoreConnector.channelHashOf(psk), () => []).add(
          (entry: e, psk: psk),
        );
      }
    } catch (_) {
      // Without the directory there's nothing to recognise; stay idle.
    }
    if (_disposed || _byHash.isEmpty) return;
    _sub = connector.rxPackets.listen(onPacket);
  }

  @visibleForTesting
  void onPacket(RadioRxPacket packet) {
    final hash = connector.groupChannelHash(packet.raw);
    if (hash == null) return;
    final candidates = _byHash[hash];
    if (candidates == null) return;
    final joined = {for (final c in connector.channels) c.name};
    for (final c in candidates) {
      final name = c.entry.name;
      if (joined.contains(name) || _ignored.contains(name)) continue;
      if (!connector.groupPacketMatches(packet.raw, c.psk)) continue;
      final known = _found[name];
      if (known == null) {
        _found[name] = DiscoveredChannel(c.entry, packet.receivedAt);
      } else {
        known
          ..heard += 1
          ..lastHeard = packet.receivedAt;
      }
      _notify();
      return;
    }
  }

  Future<void> ignore(Iterable<String> names) async {
    _ignored.addAll(names);
    _notify();
    await PrefsManager.instance.setStringList(_ignoredKey, _ignored.toList());
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    unawaited(_sub?.cancel());
    super.dispose();
  }
}
