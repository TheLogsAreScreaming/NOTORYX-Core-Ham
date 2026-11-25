import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/services/connection_timeline.dart';
import 'package:meshcore_open/services/support_bundle.dart';

void main() {
  test('redactor replaces names, keys and positions', () {
    final r = SupportRedactor(['Base Camp', 'Base Camp 2', 'Ridge Rptr']);
    const key =
        'a1b2c3d4e5f60718293a4b5c6d7e8f90a1b2c3d4e5f60718293a4b5c6d7e8f90';
    final out = r.redact(
      'Login to Ridge Rptr failed; Base Camp 2 and Base Camp heard. '
      'key=$key frame 0a 1b 2c 3d 4e 5f 60 at 40.12345, -75.54321',
    );
    expect(out, isNot(contains('Ridge Rptr')));
    expect(out, isNot(contains('Base Camp')));
    expect(out, isNot(contains(key)));
    expect(out, isNot(contains('0a 1b 2c')));
    expect(out, isNot(contains('40.12345')));
    // Longest name first, and each name keeps one label.
    expect(out, contains('node-1 and node-3 heard'));
    expect(out, contains('[hex]'));
    expect(out, contains('[position]'));
  });

  test('redactor leaves versions, times and short numbers alone', () {
    final r = SupportRedactor(const []);
    const text = 'App: 10.1.0 (122) at 2026-11-23T14:05:09.000 SF 11 -112 dBm';
    expect(r.redact(text), text);
  });

  test('bundle lists the timeline and log, redacted', () {
    final t0 = DateTime(2026, 11, 23, 14);
    var now = t0;
    final timeline = ConnectionTimeline(clock: () => now)
      ..record(
        MeshCoreConnectionState.connected,
        MeshCoreTransportType.bluetooth,
        ConnectionCause.user,
      );
    now = t0.add(const Duration(minutes: 5));
    timeline.record(
      MeshCoreConnectionState.disconnected,
      MeshCoreTransportType.bluetooth,
      ConnectionCause.linkLost,
    );
    final text = buildSupportBundle(
      generatedAt: now,
      appVersion: '10.1.0 (122)',
      platform: 'android 16',
      radio: {'Device': 'Trail Lead'},
      timeline: timeline.events,
      appLog: ['14:01 INFO [Connection] Connected to Trail Lead'],
      redactor: SupportRedactor(['Trail Lead']),
    );
    expect(text, isNot(contains('Trail Lead')));
    expect(text, contains('Device: node-1'));
    expect(text, contains('== Connection timeline (2)'));
    expect(text, contains('linkLost'));
    expect(text, contains('[Connection] Connected to node-1'));
  });

  test('timeline keeps the newest events and counts drops', () {
    var now = DateTime(2026, 11, 23, 14);
    final timeline = ConnectionTimeline(capacity: 3, clock: () => now);
    for (var i = 0; i < 5; i++) {
      now = now.add(const Duration(minutes: 10));
      timeline.record(
        MeshCoreConnectionState.disconnected,
        MeshCoreTransportType.usb,
        i.isEven ? ConnectionCause.linkLost : ConnectionCause.user,
      );
    }
    expect(timeline.events, hasLength(3));
    expect(timeline.events.last.cause, ConnectionCause.linkLost);
    // Kept: +30 lost, +40 user, +50 lost. The last 15 minutes hold one drop.
    expect(timeline.dropsWithin(const Duration(minutes: 15)), 1);
    expect(timeline.dropsWithin(const Duration(minutes: 25)), 2);
  });

  test('call signs in log lines are redacted', () {
    final r = SupportRedactor(const []);
    expect(
      r.redact('Station ID KD2XYZ heard, then W1AW and K1ABC/P'),
      'Station ID [call] heard, then [call] and [call]/P',
    );
    expect(
      r.redact('BLE MTU 247 on TCP port 5000'),
      'BLE MTU 247 on TCP port 5000',
    );
  });
}
