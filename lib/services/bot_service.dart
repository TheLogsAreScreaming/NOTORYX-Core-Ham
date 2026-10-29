import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/bot_replies.dart';
import '../models/bot_settings.dart';
import '../models/message.dart';
import '../storage/prefs_manager.dart';
import 'bot_engine.dart';
import 'weather_service.dart';

class BotService extends ChangeNotifier {
  final MeshCoreConnector connector;

  /// Source for `!weather`; without it the command says it's unavailable.
  final WeatherService? weather;
  final math.Random _random = math.Random();
  final BotEngine _engine = BotEngine();
  StreamSubscription<Message>? _subscription;
  BotSettings _settings = BotSettings();
  bool _ready = false;
  bool _disposed = false;
  String? _error;
  int _revision = 0;
  Future<void> _writes = Future<void>.value();
  final List<String> _activity = [];

  BotService(this.connector, {this.weather});

  BotSettings get settings => _settings;
  bool get ready => _ready;
  String? get error => _error;
  List<String> get activity => List.unmodifiable(_activity);

  Future<void> load() async {
    try {
      final prefs = PrefsManager.instance;
      final saved = prefs.getString('bcs_bot_settings_v1');
      if (saved != null) {
        _settings = BotSettings.fromJson(
          jsonDecode(saved) as Map<String, dynamic>,
        );
      }
      final budget = prefs.getString('bcs_bot_budget_v1');
      if (budget != null) {
        _engine.restoreBudget(jsonDecode(budget) as Map<String, dynamic>);
      }
    } catch (_) {
      _settings = BotSettings();
      _error = 'Bot settings could not be loaded. Bot Mode is off.';
    }
    _ready = true;
    if (!_disposed) {
      _subscription = connector.receivedDirectMessages.listen(
        (message) => unawaited(_receive(message)),
      );
    }
    _notify();
  }

  Future<void> save(BotSettings settings) async {
    if (!_ready || _disposed) {
      return;
    }
    if (settings.enabled &&
        (!isValidBotResponse(settings.awayMessage) ||
            !isValidBotResponse(settings.info) ||
            !isValidBotResponse(settings.checkIn) ||
            settings.rules.any(
              (r) =>
                  r.trigger.trim().isEmpty || !isValidBotResponse(r.response),
            ))) {
      throw ArgumentError(
        'Responses must fit within 140 UTF-8 bytes including the bot marker.',
      );
    }
    // Disable/modify immediately; queued writes preserve the latest user choice.
    _settings = settings;
    _revision++;
    _error = null;
    _notify();
    try {
      await _write('bcs_bot_settings_v1', jsonEncode(settings.toJson()));
    } catch (_) {
      _settings = _settings.copyWith(enabled: false);
      _revision++;
      _error = 'Settings could not be saved. Bot Mode is off.';
      _notify();
    }
  }

  Future<void> _write(String key, String value) {
    final next = _writes.then((_) async {
      if (!await PrefsManager.instance.setString(key, value)) {
        throw StateError('Could not persist bot settings');
      }
    });
    _writes = next.catchError((Object _) {});
    return next;
  }

  Map<String, String> _responses(Message message, WeatherNow? weatherNow) {
    final commands = [
      ..._settings.commands,
      if (_settings.shareLocation) '!where',
      ..._settings.rules
          .where((r) => r.enabled && !r.contains)
          .map((r) => r.trigger),
    ];
    final latitude = connector.selfLatitude;
    final help = 'Commands: ${commands.join(' ')}';
    final longitude = connector.selfLongitude;
    final hasLocation =
        latitude != null &&
        longitude != null &&
        latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180 &&
        (latitude != 0 || longitude != 0);
    // Advertised coordinates may be configured/stale. Never claim live GPS.
    return {
      '!ping': 'Pong — NOTORYX Core online',
      '!status':
          'Radio connected; ${connector.contacts.length} contacts; '
          '${connector.contacts.where((c) => c.type == advTypeRepeater).length} known repeaters.',
      '!battery': connector.batteryPercent == null
          ? 'Radio battery unavailable.'
          : 'Radio battery: ${connector.batteryPercent}%',
      '!help': isValidBotResponse(help)
          ? help
          : 'Command list is too long. Ask the owner for enabled commands.',
      '!info': _settings.info,
      '!checkin': _settings.checkIn,
      '!repeater':
          '${connector.contacts.where((c) => c.type == advTypeRepeater).length} known repeaters; '
          '${connector.directRepeaters.length} in direct-repeater history. Availability is not guaranteed.',
      '!sun': hasLocation
          ? sunReply(latitude, longitude, DateTime.now())
          : 'Sun times need the radio\u2019s GPS position.',
      '!moon': moonReply(DateTime.now()),
      '!weather':
          weatherNow?.reply(DateTime.now()) ??
          'Weather unavailable: needs the radio\u2019s GPS and phone internet.',
      '!trace': traceReply(message.pathBytes, message.pathLength),
      if (_settings.shareLocation)
        '!where': hasLocation
            ? 'Radio advertised location (may be stale): ${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}'
            : 'Radio advertised location unavailable.',
    };
  }

  Future<void> _receive(Message message) async {
    if (_disposed || !_ready || !connector.isConnected) {
      return;
    }
    final contact = connector.getContactByPubKeyHex(message.senderKeyHex);
    final radioKey = connector.selfPublicKeyHex;
    final revision = _revision;
    // Only !weather needs the network; fetch before the synchronous engine.
    final wantsWeather =
        message.text.trim().toLowerCase() == '!weather' &&
        _settings.enabled &&
        _settings.commands.contains('!weather');
    final weatherNow = wantsWeather ? await weather?.weather() : null;
    if (_disposed) return;
    final response = _engine.reply(
      settings: _settings,
      messageId: '${connector.selfPublicKeyHex}:${message.messageId}',
      sender: message.senderKeyHex,
      text: message.text,
      timestamp: message.timestamp,
      now: DateTime.now(),
      commandResponses: _responses(message, weatherNow),
      argCommands: {
        '!dice': (args) =>
            rollDice(args, _random) ?? 'Try !dice, !dice 20 or !dice 2d6.',
      },
      eligible:
          !message.isOutgoing &&
          !message.isCli &&
          message.senderKeyHex != connector.selfPublicKeyHex &&
          contact?.type == advTypeChat &&
          Message.parseReaction(message.text) == null,
    );
    if (response == null || contact == null) {
      return;
    }
    try {
      await _write('bcs_bot_budget_v1', jsonEncode(_engine.budget));
      if (_disposed ||
          connector.selfPublicKeyHex != radioKey ||
          revision != _revision ||
          !_settings.enabled ||
          !connector.isConnected) {
        return;
      }
      await connector.sendMessage(contact, response);
      _record('Reply queued. Check the conversation for delivery status.');
    } catch (_) {
      _record('Reply failed. No automatic bot retry was added.');
    }
  }

  void _record(String message) {
    _activity.insert(0, '${DateTime.now().toLocal()}: $message');
    if (_activity.length > 20) {
      _activity.removeLast();
    }
    _notify();
  }

  void _notify() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _subscription?.cancel();
    super.dispose();
  }
}
