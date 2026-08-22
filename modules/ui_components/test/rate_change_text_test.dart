import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import 'test_harness.dart';

void main() {
  testWidgets('renders sign, absolute change and percent in the expected format',
      (tester) async {
    await pumpThemed(
      tester,
      const RateChangeText(absoluteChange: 0.226, percentChange: 0.446),
    );

    expect(find.text('+0.226 · +0.45%'), findsOneWidget);
  });

  testWidgets('an increase (rate up) is colored red — EGP weakens', (tester) async {
    await pumpThemed(
      tester,
      const RateChangeText(absoluteChange: 0.226, percentChange: 0.446),
    );

    final text = tester.widget<Text>(find.text('+0.226 · +0.45%'));
    expect(text.style!.color, const Color(0xFFDC2626));
  });

  testWidgets('a decrease (rate down) is colored green — EGP strengthens', (tester) async {
    await pumpThemed(
      tester,
      const RateChangeText(absoluteChange: -0.226, percentChange: -0.446),
    );

    expect(find.text('-0.226 · -0.45%'), findsOneWidget);
    final text = tester.widget<Text>(find.text('-0.226 · -0.45%'));
    expect(text.style!.color, const Color(0xFF16A34A));
  });

  testWidgets('an unchanged rate uses the ~ sign and neutral gray', (tester) async {
    await pumpThemed(
      tester,
      const RateChangeText(absoluteChange: 0, percentChange: 0),
    );

    expect(find.text('~0.000 · ~0.00%'), findsOneWidget);
    final text = tester.widget<Text>(find.text('~0.000 · ~0.00%'));
    expect(text.style!.color, const Color(0xFF9AA0AC));
  });
}
