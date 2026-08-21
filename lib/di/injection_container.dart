import 'package:core/core.dart';
import 'package:exchange/exchange.dart';
import 'package:splash/splash.dart';

final di = GetIt.instance;

Future<void> initDependencyInjection() async {
  CoreDI();
  NetworkDI();
  SplashDI();
  ExchangeDI();
  await LocalStorageDI(di).call();
}
