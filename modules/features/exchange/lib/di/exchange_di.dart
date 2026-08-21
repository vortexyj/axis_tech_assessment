import 'package:core/core.dart';
import '../domain/exchange_repository/exchange_repository.dart';

import '../data/exchange_repository/exchange_repository_impl.dart';
import '../data/remote_data_source/exchange_remote_data_source.dart';
import '../data/local_data_source/exchange_local_data_source.dart';
import '../presentation/cubits/exchange/exchange_cubit.dart';
import '../domain/exchange_usecase/get_currency_usecase/get_currency_usecase.dart';
// [Adding_new_di_import_here_dont_remove_this_command_!!!]

final di = GetIt.instance;

class ExchangeDI {
  ExchangeDI() {
    call();
  }

  void call() {
    di
      ..registerFactory<ExchangeRemoteDataSource>(
        () => ExchangeRemoteDataSourceImpl(network: di()),
      )
      ..registerFactory<ExchangeLocalDataSource>(
        () => ExchangeLocalDataSourceImpl(localStorage: di()),
      )
      ..registerFactory<ExchangeRepository>(
        () => ExchangeRepositoryImpl(remoteDataSource: di(), localDataSource: di()),
      )
      ..registerFactory(() => ExchangeCubit(di()))
      ..registerFactory(() => GetCurrencyUseCase(repository: di()))
    // [Adding_new_di_dependency_here_dont_remove_this_command_!!!]
    ;
  }
}
