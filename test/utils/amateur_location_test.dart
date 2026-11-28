import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/utils/amateur_location.dart';

void main() {
  test('flags the 33 cm exclusion areas', () {
    expect(locationCautions(906.875, 40.0, -105.0), hasLength(1)); // Colorado
    expect(locationCautions(906.875, 33.0, -106.5), hasLength(1)); // New Mexico
    expect(locationCautions(906.875, 47.6, -122.3), isEmpty); // Seattle
    expect(locationCautions(433.5, 40.0, -105.0), isEmpty); // 70 cm is fine
  });

  test('flags 420-430 MHz in the north', () {
    expect(locationCautions(425.0, 47.6, -122.3), hasLength(1));
    expect(locationCautions(433.5, 47.6, -122.3), isEmpty);
    expect(locationCautions(425.0, 34.0, -118.2), isEmpty);
  });

  test('asks for a position when it is unknown', () {
    expect(locationCautions(906.875, null, null), hasLength(1));
    expect(locationCautions(906.875, 0, 0), hasLength(1));
  });
}
