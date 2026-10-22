import 'dart:convert';
import 'dart:typed_data';

/// Signs bytes with the radio's own key and returns the 64-byte Ed25519
/// signature. The private key stays on the radio.
typedef MqttTokenSigner = Future<Uint8List> Function(Uint8List data);

/// MeshCore observer sign-in tokens, as used by meshcoretomqtt
/// (`auth_token.py`) and brokers such as LetsMesh.
///
/// The token is JWT-shaped: base64url (unpadded) JSON header and claims, then
/// the Ed25519 signature over `header.claims` as UPPERCASE HEX, not base64url.
/// The broker username is `v1_` plus the node's public key.
class MeshCoreAuthToken {
  const MeshCoreAuthToken._();

  static const header = {'alg': 'Ed25519', 'typ': 'JWT'};

  /// The broker username for a node's public key.
  static String usernameFor(String publicKeyHex) =>
      'v1_${publicKeyHex.toUpperCase()}';

  /// The claims in meshcoretomqtt's order: `publicKey`, `iat`, `exp`, then
  /// [extra] (such as `aud` and `client`).
  static Map<String, Object> claims({
    required String publicKeyHex,
    required DateTime issuedAt,
    required Duration lifetime,
    Map<String, Object> extra = const {},
  }) {
    final iat = issuedAt.toUtc().millisecondsSinceEpoch ~/ 1000;
    return {
      'publicKey': publicKeyHex.toUpperCase(),
      'iat': iat,
      'exp': iat + lifetime.inSeconds,
      ...extra,
    };
  }

  /// The ASCII bytes the radio signs: `base64url(header).base64url(claims)`.
  static String signingInput(Map<String, Object> claims) =>
      '${_base64Url(jsonEncode(header))}.${_base64Url(jsonEncode(claims))}';

  /// Appends [signature] to [signingInput].
  static String assemble(String signingInput, Uint8List signature) {
    if (signature.length != 64) {
      throw ArgumentError.value(signature.length, 'signature', 'must be 64');
    }
    final hex = signature
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
    return '$signingInput.$hex';
  }

  /// Builds a token whose signature comes from [sign].
  static Future<String> create({
    required String publicKeyHex,
    required DateTime issuedAt,
    required MqttTokenSigner sign,
    Duration lifetime = MqttTokenRefreshPolicy.defaultLifetime,
    String? audience,
    String? client,
  }) async {
    final input = signingInput(
      claims(
        publicKeyHex: publicKeyHex,
        issuedAt: issuedAt,
        lifetime: lifetime,
        extra: {'aud': ?audience, 'client': ?client},
      ),
    );
    return assemble(input, await sign(Uint8List.fromList(ascii.encode(input))));
  }

  static String _base64Url(String json) =>
      base64Url.encode(utf8.encode(json)).replaceAll('=', '');
}

/// When a radio-signed token is renewed. meshcoretomqtt issues one-hour
/// tokens and treats them as stale five minutes before they expire.
class MqttTokenRefreshPolicy {
  const MqttTokenRefreshPolicy({
    this.lifetime = defaultLifetime,
    this.margin = const Duration(minutes: 5),
    this.retryDelay = const Duration(minutes: 1),
  });

  static const defaultLifetime = Duration(hours: 1);

  final Duration lifetime;

  /// How long before expiry the token is replaced.
  final Duration margin;

  /// How soon to try again when renewing fails, for example while the radio
  /// is briefly disconnected.
  final Duration retryDelay;

  DateTime refreshAt(DateTime issuedAt) => issuedAt.add(lifetime - margin);

  /// Whether a token issued at [issuedAt] is still fine to sign in with.
  bool isFresh(DateTime issuedAt, DateTime now) =>
      now.isBefore(refreshAt(issuedAt));

  /// How long from [now] until the token should be replaced; zero if due.
  Duration delayUntilRefresh(DateTime issuedAt, DateTime now) {
    final delay = refreshAt(issuedAt).difference(now);
    return delay.isNegative ? Duration.zero : delay;
  }
}
