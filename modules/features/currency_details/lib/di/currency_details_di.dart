import 'package:core/core.dart';
import '../domain/currency_details_repository/currency_details_repository.dart';
import '../domain/currency_details_usecase/currency_details_usecase/currency_details_usecase.dart';
import '../data/currency_details_repository/currency_details_repository_impl.dart';
import '../data/remote_data_source/currency_details_remote_data_source.dart';
import '../data/local_data_source/currency_details_local_data_source.dart';
import '../presentation/cubits/currency_details/currency_details_cubit.dart';
// [Adding_new_di_import_here_dont_remove_this_command_!!!]

final di = GetIt.instance;

class CurrencyDetailsDI {
  CurrencyDetailsDI() {
    call();
  }

  void call() {
    di
      ..registerFactory<CurrencyDetailsRemoteDataSource>(
        () => CurrencyDetailsRemoteDataSourceImpl(network: di()),
      )
      ..registerFactory<CurrencyDetailsLocalDataSource>(
        () => CurrencyDetailsLocalDataSourceImpl(localStorage: di()),
      )
      ..registerFactory<CurrencyDetailsRepository>(
        () => CurrencyDetailsRepositoryImpl(
          remoteDataSource: di(),
          localDataSource: di(),
        ),
      )
      ..registerFactory(() => CurrencyDetailsUseCase(repository: di()))
      ..registerFactory(() => CurrencyDetailsCubit(di()))
    // [Adding_new_di_dependency_here_dont_remove_this_command_!!!]
    ;
  }
}
