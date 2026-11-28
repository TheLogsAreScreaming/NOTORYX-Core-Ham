import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/services/battery_optimization_gateway.dart';
import 'package:meshcore_open/widgets/battery_optimization_tile.dart';

class FakeGateway implements BatteryOptimizationGateway {
  FakeGateway(this.exempt);

  bool? exempt;
  int opened = 0;
  int checks = 0;

  @override
  Future<bool?> isExempt() async {
    checks++;
    return exempt;
  }

  @override
  Future<bool> openSettings() async {
    opened++;
    return true;
  }
}

Future<void> pump(WidgetTester tester, FakeGateway gateway) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: BatteryOptimizationTile(gateway: gateway)),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('shows nothing where the question does not apply', (
    tester,
  ) async {
    await pump(tester, FakeGateway(null));
    expect(
      find.byKey(const ValueKey('battery-optimization-tile')),
      findsNothing,
    );
  });

  testWidgets('warns when optimisation is on and opens the setting', (
    tester,
  ) async {
    final gateway = FakeGateway(false);
    await pump(tester, gateway);
    expect(find.textContaining('Android may stop the app'), findsOneWidget);
    expect(find.byIcon(Icons.battery_alert), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('battery-optimization-fix')));
    expect(gateway.opened, 1);
  });

  testWidgets('confirms when the app is exempt, with no button', (
    tester,
  ) async {
    await pump(tester, FakeGateway(true));
    expect(find.textContaining('alerts keep working'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('battery-optimization-fix')),
      findsNothing,
    );
  });

  testWidgets('checks again when the app comes back to the foreground', (
    tester,
  ) async {
    final gateway = FakeGateway(false);
    await pump(tester, gateway);
    expect(gateway.checks, 1);
    gateway.exempt = true;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(gateway.checks, 2);
    expect(find.textContaining('alerts keep working'), findsOneWidget);
  });
}
