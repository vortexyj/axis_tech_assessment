import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'presentation/Ui/screens/exchange_screen_view.dart';
// [Adding_new_router_import_here_dont_remove_this_command_!!!]

class ExchangeScreenRouter {
  ExchangeScreenRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case ExchangeScreenView.id:
        return CustomPageRouter.createRoute(page: ExchangeScreenView());
      // [Adding_new_router_case_here_dont_remove_this_command_!!!]
      default:
        return null;
    }
  }
}

class ExchangeScreens {
  ExchangeScreens._();
  static const String exchangeScreen = ExchangeScreenView.id;
  // [Adding_new_router_screen_id_here_dont_remove_this_command_!!!]
}
