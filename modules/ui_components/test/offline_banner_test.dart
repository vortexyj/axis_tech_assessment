import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import 'test_harness.dart';

void main() {
  testWidgets('formats the default message with the cached time', (tester) async {
    await pumpThemed(
      tester,
      OfflineBanner(cachedAt: DateTime(2026, 8, 21, 9, 41)),
    );

    expect(find.text('Offline — showing cached rates from 9:41 AM'), findsOneWidget);
  });

  testWidgets('falls back to a generic message when cachedAt is null', (tester) async {
    await pumpThemed(tester, const OfflineBanner());

    expect(find.text('Offline — showing cached rates.'), findsOneWidget);
  });

  testWidgets('an explicit message overrides the default', (tester) async {
    await pumpThemed(
      tester,
      const OfflineBanner(message: 'Custom offline message'),
    );

    expect(find.text('Custom offline message'), findsOneWidget);
  });
}
