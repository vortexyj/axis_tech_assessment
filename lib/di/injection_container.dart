import 'package:core/core.dart';
import 'package:currency_details/currency_details.dart';
import 'package:exchange/exchange.dart';
import 'package:splash/splash.dart';

final di = GetIt.instance;

Future<void> initDependencyInjection() async {
  CoreDI();
  NetworkDI();
  SplashDI();
  ExchangeDI();
  CurrencyDetailsDI();
  await LocalStorageDI(di).call();
}
