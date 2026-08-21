import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/splash_repository/splash_repository.dart';
import '../remote_data_source/splash_remote_data_source.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource remoteDataSource;

  SplashRepositoryImpl({required this.remoteDataSource});

  // [Adding_new_repo_impl_method_here_dont_remove_this_command_!!!]
}
