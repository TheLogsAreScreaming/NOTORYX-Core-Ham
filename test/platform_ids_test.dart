import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Android, iOS and macOS ship under one app ID, never upstream's.
void main() {
  const id = 'com.bastionmesh.bastion';

  test('every platform uses the NOTORYX Core app ID', () {
    final android = File('android/app/build.gradle.kts').readAsStringSync();
    expect(android, contains('applicationId = "$id"'));

    final macos = File(
      'macos/Runner/Configs/AppInfo.xcconfig',
    ).readAsStringSync();
    expect(macos, contains('PRODUCT_BUNDLE_IDENTIFIER = $id'));

    final ios = File('ios/Runner.xcodeproj/project.pbxproj').readAsStringSync();
    final ids = RegExp(
      r'PRODUCT_BUNDLE_IDENTIFIER = ([^;]+);',
    ).allMatches(ios).map((m) => m[1]!).toSet();
    expect(ids, {id, '$id.RunnerTests'});
  });

  test('no upstream app ID is left in the Apple projects', () {
    for (final path in [
      'ios/Runner.xcodeproj/project.pbxproj',
      'macos/Runner.xcodeproj/project.pbxproj',
    ]) {
      expect(
        File(path).readAsStringSync(),
        isNot(contains('com.monitormx')),
        reason: path,
      );
    }
  });
}
