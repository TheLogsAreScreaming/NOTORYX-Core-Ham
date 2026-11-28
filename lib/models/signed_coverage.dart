/// Signed coverage reports: every hexagon observation carries an Ed25519
/// signature from the phone's coverage key, so anyone holding the report
/// can check that no observation was invented or edited after signing.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

import 'coverage_hex.dart';

const signedCoverageFormat = 'notoryx-coverage-signed/1';

/// Bytes signed for one observation: a domain tag, then the observation as
/// canonical JSON (sorted keys, repeaters sorted by ID), so the same
/// observation always gives the same bytes on every platform.
Uint8List observationSigningInput(Map<String, dynamic> cell) {
  final copy = Map<String, dynamic>.of(cell)..remove('sig');
  final repeaters = copy['repeaters'];
  if (repeaters is List) {
    copy['repeaters'] = [...repeaters]
      ..sort((a, b) => '${(a as Map)['id']}'.compareTo('${(b as Map)['id']}'));
  }
  return Uint8List.fromList(
    utf8.encode('$signedCoverageFormat\n${_canonical(copy)}'),
  );
}

String _canonical(Object? v) {
  if (v is Map) {
    final keys = v.keys.map((k) => '$k').toList()..sort();
    return '{${keys.map((k) => '${jsonEncode(k)}:${_canonical(v[k])}').join(',')}}';
  }
  if (v is List) return '[${v.map(_canonical).join(',')}]';
  if (v is double && v == v.roundToDouble() && v.isFinite) {
    // 3.0 and 3 must sign the same, whatever JSON decoder read them.
    return v.toInt().toString();
  }
  return jsonEncode(v);
}

/// A report of [samples] with each observation signed by [keys]. Times
/// follow [privacy] exactly as uploads do.
Future<Map<String, dynamic>> signCoverageReport(
  List<HexSample> samples,
  CoveragePrivacy privacy,
  SimpleKeyPair keys, {
  required DateTime created,
}) async {
  final algo = Ed25519();
  final pub = await keys.extractPublicKey();
  final cells = <Map<String, dynamic>>[];
  for (final cell in hexagonPayload(samples, privacy)['cells'] as List) {
    final c = Map<String, dynamic>.from(cell as Map);
    final sig = await algo.sign(observationSigningInput(c), keyPair: keys);
    cells.add({...c, 'sig': base64Encode(sig.bytes)});
  }
  return {
    'format': signedCoverageFormat,
    'resolution': coverageResolution,
    'key': base64Encode(pub.bytes),
    'created': created.toUtc().toIso8601String(),
    'cells': cells,
  };
}

/// Why an observation was refused.
enum CoverageRejection {
  /// No signature, or one that doesn't match the observation and key.
  badSignature,

  /// Missing or wrongly typed fields.
  malformed,

  /// Signal values no radio can report.
  impossible,

  /// Timed after the report was made, or after now.
  future,
}

/// The outcome of checking a report: the observations that verified and
/// why the rest were refused.
class CoverageVerdict {
  const CoverageVerdict({
    required this.accepted,
    required this.rejected,
    this.signer,
    this.unreadable = false,
  });

  final List<Map<String, dynamic>> accepted;
  final Map<CoverageRejection, int> rejected;

  /// The signing key (base64), when the report named one.
  final String? signer;

  /// The whole report couldn't be read as a signed coverage report.
  final bool unreadable;

  int get rejectedCount => rejected.values.fold(0, (a, b) => a + b);

  static const notAReport = CoverageVerdict(
    accepted: [],
    rejected: {},
    unreadable: true,
  );
}

/// Short, readable form of a signing key for people to compare.
String keyFingerprint(String base64Key) {
  try {
    final bytes = base64Decode(base64Key);
    final hex = bytes
        .take(8)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
    return [
      for (var i = 0; i < hex.length; i += 4) hex.substring(i, i + 4),
    ].join(' ');
  } catch (_) {
    return '?';
  }
}

/// Checks every observation in [report] against its signature. Accepts
/// the report as a JSON string or decoded map.
Future<CoverageVerdict> verifyCoverageReport(
  Object? report, {
  DateTime? now,
}) async {
  Object? json = report;
  if (json is String) {
    try {
      json = jsonDecode(json);
    } catch (_) {
      return CoverageVerdict.notAReport;
    }
  }
  // Uploads in the hexagon format carry the same signatures.
  const formats = {signedCoverageFormat, 'notoryx-coverage-hex/1'};
  if (json is! Map || !formats.contains(json['format'])) {
    return CoverageVerdict.notAReport;
  }
  final key = json['key'], cells = json['cells'];
  if (key is! String || cells is! List) return CoverageVerdict.notAReport;
  final List<int> keyBytes;
  try {
    keyBytes = base64Decode(key);
  } catch (_) {
    return CoverageVerdict.notAReport;
  }
  if (keyBytes.length != 32) return CoverageVerdict.notAReport;
  final created = DateTime.tryParse('${json['created']}');
  final limit = (now ?? DateTime.now()).toUtc().add(const Duration(minutes: 5));
  final latest = created != null && created.isBefore(limit) ? created : limit;
  final publicKey = SimplePublicKey(keyBytes, type: KeyPairType.ed25519);
  final algo = Ed25519();
  final accepted = <Map<String, dynamic>>[];
  final rejected = <CoverageRejection, int>{};
  void reject(CoverageRejection r) => rejected[r] = (rejected[r] ?? 0) + 1;

  for (final raw in cells) {
    if (raw is! Map) {
      reject(CoverageRejection.malformed);
      continue;
    }
    final cell = Map<String, dynamic>.from(raw);
    final time = DateTime.tryParse('${cell['time']}');
    final snr = cell['best_snr'], rssi = cell['best_rssi'];
    final count = cell['count'];
    if (cell['cell'] is! String ||
        time == null ||
        snr is! num ||
        rssi is! num ||
        count is! num ||
        cell['repeaters'] is! List) {
      reject(CoverageRejection.malformed);
      continue;
    }
    final sig = cell['sig'];
    List<int>? sigBytes;
    if (sig is String) {
      try {
        sigBytes = base64Decode(sig);
      } catch (_) {}
    }
    final ok =
        sigBytes != null &&
        sigBytes.length == 64 &&
        await algo.verify(
          observationSigningInput(cell),
          signature: Signature(sigBytes, publicKey: publicKey),
        );
    if (!ok) {
      reject(CoverageRejection.badSignature);
      continue;
    }
    if (snr < -40 || snr > 30 || rssi < -160 || rssi > 0 || count < 1) {
      reject(CoverageRejection.impossible);
      continue;
    }
    if (time.isAfter(latest)) {
      reject(CoverageRejection.future);
      continue;
    }
    cell.remove('sig');
    accepted.add(cell);
  }
  return CoverageVerdict(accepted: accepted, rejected: rejected, signer: key);
}
