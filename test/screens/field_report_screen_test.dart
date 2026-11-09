import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/field_report_screen.dart';
import 'package:meshcore_open/services/field_ops_service.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('without a call sign, a filled-in report cannot be sent', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final radio = MeshCoreConnector();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider(create: (_) => FieldOpsService(radio)),
          ChangeNotifierProvider(
            create: (_) => OperatorProfileService()..load(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const FieldReportScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byKey(const ValueKey('report-salute-S')), '3');
    await tester.pump();
    expect(find.textContaining('call sign under Licensed'), findsOneWidget);
    final send = tester.widget<ButtonStyleButton>(
      find
          .descendant(
            of: find.byKey(const ValueKey('report-send')),
            matching: find.byWidgetPredicate((w) => w is ButtonStyleButton),
          )
          .first,
    );
    expect(send.onPressed, isNull);
  });
}
