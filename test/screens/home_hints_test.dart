import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/screens/bastion_home_screen.dart';

void main() {
  test('a reason shared by Check in and SOS shows once', () {
    expect(
      joinHomeHints('Connect your radio first.', 'Connect your radio first.'),
      'Connect your radio first.',
    );
  });

  test('two different hints are both shown', () {
    expect(
      joinHomeHints('Tap to check in.', 'Hold 2 seconds.'),
      'Tap to check in. Hold 2 seconds.',
    );
  });
}
