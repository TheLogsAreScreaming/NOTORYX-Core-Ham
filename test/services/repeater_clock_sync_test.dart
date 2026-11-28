import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/repeater_command_service.dart';

void main() {
  test('clock sync becomes an explicit time command', () {
    expect(
      normalizeRepeaterClockSyncCommand('clock sync', nowSeconds: 1763700000),
      'time 1763700000',
    );
    expect(
      normalizeRepeaterClockSyncCommand('  Clock Sync ', nowSeconds: 42),
      'time 42',
    );
  });

  test('other commands are left alone', () {
    expect(normalizeRepeaterClockSyncCommand('clock'), 'clock');
    expect(normalizeRepeaterClockSyncCommand('ver'), 'ver');
    expect(
      normalizeRepeaterClockSyncCommand('time 123', nowSeconds: 1),
      'time 123',
    );
  });
}
