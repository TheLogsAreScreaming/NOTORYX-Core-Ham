import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/widgets/us_bandwidth_notice.dart';

void main() {
  testWidgets(
    'narrow bandwidth notice is informational and explains compatibility',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UsBandwidthNotice(bandwidthHz: 62500)),
        ),
      );
      expect(
        find.textContaining('minimum measured 6 dB bandwidth'),
        findsOneWidget,
      );
      expect(
        find.textContaining('different bandwidths cannot hear each other'),
        findsOneWidget,
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UsBandwidthNotice(bandwidthHz: 500000)),
        ),
      );
      expect(
        find.textContaining('minimum measured 6 dB bandwidth'),
        findsNothing,
      );
      expect(
        find.textContaining('different bandwidths cannot hear each other'),
        findsOneWidget,
      );
    },
  );
}
