import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/exchange_repository/exchange_repository.dart';
import '../remote_data_source/exchange_remote_data_source.dart';
import '../../domain/entities/get_currency/get_currency_entity.dart';
import '../models/get_currency/request/get_currency_request_model.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

    @override
    Future<Either<Failure, GetCurrencyEntity>> getCurrency( {required GetCurrencyRequestModel requestModel}) async 
    {
        try {
            final response = await remoteDataSource.getCurrency(requestModel);
                 return DAppRight.handle(response);
            } on Exception catch (error) {
                 return Left(FailureHandler(error).getExceptionFailure());
        }
    }
  // [Adding_new_repo_impl_method_here_dont_remove_this_command_!!!]
}
