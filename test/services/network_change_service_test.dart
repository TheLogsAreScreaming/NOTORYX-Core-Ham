import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/network_changes_screen.dart';
import 'package:meshcore_open/services/network_change_service.dart';
import 'package:provider/provider.dart';

final t0 = DateTime(2026, 11, 8, 12);

Contact repeater(
  int seed,
  String name, {
  int hops = 1,
  DateTime? seen,
  bool favourite = false,
  int type = advTypeRepeater,
}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, seed)),
  name: name,
  type: type,
  pathLength: hops,
  path: Uint8List(hops < 0 ? 0 : hops),
  lastSeen: seen ?? t0,
  flags: favourite ? contactFlagFavorite : 0,
);

void main() {
  late DateTime now;
  late NetworkChangeWatch watch;
  setUp(() {
    now = t0;
    watch = NetworkChangeWatch(clock: () => now);
  });

  List<NetworkChange> look(
    List<Contact> cs, {
    int quietH = 24,
    bool nearby = true,
  }) => watch.observe(
    cs,
    quiet: Duration(hours: quietH),
    newNearby: nearby,
  );

  test('the first look only records', () {
    expect(look([repeater(1, 'Ridge'), repeater(2, 'Valley')]), isEmpty);
    expect(watch.known, hasLength(2));
  });

  test('a new repeater within one hop is reported once', () {
    look([repeater(1, 'Ridge')]);
    final changes = look([repeater(1, 'Ridge'), repeater(3, 'Peak', hops: 0)]);
    expect(changes.single.kind, NetworkChangeKind.newRepeater);
    expect(changes.single.name, 'Peak');
    expect(changes.single.hops, 0);
    expect(look([repeater(1, 'Ridge'), repeater(3, 'Peak', hops: 0)]), isEmpty);
  });

  test('far, flood-only or non-repeater newcomers are not reported', () {
    look([repeater(1, 'Ridge')]);
    expect(
      look([
        repeater(1, 'Ridge'),
        repeater(4, 'Far', hops: 3),
        repeater(5, 'Flood', hops: -1),
        repeater(6, 'Sam', type: advTypeChat, hops: 0),
      ]),
      isEmpty,
    );
  });

  test('new-nearby alerts can be turned off', () {
    look([repeater(1, 'Ridge')]);
    expect(
      look([repeater(1, 'Ridge'), repeater(3, 'Peak')], nearby: false),
      isEmpty,
    );
  });

  test('a favourite repeater going quiet is reported once, until heard', () {
    final fav = repeater(1, 'Ridge', favourite: true);
    look([fav]);
    now = t0.add(const Duration(hours: 23));
    expect(look([fav]), isEmpty);
    now = t0.add(const Duration(hours: 25));
    final quiet = look([fav]);
    expect(quiet.single.kind, NetworkChangeKind.wentQuiet);
    expect(quiet.single.quietHours, 25);
    now = now.add(const Duration(hours: 5));
    expect(look([fav]), isEmpty, reason: 'once');

    // Heard again (its advert time changes), then quiet again.
    final back = repeater(1, 'Ridge', favourite: true, seen: now);
    expect(look([back]), isEmpty);
    now = now.add(const Duration(hours: 24));
    expect(look([back]).single.kind, NetworkChangeKind.wentQuiet);
  });

  test('a wrong repeater clock in the future does not hide silence', () {
    final fav = repeater(
      1,
      'Ridge',
      favourite: true,
      seen: t0.add(const Duration(days: 300)),
    );
    look([fav]);
    now = t0.add(const Duration(hours: 25));
    expect(look([fav]).single.kind, NetworkChangeKind.wentQuiet);
  });

  test('non-favourites never go quiet, and 0 turns it off', () {
    look([repeater(1, 'Ridge')]);
    now = t0.add(const Duration(days: 5));
    expect(look([repeater(1, 'Ridge')]), isEmpty);
    final fav = repeater(2, 'Valley', favourite: true);
    look([fav], quietH: 0);
    now = now.add(const Duration(days: 5));
    expect(look([fav], quietH: 0), isEmpty);
  });

  test('changes survive a save', () {
    final c = NetworkChange(
      kind: NetworkChangeKind.wentQuiet,
      key: 'ab',
      name: 'Ridge',
      at: t0,
      quietHours: 30,
    );
    final back = NetworkChange.fromJson(c.toJson())!;
    expect(back.kind, c.kind);
    expect(back.quietHours, 30);
    expect(NetworkChange.fromJson({'kind': 'nope'}), isNull);
  });

  testWidgets('the screen explains when empty', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<NetworkChangeService?>.value(
        value: null,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const NetworkChangesScreen(),
        ),
      ),
    );
    expect(find.textContaining('No changes yet'), findsOneWidget);
  });

  testWidgets('change texts read naturally', (tester) async {
    late AppLocalizations l10n;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    NetworkChange c(NetworkChangeKind k, {int hops = 0, int q = 0}) =>
        NetworkChange(
          kind: k,
          key: 'k',
          name: 'Peak',
          at: t0,
          hops: hops,
          quietHours: q,
        );
    expect(
      networkChangeText(l10n, c(NetworkChangeKind.newRepeater)),
      'New repeater heard directly: Peak',
    );
    expect(
      networkChangeText(l10n, c(NetworkChangeKind.newRepeater, hops: 1)),
      'New repeater 1 hop away: Peak',
    );
    expect(
      networkChangeText(l10n, c(NetworkChangeKind.wentQuiet, q: 26)),
      'Peak went quiet: not heard for 26 h',
    );
  });
}
