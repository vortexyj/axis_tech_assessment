import 'package:core/core.dart';

final di = GetIt.instance;

Future<void> initDependencyInjection() async {
  CoreDI();
  NetworkDI();
}
