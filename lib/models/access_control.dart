import 'dart:typed_data';

/// Access roles a repeater or room server keeps per client, matching the
/// firmware's PERM_ACL_* values (the lower two bits of the permission byte).
enum AclRole {
  /// Not on the list. Setting this role removes the entry.
  guest(0),
  readOnly(1),
  readWrite(2),
  admin(3);

  const AclRole(this.value);

  /// The firmware value, as used in `setperm`.
  final int value;

  static const int _roleMask = 0x03;

  /// The role encoded in a permission byte; other bits are ignored.
  static AclRole fromPermissions(int permissions) {
    final bits = permissions & _roleMask;
    return AclRole.values.firstWhere((r) => r.value == bits);
  }
}

/// One entry of a node's access list as reported over the mesh: the client's
/// 6-byte public key prefix and its permission byte.
class AclEntry {
  /// Bytes of the public key the node reports per entry.
  static const int keyPrefixLength = 6;

  final Uint8List keyPrefix;
  final int permissions;

  const AclEntry({required this.keyPrefix, required this.permissions});

  AclRole get role => AclRole.fromPermissions(permissions);

  /// Whether [publicKey] starts with this entry's prefix.
  bool matches(Uint8List publicKey) {
    if (publicKey.length < keyPrefix.length) return false;
    for (var i = 0; i < keyPrefix.length; i++) {
      if (publicKey[i] != keyPrefix[i]) return false;
    }
    return true;
  }
}
