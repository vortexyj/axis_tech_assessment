import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

/// Pumps [child] inside the same `ScreenUtilInit` + themed `MaterialApp`
/// shell the real app wraps every screen in — the `.sp`/`.w`/`.h`/`.r`
/// extensions these widgets use throw if pumped without it.
///
/// Uses a single `pump()`, not `pumpAndSettle()` — some of these widgets
/// (shimmer skeletons) animate forever, which would make `pumpAndSettle()`
/// hang.
Future<void> pumpThemed(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pump();
}
