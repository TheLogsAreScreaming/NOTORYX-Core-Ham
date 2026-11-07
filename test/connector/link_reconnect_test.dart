import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MeshCoreConnector connector;
  late List<LinkTarget> attempts;
  late bool radioBack;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    attempts = [];
    radioBack = false;
    connector = MeshCoreConnector()
      ..debugLinkReconnectOverride = (target) async {
        attempts.add(target);
        if (!radioBack) throw StateError('Connection refused');
      };
  });

  /// The link drops the way a closed socket or pulled cable reports it.
  void drop(FakeAsync async) {
    unawaited(connector.disconnect(manual: false));
    async.flushMicrotasks();
  }

  test('a dropped TCP link is retried on the same endpoint', () {
    fakeAsync((async) {
      const target = TcpLinkTarget('192.168.1.40', 5000);
      connector.debugRememberLink(target);
      drop(async);

      expect(connector.isAutoReconnectScheduled, isTrue);
      expect(attempts, isEmpty);
      async.elapse(const Duration(seconds: 1));
      expect(attempts, [target]);
    });
  });

  test('a dropped USB link is retried on the same port', () {
    fakeAsync((async) {
      const target = UsbLinkTarget('/dev/cu.usbmodem101', 115200);
      connector.debugRememberLink(target);
      drop(async);

      async.elapse(const Duration(seconds: 1));
      expect(attempts, [target]);
    });
  });

  test('failed retries back off, capped at 30 seconds', () {
    fakeAsync((async) {
      connector.debugRememberLink(const TcpLinkTarget('radio.local', 5000));
      drop(async);

      // 1, 2, 4, 8, 16, 30, 30 seconds apart.
      final times = <Duration>[];
      var elapsed = Duration.zero;
      while (times.length < 7) {
        async.elapse(const Duration(milliseconds: 500));
        elapsed += const Duration(milliseconds: 500);
        if (attempts.length > times.length) times.add(elapsed);
      }
      final gaps = [
        times.first.inSeconds,
        for (var i = 1; i < times.length; i++)
          (times[i] - times[i - 1]).inSeconds,
      ];
      expect(gaps, [1, 2, 4, 8, 16, 30, 30]);
      expect(connector.isAutoReconnectScheduled, isTrue);
    });
  });

  test('retries stop once the radio is back', () {
    fakeAsync((async) {
      connector.debugRememberLink(const TcpLinkTarget('radio.local', 5000));
      drop(async);
      async.elapse(const Duration(seconds: 1));
      expect(attempts, hasLength(1));

      radioBack = true;
      async.elapse(const Duration(seconds: 2));
      expect(attempts, hasLength(2));
      async.elapse(const Duration(minutes: 5));
      expect(attempts, hasLength(2));
    });
  });

  test('a manual disconnect never reconnects', () {
    fakeAsync((async) {
      connector.debugRememberLink(const TcpLinkTarget('radio.local', 5000));
      drop(async);
      expect(connector.isAutoReconnectScheduled, isTrue);

      unawaited(connector.disconnect());
      async.flushMicrotasks();
      expect(connector.isAutoReconnectScheduled, isFalse);
      expect(connector.reconnectTarget, isNull);

      async.elapse(const Duration(minutes: 5));
      expect(attempts, isEmpty);
    });
  });

  test('nothing is retried when no wired link ever connected', () {
    fakeAsync((async) {
      drop(async);
      expect(connector.isAutoReconnectScheduled, isFalse);
      async.elapse(const Duration(minutes: 5));
      expect(attempts, isEmpty);
    });
  });

  test('a link target compares by its address', () {
    expect(const TcpLinkTarget('a', 1), const TcpLinkTarget('a', 1));
    expect(const TcpLinkTarget('a', 1) == const TcpLinkTarget('a', 2), isFalse);
    expect(
      const UsbLinkTarget('p', 9600) == const UsbLinkTarget('p', 115200),
      isFalse,
    );
  });
}
