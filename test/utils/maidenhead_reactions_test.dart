import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/reaction_helper.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/utils/grid_coords.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  final _frames = StreamController<Uint8List>.broadcast();
  final sent = <Uint8List>[];
  @override
  bool get isConnected => true;
  @override
  Stream<Uint8List> get receivedFrames => _frames.stream;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(frame);
    scheduleMicrotask(() => _frames.add(Uint8List.fromList([respCodeOk])));
  }
}

void main() {
  group('Maidenhead', () {
    test('known locators', () {
      // Munich, the textbook example.
      expect(toMaidenhead(48.14666, 11.60833), 'JN58td');
      expect(toMaidenhead(48.14666, 11.60833, precision: 8), 'JN58td25');
      expect(toMaidenhead(48.14666, 11.60833, precision: 4), 'JN58');
      // ARRL HQ, W1AW, Newington CT.
      expect(toMaidenhead(41.714775, -72.727260), 'FN31pr');
      // Southern and eastern hemispheres.
      expect(toMaidenhead(-33.8688, 151.2093), 'QF56od');
    });

    test('the grid edges stay inside the grid', () {
      expect(toMaidenhead(90, 180), 'RR99xx');
      expect(toMaidenhead(-90, -180), 'AA00aa');
    });

    test('is a coordinate format', () {
      expect(CoordinateFormat.parse('maidenhead'), CoordinateFormat.maidenhead);
      expect(
        formatCoordinate(48.14666, 11.60833, CoordinateFormat.maidenhead),
        'JN58td',
      );
    });
  });

  group('Reactions over the radio', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    test('setting round-trips and rejects unknown values', () async {
      expect(AppSettings().reactionsOverRadio, 'auto');
      expect(
        AppSettings.fromJson({
          'reactions_over_radio': 'off',
        }).reactionsOverRadio,
        'off',
      );
      expect(
        AppSettings.fromJson({'reactions_over_radio': 'x'}).reactionsOverRadio,
        'auto',
      );
      final service = AppSettingsService();
      await service.setReactionsOverRadio('on');
      await service.setReactionsOverRadio('bogus');
      expect(service.settings.reactionsOverRadio, 'on');
    });

    test('automatic keeps reactions local on the EU 868 band only', () async {
      final radio = _Radio();
      final settings = AppSettingsService();
      radio.debugUseChannelStore('a' * 64, settings);
      radio.debugSetFrequencyHz(869525000);
      expect(radio.isOnEuDutyCycleBand, isTrue);
      expect(radio.sendsReactionsOverRadio, isFalse);
      radio.debugSetFrequencyHz(910525000);
      expect(radio.sendsReactionsOverRadio, isTrue);
      radio.debugSetFrequencyHz(null);
      expect(radio.sendsReactionsOverRadio, isTrue);
      await settings.setReactionsOverRadio('off');
      expect(radio.sendsReactionsOverRadio, isFalse);
      radio.debugSetFrequencyHz(869525000);
      await settings.setReactionsOverRadio('on');
      expect(radio.sendsReactionsOverRadio, isTrue);
      radio.dispose();
    });

    test('a local-only channel reaction is never sent', () async {
      final radio = _Radio();
      final settings = AppSettingsService();
      radio.debugUseChannelStore('a' * 64, settings);
      await settings.setReactionsOverRadio('off');
      final channel = Channel(index: 0, name: 'Public', psk: Uint8List(16));
      final reaction = ReactionHelper.encodeReaction('abcd', '01');
      await radio
          .sendChannelMessage(channel, reaction)
          .timeout(const Duration(seconds: 2));
      expect(radio.sent.where((f) => f[0] == cmdSendChannelTxtMsg), isEmpty);

      await settings.setReactionsOverRadio('on');
      final other = ReactionHelper.encodeReaction('beef', '02');
      await radio
          .sendChannelMessage(channel, other)
          .timeout(const Duration(seconds: 2));
      expect(
        radio.sent.where((f) => f[0] == cmdSendChannelTxtMsg),
        hasLength(1),
      );
      radio.dispose();
    });
  });
}
