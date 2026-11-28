import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/utils/grid_coords.dart';
import 'package:meshcore_open/widgets/coordinate_copy_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('toUtm', () {
    test('equator at the prime meridian', () {
      final u = toUtm(0, 0)!;
      expect(u.toString(), '31N 166021 0');
    });

    test('Washington Monument, NGA reference 18S 323487 4306483', () {
      final u = toUtm(38.8895, -77.0352)!;
      expect(u.zone, 18);
      expect(u.band, 'S');
      expect(u.easting, closeTo(323487, 2));
      expect(u.northing, closeTo(4306483, 2));
    });

    test('southern hemisphere adds the false northing', () {
      final u = toUtm(-33.8568, 151.2153)!;
      expect('${u.zone}${u.band}', '56H');
      expect(u.northing, greaterThan(6000000));
    });

    test('Norway and Svalbard zone exceptions', () {
      expect(toUtm(60, 5)!.zone, 32);
      expect(toUtm(78, 15)!.zone, 33);
      expect(toUtm(78, 25)!.zone, 35);
    });

    test('no UTM near the poles', () {
      expect(toUtm(85, 0), isNull);
      expect(toUtm(-81, 0), isNull);
      expect(toUtm(84, 0)!.band, 'X');
    });
  });

  group('toMgrs', () {
    test('reference points', () {
      expect(toMgrs(0, 0), '31N AA 66021 00000');
      final dc = toMgrs(38.8895, -77.0352)!;
      expect(dc, startsWith('18S UJ 2348'));
      expect(dc, contains(' 0648'));
    });

    test('null near the poles', () => expect(toMgrs(-85, 10), isNull));
  });

  group('toDms', () {
    test('hemispheres and padding', () {
      expect(toDms(40.689247, -74.044502), '40°41\'21.3"N 74°02\'40.2"W');
      expect(toDms(-33.5, 151.25), '33°30\'00.0"S 151°15\'00.0"E');
    });
  });

  group('formatCoordinate', () {
    test('each format, and decimal fallback near the poles', () {
      expect(
        formatCoordinate(1.5, 2.25, CoordinateFormat.decimal),
        '1.50000, 2.25000',
      );
      expect(formatCoordinate(0, 0, CoordinateFormat.utm), '31N 166021 0');
      expect(
        formatCoordinate(0, 0, CoordinateFormat.mgrs),
        '31N AA 66021 00000',
      );
      expect(
        formatCoordinate(86, 10, CoordinateFormat.mgrs),
        '86.00000, 10.00000',
      );
    });

    test('parse falls back to decimal', () {
      expect(CoordinateFormat.parse('mgrs'), CoordinateFormat.mgrs);
      expect(CoordinateFormat.parse('nope'), CoordinateFormat.decimal);
      expect(CoordinateFormat.parse(null), CoordinateFormat.decimal);
    });
  });

  group('setting and copy sheet', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    test('round-trips through JSON, default decimal', () async {
      expect(AppSettings().coordinateFormat, 'decimal');
      final s = AppSettings(coordinateFormat: 'utm');
      expect(AppSettings.fromJson(s.toJson()).coordinateFormat, 'utm');
      final service = AppSettingsService();
      await service.setCoordinateFormat(CoordinateFormat.mgrs);
      expect(service.coordinateFormat, CoordinateFormat.mgrs);
    });

    testWidgets('lists every format and copies the chosen one', (tester) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String?;
          }
          return null;
        },
      );
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AppSettingsService(),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () =>
                      showCoordinateCopySheet(context, lat: 0, lon: 0),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('31N AA 66021 00000'), findsOneWidget);
      expect(find.text('31N 166021 0'), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byKey(const ValueKey('coords-mgrs')),
          matching: find.byIcon(Icons.copy),
        ),
      );
      await tester.pumpAndSettle();
      expect(copied, '31N AA 66021 00000');
      expect(find.text('Copied as MGRS'), findsOneWidget);
    });
  });
}
