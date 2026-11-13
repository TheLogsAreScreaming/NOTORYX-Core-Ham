import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/coverage_hex.dart';
import 'package:meshcore_open/models/signed_coverage.dart';
import 'package:meshcore_open/screens/coverage_hex_screen.dart';

final now = DateTime.utc(2026, 11, 13, 12);

HexSample sample(String cell, double snr, {DateTime? bucket}) => HexSample(
  cell: cell,
  bucket: bucket ?? DateTime.utc(2026, 11, 13, 9),
  count: 3,
  bestSnr: snr,
  bestRssi: -95,
  repeaters: {'5a': snr, '3d': snr - 2},
);

Future<SimpleKeyPair> keys(int seed) =>
    Ed25519().newKeyPairFromSeed(List.filled(32, seed));

Future<Map<String, dynamic>> report(
  List<HexSample> samples, {
  int seed = 1,
}) async =>
    jsonDecode(
          jsonEncode(
            await signCoverageReport(
              samples,
              CoveragePrivacy.delayed,
              await keys(seed),
              created: now,
            ),
          ),
        )
        as Map<String, dynamic>;

void main() {
  test('every honest observation verifies', () async {
    final r = await report([sample('a', 7.25), sample('b', 3)]);
    expect(r['format'], signedCoverageFormat);
    final v = await verifyCoverageReport(r, now: now);
    expect(v.accepted.map((c) => c['cell']), ['a', 'b']);
    expect(v.rejectedCount, 0);
    expect(v.accepted.first.containsKey('sig'), isFalse);
    final pub = await (await keys(1)).extractPublicKey();
    expect(v.signer, base64Encode(pub.bytes));
  });

  test('edits, missing signatures and swapped keys are rejected', () async {
    final r = await report([sample('a', 7.25), sample('b', 3), sample('c', 1)]);
    final cells = r['cells'] as List;
    (cells[0] as Map)['best_snr'] = 12.0;
    (cells[1] as Map).remove('sig');
    final v = await verifyCoverageReport(r, now: now);
    expect(v.accepted.single['cell'], 'c');
    expect(v.rejected, {CoverageRejection.badSignature: 2});

    final other = await report([sample('a', 7.25)], seed: 2);
    other['key'] = r['key'];
    final swapped = await verifyCoverageReport(other, now: now);
    expect(swapped.accepted, isEmpty);
  });

  test('signed but impossible or future observations are refused', () async {
    final r = await report([
      sample('loud', 99),
      sample('later', 3, bucket: DateTime.utc(2026, 11, 14)),
      sample('ok', 3),
    ]);
    final v = await verifyCoverageReport(r, now: now);
    expect(v.accepted.single['cell'], 'ok');
    expect(v.rejected, {
      CoverageRejection.impossible: 1,
      CoverageRejection.future: 1,
    });
  });

  test('signatures survive re-encoding and repeater order', () async {
    final r = await report([sample('a', 7)]);
    final cell = (r['cells'] as List).single as Map;
    cell['repeaters'] = (cell['repeaters'] as List).reversed.toList();
    final text = const JsonEncoder.withIndent('  ').convert(r);
    final v = await verifyCoverageReport(text, now: now);
    expect(v.accepted, hasLength(1));
  });

  test('anything else is not a report', () async {
    for (final bad in [
      'not json',
      '{}',
      {'format': signedCoverageFormat, 'key': 'xx', 'cells': []},
      {'format': 'other', 'key': '', 'cells': []},
    ]) {
      expect((await verifyCoverageReport(bad)).unreadable, isTrue);
    }
    final damaged = await report([sample('a', 1)]);
    (damaged['cells'] as List).add('junk');
    final v = await verifyCoverageReport(damaged, now: now);
    expect(v.rejected, {CoverageRejection.malformed: 1});
  });

  test('fingerprint is short and grouped', () {
    expect(
      keyFingerprint(base64Encode(List.generate(32, (i) => i))),
      '0001 0203 0405 0607',
    );
    expect(keyFingerprint('%%%'), '?');
  });

  testWidgets('check dialog reports what verified', (tester) async {
    final text = jsonEncode(await report([sample('a', 1)]));
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: SignedCoverageCheckDialog()),
      ),
    );
    await tester.enterText(find.byType(TextField), text);
    await tester.tap(find.text('Check'));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pumpAndSettle();
    expect(find.text('1 observations verified, 0 rejected'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'nope');
    await tester.tap(find.text('Check'));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
    expect(find.text("This isn't a signed coverage report."), findsOneWidget);
  });
}
