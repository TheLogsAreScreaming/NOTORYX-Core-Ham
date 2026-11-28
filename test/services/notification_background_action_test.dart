import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

NotificationResponse _action(String? id, {String? input}) =>
    NotificationResponse(
      notificationResponseType:
          NotificationResponseType.selectedNotificationAction,
      actionId: id,
      payload: 'message:aabbcc',
      input: input,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    IsolateNameServer.removePortNameMapping(notificationActionPortName);
  });

  test('a background action is handed to the running app', () async {
    final port = ReceivePort();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      notificationActionPortName,
    );

    await notificationActionBackgroundHandler(_action('reply', input: 'ok'));

    final message = await port.first as Map;
    expect(message['actionId'], 'reply');
    expect(message['payload'], 'message:aabbcc');
    expect(message['input'], 'ok');
  });

  test('with no app running, a reply is kept for the next start', () async {
    SharedPreferences.setMockInitialValues({});

    await notificationActionBackgroundHandler(_action('reply', input: 'ok'));

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('notification_held_reply'), contains('"ok"'));
  });

  test('with no app running, mark as read is not kept', () async {
    SharedPreferences.setMockInitialValues({});

    await notificationActionBackgroundHandler(_action('mark_read'));

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('notification_held_reply'), isNull);
  });

  test('mark as read reports the conversation, not a reply', () async {
    final service = NotificationService();
    final marked = service.markReads.first;
    var replied = false;
    final sub = service.replies.listen((_) => replied = true);

    service.handleResponseForTest(_action('mark_read'));

    expect(await marked, 'message:aabbcc');
    expect(replied, isFalse);
    await sub.cancel();
  });
}
