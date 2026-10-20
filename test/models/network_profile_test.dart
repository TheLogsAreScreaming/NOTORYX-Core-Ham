import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/network_profile.dart';

void main() {
  test('previews changed radio settings without mutating current values', () {
    final current = {'frequency': '906.875', 'bandwidth': '250'};
    final profile = NetworkProfile(
      id: 'local',
      name: 'Local',
      settings: {'frequency': '910.525', 'bandwidth': '250'},
    );
    final changes = profile.previewAgainst(current);
    expect(changes.length, 1);
    expect(changes.single.setting, 'frequency');
    expect(changes.single.previous, '906.875');
    expect(current['frequency'], '906.875');
  });

  test('never previews secrets or identity keys', () {
    final profile = NetworkProfile(
      id: 'travel',
      name: 'Travel',
      settings: {
        'frequency': '910.525',
        'private_key': 'secret',
        'channel_secret': 'secret',
      },
    );
    final changes = profile.previewAgainst({});
    expect(changes.map((change) => change.setting), ['frequency']);
  });

  test('saved settings cannot be mutated externally', () {
    final input = {'frequency': '910.525'};
    final profile = NetworkProfile(id: 'a', name: 'A', settings: input);
    input['frequency'] = '900';
    expect(profile.settings['frequency'], '910.525');
  });
}
