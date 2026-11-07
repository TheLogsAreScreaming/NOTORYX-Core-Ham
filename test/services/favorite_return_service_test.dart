import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/services/favorite_return_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final start = DateTime(2026, 11, 7, 8);

Contact contact(
  int n, {
  required DateTime seen,
  bool favorite = true,
  DateTime? message,
}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: 'Ridge $n',
  type: advTypeChat,
  pathLength: 0,
  path: Uint8List(0),
  lastSeen: seen,
  lastMessageAt: message,
  flags: favorite ? contactFlagFavorite : 0,
);

class _Radio extends MeshCoreConnector {
  bool connected = false;
  bool loading = false;
  List<Contact> list = [];
  @override
  bool get isConnected => connected;
  @override
  bool get isLoadingContacts => loading;
  @override
  List<Contact> get contacts => list;
  void changed() => notifyListeners();
}

void main() {
  group('FavoriteReturnWatch', () {
    late DateTime now;
    late FavoriteReturnWatch watch;
    const sixHours = Duration(hours: 6);

    setUp(() {
      now = start;
      watch = FavoriteReturnWatch(clock: () => now);
    });

    test('the first look only records', () {
      final back = watch.observe([
        contact(1, seen: start.subtract(const Duration(days: 2))),
      ], quiet: sixHours);
      expect(back, isEmpty);
    });

    test('heard again after a long silence: notifies once', () {
      watch.observe([
        contact(1, seen: start.subtract(const Duration(hours: 1))),
      ], quiet: sixHours);

      now = start.add(const Duration(hours: 7));
      final back = watch.observe([contact(1, seen: now)], quiet: sixHours);
      expect(back.single.name, 'Ridge 1');
      expect(back.single.quiet.inHours, 8);

      // Further adverts soon after are not a new return.
      now = now.add(const Duration(minutes: 30));
      expect(watch.observe([contact(1, seen: now)], quiet: sixHours), isEmpty);
    });

    test('a short silence does not notify', () {
      watch.observe([contact(1, seen: start)], quiet: sixHours);
      now = start.add(const Duration(hours: 2));
      expect(watch.observe([contact(1, seen: now)], quiet: sixHours), isEmpty);
    });

    test('silence is timed by this phone, not the node clock', () {
      // The node's clock is a year behind: its adverts still count as
      // activity when they change, and the gap is measured here.
      final wrong = start.subtract(const Duration(days: 365));
      watch.observe([contact(1, seen: wrong)], quiet: sixHours);
      now = start.add(const Duration(minutes: 10));
      expect(
        watch.observe([
          contact(1, seen: wrong.add(const Duration(minutes: 10))),
        ], quiet: sixHours),
        hasLength(1),
        reason: 'first change after a stale advert time is a return',
      );
      now = now.add(const Duration(hours: 1));
      expect(
        watch.observe([
          contact(1, seen: wrong.add(const Duration(hours: 1))),
        ], quiet: sixHours),
        isEmpty,
      );
    });

    test('a node clock ahead of this phone is never trusted', () {
      watch.observe([
        contact(1, seen: start.add(const Duration(days: 3))),
      ], quiet: sixHours);
      now = start.add(const Duration(hours: 1));
      expect(
        watch.observe([
          contact(1, seen: start.add(const Duration(days: 4))),
        ], quiet: sixHours),
        isEmpty,
      );
    });

    test('a direct message also counts as being heard', () {
      watch.observe([contact(1, seen: start)], quiet: sixHours);
      now = start.add(const Duration(hours: 9));
      final back = watch.observe([
        contact(1, seen: start, message: now),
      ], quiet: sixHours);
      expect(back, hasLength(1));
    });

    test('only favorites, and off when quiet is zero', () {
      watch.observe([
        contact(1, seen: start),
        contact(2, seen: start, favorite: false),
      ], quiet: sixHours);
      now = start.add(const Duration(hours: 9));
      expect(
        watch.observe([
          contact(1, seen: now),
          contact(2, seen: now, favorite: false),
        ], quiet: Duration.zero),
        isEmpty,
      );
    });
  });

  group('FavoriteReturnService', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    test('the contact sync after connecting never notifies', () {
      fakeAsync((async) {
        var now = start;
        final radio = _Radio();
        final notified = <FavoriteReturn>[];
        final service = FavoriteReturnService(
          radio,
          quietHours: () => 6,
          notify: (b) async => notified.add(b),
          watch: FavoriteReturnWatch(clock: () => now),
        );
        // The connector batches change notifications.
        void step(void Function() change) {
          change();
          radio.changed();
          async.elapse(const Duration(milliseconds: 200));
        }

        step(
          () => radio
            ..connected = true
            ..loading = true,
        );
        // The sync reports an advert heard while the app was closed.
        step(
          () => radio.list = [
            contact(1, seen: start.subtract(const Duration(days: 1))),
          ],
        );
        step(() => radio.loading = false);
        expect(notified, isEmpty);

        now = start.add(const Duration(hours: 1));
        step(() => radio.list = [contact(1, seen: now)]);
        expect(notified.single.name, 'Ridge 1');

        // A reconnect starts over without notifying for the sync.
        step(() => radio.connected = false);
        step(
          () => radio
            ..connected = true
            ..list = [contact(1, seen: now.add(const Duration(days: 2)))],
        );
        expect(notified, hasLength(1));
        service.dispose();
        radio.dispose();
      });
    });
  });

  test('the quiet-time setting defaults to 6 hours and round-trips', () {
    expect(AppSettings().favoriteReturnHours, 6);
    expect(AppSettings.fromJson(const {}).favoriteReturnHours, 6);
    final off = AppSettings().copyWith(favoriteReturnHours: 0);
    expect(AppSettings.fromJson(off.toJson()).favoriteReturnHours, 0);
  });
}
