import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/currency_details_repository/currency_details_repository.dart';
import '../remote_data_source/currency_details_remote_data_source.dart';
import '../local_data_source/currency_details_local_data_source.dart';
import '../models/currency_details/request/currency_details_request_model.dart';
import '../../domain/entities/currency_details/currency_details_entity.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

class CurrencyDetailsRepositoryImpl implements CurrencyDetailsRepository {
  final CurrencyDetailsRemoteDataSource remoteDataSource;
  final CurrencyDetailsLocalDataSource localDataSource;

  CurrencyDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CurrencyDetailsEntity>> currencyDetails({
    required CurrencyDetailsRequestModel requestModel,
  }) async {
    try {
      final response = await remoteDataSource.currencyDetails(requestModel);
      final result = DAppRight.handle(response);
      return result.fold((failure) => Left(failure), (entity) {
        // Fire-and-forget — caching shouldn't hold up returning fresh data.
        localDataSource.cacheCurrency(requestModel, entity);
        return Right(entity);
      });
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
