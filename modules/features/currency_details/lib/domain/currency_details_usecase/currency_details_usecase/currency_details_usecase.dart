import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../../data/models/currency_details/request/currency_details_request_model.dart';
import '../../entities/currency_details/currency_details_entity.dart';
import '../../currency_details_repository/currency_details_repository.dart';

class CurrencyDetailsUseCase
    implements UseCase<CurrencyDetailsEntity, CurrencyDetailsRequestModel> {
  final CurrencyDetailsRepository repository;
  CurrencyDetailsUseCase({required this.repository});
  @override
  Future<Either<Failure, CurrencyDetailsEntity>> call(CurrencyDetailsRequestModel requestModel) async {
       Either<Failure, CurrencyDetailsEntity> response = await repository.currencyDetails(
      requestModel: requestModel,
    );
    return response;
  }
}