import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/helpers/path_hash_filter_command.dart';

void main() {
  test('builds width rules for each width, path and action', () {
    expect(buildPathHashFilterCommand(hashBytes: 1), 'set fr any pb=1 d');
    expect(buildPathHashFilterCommand(hashBytes: 0), 'set fr any pb=* d');
    expect(
      buildPathHashFilterCommand(hashBytes: 2, orMore: true, ratePerMinute: 10),
      'set fr any pb=2+ q=10',
    );
    expect(
      buildPathHashFilterCommand(hashBytes: 3, mode: 'bridge,cross'),
      'set fr any pb=3 m=bc d',
    );
  });

  test('rejects what the firmware would', () {
    expect(() => buildPathHashFilterCommand(hashBytes: 4), throwsArgumentError);
    expect(
      () => buildPathHashFilterCommand(hashBytes: 1, orMore: true),
      throwsArgumentError,
    );
    expect(
      () => buildPathHashFilterCommand(hashBytes: 1, mode: 'satellite'),
      throwsArgumentError,
    );
    expect(
      () => buildPathHashFilterCommand(hashBytes: 1, ratePerMinute: 0),
      throwsArgumentError,
    );
  });
}
