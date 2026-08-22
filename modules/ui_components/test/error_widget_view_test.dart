import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import 'test_harness.dart';

void main() {
  testWidgets('renders icon, title, subtitle and button title', (tester) async {
    await pumpThemed(
      tester,
      ErrorWidgetView(
        icon: Icons.wifi_off,
        title: "Couldn't load rates",
        subTitle: 'Check your internet connection and try again.',
        buttonTitle: 'Retry',
        onClickFunction: (_) {},
      ),
    );

    expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    expect(find.text("Couldn't load rates"), findsOneWidget);
    expect(find.text('Check your internet connection and try again.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('omits the subtitle row when none is given', (tester) async {
    await pumpThemed(
      tester,
      ErrorWidgetView(
        title: 'No rates available',
        buttonTitle: 'Refresh',
        onClickFunction: (_) {},
      ),
    );

    expect(find.text('No rates available'), findsOneWidget);
  });

  testWidgets('tapping the button fires onClickFunction', (tester) async {
    var tapped = false;

    await pumpThemed(
      tester,
      ErrorWidgetView(
        title: "Couldn't load rates",
        buttonTitle: 'Retry',
        onClickFunction: (_) => tapped = true,
      ),
    );

    await tester.tap(find.text('Retry'));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
