import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/cayenne_lpp.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/services/follow_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  Contact node = _node(45.5, -122.6);
  @override
  List<Contact> get allContactsUnfiltered => [node];
  void moved(Contact c) {
    node = c;
    notifyListeners();
  }
}

Contact _node(double lat, double lon, {int fill = 0xAB}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, fill)),
  name: 'Hiker',
  type: advTypeChat,
  pathLength: 0,
  path: Uint8List(0),
  latitude: lat,
  longitude: lon,
  lastSeen: DateTime(2026, 11, 22),
);

Uint8List _telemetry(int fill, double lat, double lon) {
  final lpp = CayenneLpp()..addGps(1, lat, lon, 100);
  return Uint8List.fromList([
    pushCodeTelemetryResponse,
    0,
    ...List.filled(6, fill),
    ...lpp.toBytes(),
  ]);
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test('reads a GPS position out of a telemetry reply', () {
    final lpp = CayenneLpp()..addGps(1, 45.51, -122.61, 10);
    final fix = gpsFromLpp(lpp.toBytes())!;
    expect(fix.lat, closeTo(45.51, 1e-4));
    expect(fix.lon, closeTo(-122.61, 1e-4));
    expect(gpsFromLpp(Uint8List(0)), isNull);
  });

  test('follows a contact: advert, replies, trail and stop', () async {
    final radio = _Radio();
    final follow = FollowService(radio);
    follow.start(radio.node);
    expect(follow.active, isTrue);
    expect(follow.isFollowing(radio.node.publicKeyHex), isTrue);
    expect(follow.trail, hasLength(1));
    expect(follow.remaining, greaterThan(const Duration(minutes: 14)));

    follow.handleFrameForTest(_telemetry(0xAB, 45.51, -122.6));
    expect(follow.trail, hasLength(2));
    expect(follow.trail.last.fromRequest, isTrue);
    expect(follow.answered, 1);

    // Another node's reply is ignored.
    follow.handleFrameForTest(_telemetry(0xCD, 46, -120));
    expect(follow.trail, hasLength(2));

    // A tiny move only refreshes the last point.
    follow.handleFrameForTest(_telemetry(0xAB, 45.51001, -122.6));
    expect(follow.trail, hasLength(2));

    // An unchanged advert after a fresher reply adds nothing.
    radio.moved(_node(45.5, -122.6));
    await Future<void>.delayed(const Duration(milliseconds: 120));
    expect(follow.trail, hasLength(2));

    radio.moved(_node(45.52, -122.6));
    await Future<void>.delayed(const Duration(milliseconds: 120));
    expect(follow.trail, hasLength(3));
    expect(follow.trail.last.fromRequest, isFalse);

    follow.stop();
    expect(follow.active, isFalse);
    expect(follow.trail, isEmpty);
    follow.dispose();
  });

  test('stops by itself when the time is up', () async {
    final radio = _Radio();
    final follow = FollowService(
      radio,
      length: const Duration(milliseconds: 50),
    );
    follow.start(radio.node);
    expect(follow.active, isTrue);
    await Future<void>.delayed(const Duration(milliseconds: 120));
    expect(follow.active, isFalse);
    follow.dispose();
  });
}
