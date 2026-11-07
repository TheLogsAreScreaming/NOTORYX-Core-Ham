import 'dart:async';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/message_retry_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  test('flood setting round-trips and defaults to 2', () {
    expect(AppSettings().messageFloodAttempts, 2);
    final back = AppSettings.fromJson(
      AppSettings(messageFloodAttempts: 4).toJson(),
    );
    expect(back.messageFloodAttempts, 4);
  });

  test('after the direct tries, a message floods, then fails', () async {
    final settings = AppSettingsService();
    await settings.loadSettings();
    await settings.setMaxMessageRetries(2);
    await settings.setMessageFloodAttempts(2);

    final contact = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 7)),
      name: 'Sam',
      type: advTypeChat,
      pathLength: 1,
      path: Uint8List.fromList([0xAB]),
      lastSeen: DateTime.now(),
    );
    final attempts = <int>[];
    final floods = <int>[];
    Message? last;
    final service = MessageRetryService();
    final selfKey = Uint8List.fromList(List.filled(32, 9));

    fakeAsync((async) {
      service.initialize(
        RetryServiceConfig(
          sendMessage: (c, text, attempt, ts) {
            attempts.add(attempt);
            // The radio answers RESP_CODE_SENT with the ACK hash it expects.
            final hash = MessageRetryService.computeExpectedAckHash(
              ts,
              attempt,
              text,
              selfKey,
            );
            scheduleMicrotask(() => service.updateMessageFromSent(hash, 500));
          },
          getSelfPublicKey: () => selfKey,
          addMessage: (_, m) => last = m,
          updateMessage: (m) => last = m,
          clearContactPath: (c) async => floods.add(attempts.length),
          setContactPath: (c, p, n) async {},
          calculateTimeout: (len, bytes, {contactKey, deviceTimeoutMs}) => 500,
          appSettingsService: settings,
        ),
      );
      expect(service.totalAttempts, 4);
      service.sendMessageWithRetry(contact: contact, text: 'hi');
      async.elapse(const Duration(minutes: 2));
    });

    // Two direct tries, then two floods (the route is cleared before each).
    expect(attempts, [0, 1, 2, 3]);
    expect(floods, [2, 3]);
    expect(last?.status, MessageStatus.failed);
    settings.dispose();
  });
}
