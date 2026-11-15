import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/prefs_manager.dart';

/// The colour or photo someone picked for one node. Only on this phone; it
/// is never sent over the mesh.
@immutable
class NodeLook {
  const NodeLook({this.colorValue, this.photo});

  /// ARGB colour, or null for the app's own colour.
  final int? colorValue;

  /// A small JPEG, or null for no photo.
  final Uint8List? photo;

  bool get isEmpty => colorValue == null && (photo == null || photo!.isEmpty);

  Map<String, Object> toJson() {
    final p = photo;
    return {
      'c': ?colorValue,
      if (p != null && p.isNotEmpty) 'p': base64Encode(p),
    };
  }

  static NodeLook? fromJson(Object? json) {
    if (json is! Map) return null;
    final c = json['c'];
    final p = json['p'];
    Uint8List? photo;
    if (p is String && p.isNotEmpty) {
      try {
        photo = base64Decode(p);
      } on FormatException {
        photo = null;
      }
    }
    final look = NodeLook(colorValue: c is int ? c : null, photo: photo);
    return look.isEmpty ? null : look;
  }
}

/// Every node's chosen colour or photo, keyed by public key (lower-case
/// hex). Kept in the app's preferences, so encrypted backups carry it.
class NodeLookStore extends ChangeNotifier {
  NodeLookStore({SharedPreferences? prefs}) : _prefsOverride = prefs;

  /// The one the app uses.
  static final NodeLookStore instance = NodeLookStore();

  /// Preference key; the value is a JSON map of key → look.
  static const prefsKey = 'node_looks_v1';

  /// Photos are stored this small (pixels on the long side).
  static const photoSize = 256;

  /// At most this many bytes per photo, so backups stay small.
  static const maxPhotoBytes = 96 * 1024;

  final SharedPreferences? _prefsOverride;
  Map<String, NodeLook>? _looks;

  SharedPreferences get _prefs => _prefsOverride ?? PrefsManager.instance;

  Map<String, NodeLook> get _all => _looks ??= _load();

  Map<String, NodeLook> _load() {
    final raw = _prefs.getString(prefsKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return {};
      return {
        for (final e in decoded.entries)
          e.key.toString(): ?NodeLook.fromJson(e.value),
      };
    } on FormatException catch (e) {
      debugPrint('Node looks unreadable, starting fresh: $e');
      return {};
    }
  }

  static String _norm(String key) => key.toLowerCase();

  /// The look for [nodeKey], or null if none was picked.
  NodeLook? lookFor(String nodeKey) => _all[_norm(nodeKey)];

  /// Sets the colour for [nodeKey]; null clears it.
  Future<void> setColor(String nodeKey, int? colorValue) => _update(
    nodeKey,
    (old) => NodeLook(colorValue: colorValue, photo: old?.photo),
  );

  /// Sets the photo for [nodeKey]; null clears it. Rejects photos over
  /// [maxPhotoBytes].
  Future<void> setPhoto(String nodeKey, Uint8List? photo) {
    if (photo != null && photo.length > maxPhotoBytes) {
      throw ArgumentError.value(
        photo.length,
        'photo',
        'Larger than $maxPhotoBytes bytes',
      );
    }
    return _update(
      nodeKey,
      (old) => NodeLook(colorValue: old?.colorValue, photo: photo),
    );
  }

  /// Removes both colour and photo for [nodeKey].
  Future<void> clear(String nodeKey) => _update(nodeKey, (_) => null);

  Future<void> _update(
    String nodeKey,
    NodeLook? Function(NodeLook? old) change,
  ) async {
    final key = _norm(nodeKey);
    final next = change(_all[key]);
    if (next == null || next.isEmpty) {
      _all.remove(key);
    } else {
      _all[key] = next;
    }
    await _prefs.setString(
      prefsKey,
      jsonEncode({for (final e in _all.entries) e.key: e.value.toJson()}),
    );
    notifyListeners();
  }

  /// Re-reads from preferences, e.g. after a backup is restored.
  void reload() {
    _looks = null;
    notifyListeners();
  }
}
