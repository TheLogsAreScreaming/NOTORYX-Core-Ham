import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/repeater_login_doctor.dart';

void main() {
  group('diagnoseLogin', () {
    LoginFailure? d({
      bool connected = true,
      bool sendFailed = false,
      bool? result,
      bool flood = false,
    }) => diagnoseLogin(
      radioConnected: connected,
      sendFailed: sendFailed,
      result: result,
      usedFlood: flood,
    );

    test('success has nothing to explain', () {
      expect(d(result: true), isNull);
    });

    test('each step names its own failure', () {
      expect(d(connected: false), LoginFailure.radioOffline);
      expect(d(sendFailed: true), LoginFailure.sendFailed);
      expect(d(result: false), LoginFailure.rejected);
      expect(d(), LoginFailure.noAnswerPath);
      expect(d(flood: true), LoginFailure.noAnswerFlood);
    });

    test('an offline radio wins over a failed send', () {
      expect(d(connected: false, sendFailed: true), LoginFailure.radioOffline);
    });
  });

  group('read-back', () {
    test('only plain settings are read back', () {
      expect(readBackCommand('set flood.max 8'), 'get flood.max');
      expect(readBackCommand('set name Ridge North'), 'get name');
      expect(readBackCommand('set guest.password hunter2'), isNull);
      expect(readBackCommand('set prv.key abcd'), isNull);
      expect(readBackCommand('set radio 910.525,62.5,7,5'), isNull);
      expect(readBackCommand('password hunter2'), isNull);
    });

    test('matching values, numbers and flags confirm', () {
      expect(checkReadBack('set flood.max 8', '> 8'), isA<ReadBackMatch>());
      expect(
        checkReadBack('set lat 40.1', '> 40.100000'),
        isA<ReadBackMatch>(),
      );
      expect(checkReadBack('set tx 22', '> 22 dBm'), isA<ReadBackMatch>());
      expect(checkReadBack('set repeat on', '> 1'), isA<ReadBackMatch>());
      expect(checkReadBack('set multi.acks 0', '> off'), isA<ReadBackMatch>());
      expect(
        checkReadBack('set name Ridge North', '> Ridge North'),
        isA<ReadBackMatch>(),
      );
    });

    test('a different value is reported with what the repeater says', () {
      final r = checkReadBack('set flood.max 8', '> 5');
      expect(r, isA<ReadBackMismatch>());
      expect((r as ReadBackMismatch).actual, '5');
      expect(checkReadBack('set repeat on', '> off'), isA<ReadBackMismatch>());
    });

    test('a reply without a value is unreadable, not a mismatch', () {
      expect(checkReadBack('set flood.max 8', 'OK'), isA<ReadBackUnreadable>());
      expect(checkReadBack('set flood.max 8', ''), isA<ReadBackUnreadable>());
    });
  });
}
