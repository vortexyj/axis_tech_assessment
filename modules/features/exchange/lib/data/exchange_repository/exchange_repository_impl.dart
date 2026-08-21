import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/exchange_repository/exchange_repository.dart';
import '../remote_data_source/exchange_remote_data_source.dart';
import '../local_data_source/exchange_local_data_source.dart';
import '../../domain/entities/get_currency/get_currency_entity.dart';
import '../models/get_currency/request/get_currency_request_model.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;
  final ExchangeLocalDataSource localDataSource;

  ExchangeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, GetCurrencyEntity>> getCurrency(
      {required GetCurrencyRequestModel requestModel}) async {
    try {
      final response = await remoteDataSource.getCurrency(requestModel);
      final result = DAppRight.handle(response);
      return result.fold(
        (failure) => Left(failure),
        (entity) {
          // Fire-and-forget — caching shouldn't hold up returning fresh data.
          localDataSource.cacheCurrency(requestModel, entity);
          return Right(entity);
        },
      );
    } on Exception catch (error) {
      final failure = FailureHandler(error).getExceptionFailure();
      if (failure is ConnectionFailure) {
        final cached = await localDataSource.getCachedCurrency(requestModel);
        if (cached != null) return Right(cached);
      }
      return Left(failure);
    }
  }
  // [Adding_new_repo_impl_method_here_dont_remove_this_command_!!!]
}
