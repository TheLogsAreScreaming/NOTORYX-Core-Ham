import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/gif_helper.dart';
import '../helpers/reaction_helper.dart';
import '../models/message.dart';
import 'app_settings_service.dart';

/// Speaks text. The default uses the phone's text-to-speech engine.
abstract class Speaker {
  Future<void> speak(String text);
  Future<void> stop();
}

class TtsSpeaker implements Speaker {
  final FlutterTts _tts = FlutterTts();
  bool _configured = false;

  @override
  Future<void> speak(String text) async {
    if (!_configured) {
      // Resolve speak() only when speech ends, so messages don't overlap.
      await _tts.awaitSpeakCompletion(true);
      _configured = true;
    }
    await _tts.speak(text);
  }

  @override
  Future<void> stop() => _tts.stop();
}

/// The words to say for a message: the app's tags become plain words,
/// links are not spelled out, and very long text is cut short. Returns null
/// for things not worth saying (GIFs, reactions, empty text).
String? spokenText(String text) {
  var t = text.trim();
  if (t.isEmpty ||
      GifHelper.parseGif(t) != null ||
      ReactionHelper.parseReaction(t) != null) {
    return null;
  }
  t = t
      .replaceFirst(RegExp(r'^\[(?:NOTORYX|Bastion) SOS\]\s*'), 'S O S. ')
      .replaceFirst(
        RegExp(r'^\[(?:NOTORYX|Bastion) Check-in\]\s*'),
        'Check-in. ',
      )
      .replaceAll(RegExp(r'https?://\S+'), 'a link')
      .replaceAll(' | ', '. ');
  if (t.length > 300) t = '${t.substring(0, 300)}…';
  return t;
}

/// Reads messages aloud: on request from a message's menu, and incoming
/// ones automatically per the "Read messages aloud" setting while the app
/// is open.
class ReadAloudService {
  final MeshCoreConnector _connector;
  final AppSettingsService _settings;
  final Speaker _speaker;
  final List<StreamSubscription<Object>> _subs = [];
  Future<void> _queue = Future<void>.value();
  int _queued = 0;
  bool foreground = true;

  /// Automatic reading skips messages once this many are waiting, so a burst
  /// after reconnecting doesn't talk for minutes.
  static const maxQueued = 3;

  ReadAloudService(this._connector, this._settings, {Speaker? speaker})
    : _speaker = speaker ?? TtsSpeaker() {
    _subs.add(_connector.receivedDirectMessages.listen(_onDirect));
    _subs.add(_connector.receivedChannelMessages.listen(_onChannel));
  }

  String get _mode => _settings.settings.readAloudIncoming;

  void _onDirect(Message message) {
    if (!foreground || _mode == 'off') return;
    final name = _connector.contacts
        .where((c) => c.publicKeyHex == message.senderKeyHex)
        .map((c) => c.name)
        .firstOrNull;
    final words = spokenText(message.text);
    if (words == null) return;
    _enqueue('${name ?? 'Someone'} says: $words', automatic: true);
  }

  void _onChannel(ReceivedChannelMessage event) {
    if (!foreground || _mode != 'all') return;
    final words = spokenText(event.message.text);
    if (words == null) return;
    _enqueue(
      '${event.message.senderName} on ${event.channelName}: $words',
      automatic: true,
    );
  }

  /// Reads one message now, from its menu.
  Future<void> read(String sender, String text) {
    final words = spokenText(text) ?? text.trim();
    return _enqueue('$sender says: $words', automatic: false);
  }

  Future<void> stop() async {
    _queued = 0;
    _queue = Future<void>.value();
    try {
      await _speaker.stop();
    } catch (_) {}
  }

  Future<void> _enqueue(String text, {required bool automatic}) {
    if (automatic && _queued >= maxQueued) return Future<void>.value();
    _queued++;
    final next = _queue.then((_) async {
      try {
        await _speaker.speak(text);
      } catch (e) {
        debugPrint('Read aloud failed: $e');
      } finally {
        if (_queued > 0) _queued--;
      }
    });
    _queue = next;
    return next;
  }

  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    unawaited(stop());
  }
}
