import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'presentation/Ui/screens/currency_details_screen_view.dart';
// [Adding_new_router_import_here_dont_remove_this_command_!!!]

class CurrencyDetailsScreenRouter {
  CurrencyDetailsScreenRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case CurrencyDetailsScreenView.id:
        return CustomPageRouter.createRoute(
          page: CurrencyDetailsScreenView(
            currency: routeSettings.arguments as CurrencyEnums,
          ),
        );
      // [Adding_new_router_case_here_dont_remove_this_command_!!!]
      default:
        return null;
    }
  }
}

class CurrencyDetailsScreens {
  CurrencyDetailsScreens._();
  static const String currencyDetailsScreen = CurrencyDetailsScreenView.id;
  // [Adding_new_router_screen_id_here_dont_remove_this_command_!!!]
}
