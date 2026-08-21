import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'presentation/Ui/screens/splash_screen_view.dart';
// [Adding_new_router_import_here_dont_remove_this_command_!!!]

class SplashScreenRouter {
  SplashScreenRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreenView.id:
      return CustomPageRouter.createRoute(page:SplashScreenView());
      // [Adding_new_router_case_here_dont_remove_this_command_!!!]
      default:
        return null; 
    }
  }
}

class SplashScreens {
  SplashScreens._();
  static const String splashScreen = SplashScreenView.id;
  // [Adding_new_router_screen_id_here_dont_remove_this_command_!!!]
}