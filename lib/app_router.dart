import 'package:exchange/exchange_screen_router.dart';
import 'package:flutter/material.dart';
import 'package:splash/presentation/Ui/screens/splash_screen_view.dart';
import 'package:splash/splash_screen_router.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    return ExchangeScreenRouter.onGenerateRoute(routeSettings) ??
        SplashScreenRouter.onGenerateRoute(routeSettings) ??
        MaterialPageRoute(builder: (_) => SplashScreenView());
  }
}
