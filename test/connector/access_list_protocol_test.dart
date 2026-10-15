import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/access_control.dart';

void main() {
  test('get-access-list payload keeps reserved bytes zero', () {
    final payload = buildGetAccessListPayload(Uint8List.fromList([9, 8, 7, 6]));
    expect(payload, [reqTypeGetAccessList, 0, 0, 0, 9, 8, 7, 6]);
  });

  test('parses 7-byte entries and drops a trailing partial one', () {
    final data = Uint8List.fromList([
      1, 2, 3, 4, 5, 6, 0x03, // admin
      7, 8, 9, 10, 11, 12, 0x81, // read-only, with a high flag bit set
      0xAA, 0xBB, // partial
    ]);
    final entries = parseAccessListResponse(data);
    expect(entries, hasLength(2));
    expect(entries[0].keyPrefix, [1, 2, 3, 4, 5, 6]);
    expect(entries[0].role, AclRole.admin);
    expect(entries[1].role, AclRole.readOnly);
  });

  test('entry matches keys that start with its prefix', () {
    final entry = AclEntry(
      keyPrefix: Uint8List.fromList([1, 2, 3, 4, 5, 6]),
      permissions: 2,
    );
    expect(entry.matches(Uint8List.fromList([1, 2, 3, 4, 5, 6, 7])), isTrue);
    expect(entry.matches(Uint8List.fromList([1, 2, 3, 4, 5, 0, 7])), isFalse);
    expect(entry.matches(Uint8List.fromList([1, 2, 3])), isFalse);
  });

  test('setperm command uses hex key and role value', () {
    final key = Uint8List.fromList(List.generate(32, (i) => i));
    expect(
      buildSetPermCommand(key, AclRole.readWrite),
      'setperm ${pubKeyToHex(key)} 2',
    );
    expect(
      buildSetPermCommand(Uint8List.fromList([0xab, 0xcd]), AclRole.guest),
      'setperm abcd 0',
    );
  });
}
