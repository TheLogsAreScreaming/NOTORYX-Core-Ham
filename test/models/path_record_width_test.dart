import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/path_history.dart';

PathRecord _record(int hops, List<int> bytes) => PathRecord(
  hopCount: hops,
  tripTimeMs: 0,
  timestamp: null,
  wasFloodDiscovery: false,
  pathBytes: bytes,
  successCount: 0,
  failureCount: 0,
);

void main() {
  test('works out bytes per hop from the stored path', () {
    expect(_record(3, [0x3D, 0x4B, 0x8F]).hashByteWidth, 1);
    expect(_record(2, [0x3D, 0x4A, 0x4B, 0xE0]).hashByteWidth, 2);
    expect(_record(2, [1, 2, 3, 4, 5, 6]).hashByteWidth, 3);
  });

  test('falls back to one byte when the path does not divide evenly', () {
    expect(_record(0, const []).hashByteWidth, 1);
    expect(_record(0, [1, 2]).hashByteWidth, 1);
    expect(_record(2, [1, 2, 3]).hashByteWidth, 1);
    expect(_record(1, [1, 2, 3, 4]).hashByteWidth, 1);
  });
}
