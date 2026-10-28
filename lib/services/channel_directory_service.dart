import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/channel_directory.dart';
import '../storage/prefs_manager.dart';

/// Where the shared list lives, next to `regional_presets.json` in the public
/// releases repository. The app also bundles a copy.
const channelDirectoryUrl =
    'https://raw.githubusercontent.com/TheLogsAreScreaming/notoryx-core-releases/main/channel_directory.json';

/// Loads the public channel directory: the last downloaded copy (or the
/// bundled one) at once, then the latest from GitHub when online.
class ChannelDirectoryService extends ChangeNotifier {
  final http.Client _http;
  final Future<String> Function() _loadBundled;

  static const _cacheKey = 'channel_directory_cache';

  List<ChannelDirectoryEntry> entries = const [];

  /// Whether the latest list was fetched during this session.
  bool refreshed = false;
  bool _disposed = false;

  ChannelDirectoryService({
    http.Client? httpClient,
    Future<String> Function()? loadBundled,
  }) : _http = httpClient ?? http.Client(),
       _loadBundled =
           loadBundled ??
           (() => rootBundle.loadString('assets/channel_directory.json'));

  /// Shows the cached or bundled list, then tries to download the latest.
  Future<void> load() async {
    String? cached;
    try {
      cached = PrefsManager.instance.getString(_cacheKey);
    } on StateError {
      cached = null;
    }
    final fromCache = cached == null
        ? const <ChannelDirectoryEntry>[]
        : parseChannelDirectory(cached);
    entries = fromCache.isNotEmpty
        ? fromCache
        : parseChannelDirectory(await _loadBundled());
    _notify();
    await refresh();
  }

  /// Fetches the latest list. Keeps the current one if offline or invalid.
  Future<void> refresh() async {
    try {
      final res = await _http
          .get(Uri.parse(channelDirectoryUrl))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) return;
      final fresh = parseChannelDirectory(res.body);
      if (fresh.isEmpty) return;
      entries = fresh;
      refreshed = true;
      try {
        await PrefsManager.instance.setString(_cacheKey, res.body);
      } on StateError {
        // Storage not ready; the list lasts for this session only.
      }
      _notify();
    } catch (e) {
      debugPrint('Channel directory not refreshed: $e');
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
