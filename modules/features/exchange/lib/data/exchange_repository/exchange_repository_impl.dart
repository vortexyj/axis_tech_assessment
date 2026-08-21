import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/exchange_repository/exchange_repository.dart';
import '../remote_data_source/exchange_remote_data_source.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  // [Adding_new_repo_impl_method_here_dont_remove_this_command_!!!]
}
