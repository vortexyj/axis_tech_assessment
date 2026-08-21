enum Flavor { production }

class AppFlavor {
  static final AppFlavor instance = AppFlavor._internal();
  AppFlavor._internal();
  Flavor _flavor = Flavor.production;

  Flavor get flavor => _flavor;
  set flavor(Flavor value) => _flavor = value;

  String get name => _flavor.name;

  String get title {
    return 'Axis Technical Assessment';
  }

  String get packageName {
    return 'com.example.technical_axis';
  }

  String get baseUrl {
    return 'https://latest.currency-api.pages.dev/v1/currencies/';
  }
}
