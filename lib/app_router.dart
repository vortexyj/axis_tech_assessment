import 'package:currency_details/currency_details_screen_router.dart';
import 'package:exchange/exchange_screen_router.dart';
import 'package:flutter/material.dart';
import 'package:splash/presentation/Ui/screens/splash_screen_view.dart';
import 'package:splash/splash_screen_router.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    return CurrencyDetailsScreenRouter.onGenerateRoute(routeSettings) ??
        ExchangeScreenRouter.onGenerateRoute(routeSettings) ??
        SplashScreenRouter.onGenerateRoute(routeSettings) ??
        MaterialPageRoute(builder: (_) => SplashScreenView());
  }
}
