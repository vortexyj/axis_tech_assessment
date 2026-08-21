import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/currency_details_repository/currency_details_repository.dart';
import '../remote_data_source/currency_details_remote_data_source.dart';
import '../models/currency_details/request/currency_details_request_model.dart';
import '../../domain/entities/currency_details/currency_details_entity.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

class CurrencyDetailsRepositoryImpl implements CurrencyDetailsRepository {
  final CurrencyDetailsRemoteDataSource remoteDataSource;

  CurrencyDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CurrencyDetailsEntity>> currencyDetails(
      {required CurrencyDetailsRequestModel requestModel}) async {
    try {
      final response = await remoteDataSource.currencyDetails(requestModel);
         return DAppRight.handle(response);
    } on Exception catch (error) {
         return Left(FailureHandler(error).getExceptionFailure());
    }
  }
  // [Adding_new_repo_impl_method_here_dont_remove_this_command_!!!]
}