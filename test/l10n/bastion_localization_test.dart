import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/field_ops.dart';

/// Key prefixes of the Bastion screens' strings.
const _bastionPrefixes = [
  'bastion_',
  'bastionHome_',
  'bastionTools_',
  'bastionAbout_',
  'bastionSetup_',
  'bastionDiag_',
  'sos_',
  'checkIn_',
  'tripBrief_',
  'fieldOps_',
  'coverage_',
  'fieldStats_',
  'mapHub_',
  'routes_',
  'repeaterTools_',
];

Map<String, dynamic> _arb(String locale) =>
    jsonDecode(File('lib/l10n/app_$locale.arb').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  test('every locale translates every Bastion string', () {
    final keys = _arb(
      'en',
    ).keys.where((k) => _bastionPrefixes.any(k.startsWith));
    expect(keys, isNotEmpty);
    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == 'en') continue;
      final arb = _arb(locale.languageCode);
      final missing = keys.where((k) => !arb.containsKey(k)).toList();
      expect(missing, isEmpty, reason: '${locale.languageCode} is missing');
    }
  });

  test('the app name and safety wording survive translation', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final t = lookupAppLocalizations(locale);
      expect(t.tripBrief_heading, contains('BASTION'));
      expect(t.fieldOps_title, contains('Bastion'));
      expect(t.sos_active, contains('SOS'));
    }
  });

  test('a translated trip brief keeps the radio check-in words', () {
    final de = lookupAppLocalizations(const Locale('de'));
    final brief = tripBrief(const TripPlan(), const {}, l10n: de);
    expect(brief, contains(checkInLabels.join(' • ')));
    expect(brief, contains(de.tripBrief_overdueMeaning));
    expect(brief, isNot(contains('Review recipients and message')));
  });

  test('radio messages stay in English', () {
    final at = DateTime.utc(2026, 10, 16, 12);
    expect(
      checkInText(checkInLabels[0], at),
      startsWith('[Bastion Check-in] '),
    );
    expect(sosText(at), startsWith('[Bastion SOS] Need help'));
    expect(sosAllClearText(at), startsWith('[Bastion SOS] All clear'));
  });

  test('check-in reasons follow the given language', () {
    final fr = lookupAppLocalizations(const Locale('fr'));
    String? reason({AppLocalizations? l10n}) => checkInUnavailableReason(
      ready: true,
      storageError: false,
      active: true,
      connected: false,
      busy: false,
      selectedContacts: 1,
      availableContacts: 1,
      l10n: l10n,
    );
    expect(reason(), 'Connect your MeshCore radio to check in.');
    expect(reason(l10n: fr), fr.checkIn_blockNotConnected);
    expect(reason(l10n: fr), isNot(reason()));
  });
}
