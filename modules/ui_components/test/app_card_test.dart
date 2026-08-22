import 'package:core/packages/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import 'test_harness.dart';

void main() {
  testWidgets('renders title and subtitle when loaded', (tester) async {
    await pumpThemed(
      tester,
      const AppCard(
        title: 'US Dollar',
        subTitle: 'USD',
      ),
    );

    expect(find.text('US Dollar'), findsOneWidget);
    expect(find.text('USD'), findsOneWidget);
  });

  testWidgets('hides the subtitle when hasSubtitle is false', (tester) async {
    await pumpThemed(
      tester,
      const AppCard(
        title: 'US Dollar',
        subTitle: 'USD',
        hasSubtitle: false,
      ),
    );

    expect(find.text('US Dollar'), findsOneWidget);
    expect(find.text('USD'), findsNothing);
  });

  testWidgets('shows a shimmer skeleton instead of content when isLoading', (tester) async {
    await pumpThemed(
      tester,
      const AppCard(
        title: 'US Dollar',
        subTitle: 'USD',
        isLoading: true,
      ),
    );

    expect(find.byType(Shimmer), findsOneWidget);
    expect(find.text('US Dollar'), findsNothing);
    expect(find.text('USD'), findsNothing);
  });

  testWidgets('renders the start and end widgets when provided', (tester) async {
    await pumpThemed(
      tester,
      const AppCard(
        title: 'US Dollar',
        hasStartWidget: true,
        startWidget: Icon(Icons.attach_money, key: Key('start')),
        hasEndWidget: true,
        endWidget: Text('50.878 EGP', key: Key('end')),
      ),
    );

    expect(find.byKey(const Key('start')), findsOneWidget);
    expect(find.byKey(const Key('end')), findsOneWidget);
  });
}
