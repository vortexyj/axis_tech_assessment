import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import '../domain/exchange_repository/exchange_repository.dart';

import '../data/exchange_repository/exchange_repository_impl.dart';
import '../data/remote_data_source/exchange_remote_data_source.dart';
import '../presentation/cubits/exchange/exchange_cubit.dart';
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
      ..registerFactory<ExchangeRepository>(
        () => ExchangeRepositoryImpl(remoteDataSource: di()),
      )
      ..registerFactory(() => ExchangeCubit())
    // [Adding_new_di_dependency_here_dont_remove_this_command_!!!]
    ;
  }
}
