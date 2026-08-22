import 'package:core/core.dart';

import '../network/network_client.dart';

class NetworkDI {
  NetworkDI() {
    call();
  }

  final di = GetIt.instance;

  void call() {
    di.registerLazySingleton<Network>(
        () => NetworkUtilImpl(localStorage: di()));
  }
}
