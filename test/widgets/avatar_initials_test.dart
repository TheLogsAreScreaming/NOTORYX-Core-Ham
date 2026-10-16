import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/widgets/mesh_ui.dart';

void main() {
  test('initials skip punctuation', () {
    expect(AvatarCircle.initialsFor('Sam (trail crew)'), 'ST');
    expect(AvatarCircle.initialsFor('#trailhead'), 'TR');
    expect(AvatarCircle.initialsFor('Ridge Camp'), 'RC');
    expect(AvatarCircle.initialsFor('  '), '?');
    expect(AvatarCircle.initialsFor('(( ))'), '?');
  });
}
