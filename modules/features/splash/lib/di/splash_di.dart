import 'package:core/core.dart';
import '../domain/splash_repository/splash_repository.dart';
import '../data/splash_repository/splash_repository_impl.dart';
import '../data/remote_data_source/splash_remote_data_source.dart';
import '../presentation/cubits/splash/splash_cubit.dart';
// [Adding_new_di_import_here_dont_remove_this_command_!!!]

final di = GetIt.instance;

class SplashDI {
  SplashDI() {
    call();
  }

  void call() {
    di
      ..registerFactory<SplashRemoteDataSource>(
        () => SplashRemoteDataSourceImpl(network: di()),
      )
      ..registerFactory<SplashRepository>(
        () => SplashRepositoryImpl(remoteDataSource: di()),
      )
      ..registerFactory(() => SplashCubit())
    // [Adding_new_di_dependency_here_dont_remove_this_command_!!!]
    ;
  }
}
