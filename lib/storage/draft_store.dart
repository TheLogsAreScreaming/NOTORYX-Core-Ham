import 'dart:async';

import 'package:flutter/widgets.dart';

import 'secure_prefs.dart';

/// Unsent message text, kept per conversation and per radio so it survives
/// leaving the chat and restarting the app.
class DraftStore {
  static const _prefix = 'draft_';

  static String _radio(String selfKeyHex) =>
      selfKeyHex.length > 10 ? selfKeyHex.substring(0, 10) : selfKeyHex;

  static String contactKey(String selfKeyHex, String contactKeyHex) =>
      '$_prefix${_radio(selfKeyHex)}_c_$contactKeyHex';

  static String channelKey(String selfKeyHex, int channelIndex) =>
      '$_prefix${_radio(selfKeyHex)}_ch_$channelIndex';

  static String? load(String key) {
    try {
      final text = SecurePrefs.getString(key);
      return (text == null || text.isEmpty) ? null : text;
    } on StateError {
      return null; // Storage not ready (tests, early startup).
    }
  }

  static Future<void> save(String key, String text) async {
    try {
      if (text.trim().isEmpty) {
        await SecurePrefs.remove(key);
      } else {
        await SecurePrefs.setString(key, text);
      }
    } on StateError {
      // Storage not ready; the draft just isn't kept.
    }
  }
}

/// Keeps a text field's draft in [DraftStore]: restores it on [attach] and
/// saves changes shortly after typing stops, and on [dispose].
class DraftKeeper {
  final TextEditingController controller;
  final String key;
  Timer? _timer;
  String _saved = '';

  DraftKeeper(this.controller, this.key);

  /// Restores a saved draft into an empty field, then starts saving.
  void attach() {
    final draft = DraftStore.load(key);
    if (draft != null && controller.text.isEmpty) {
      controller.value = TextEditingValue(
        text: draft,
        selection: TextSelection.collapsed(offset: draft.length),
      );
    }
    _saved = controller.text;
    controller.addListener(_changed);
  }

  void _changed() {
    if (controller.text == _saved) return;
    _timer?.cancel();
    // Sending clears the field; forget the draft at once.
    if (controller.text.isEmpty) {
      _flush();
      return;
    }
    _timer = Timer(const Duration(milliseconds: 400), _flush);
  }

  void _flush() {
    _timer?.cancel();
    _saved = controller.text;
    unawaited(DraftStore.save(key, _saved));
  }

  /// Saves what's in the field now. Call before disposing the controller.
  void dispose() {
    controller.removeListener(_changed);
    if (controller.text != _saved) _flush();
    _timer?.cancel();
  }
}
