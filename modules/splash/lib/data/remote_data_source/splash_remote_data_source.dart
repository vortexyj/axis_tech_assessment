import 'package:core/core.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

abstract class SplashRemoteDataSource {
  // [Adding_new_datasource_method_here_dont_remove_this_command_!!!]
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final Network network;
  SplashRemoteDataSourceImpl({required this.network});

  // [Adding_new_datasource_impl_method_here_dont_remove_this_command_!!!]
}
