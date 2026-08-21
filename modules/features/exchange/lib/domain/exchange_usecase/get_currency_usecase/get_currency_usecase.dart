import 'package:core/packages/dartz/dartz.dart';
import 'package:core/core.dart';
import '../../../data/models/get_currency/request/get_currency_request_model.dart';
import '../../entities/get_currency/get_currency_entity.dart';
import '../../exchange_repository/exchange_repository.dart';

class GetCurrencyUseCase
    implements UseCase<GetCurrencyEntity, GetCurrencyRequestModel> {
  final ExchangeRepository repository;
  GetCurrencyUseCase({required this.repository});
  @override
  Future<Either<Failure, GetCurrencyEntity>> call(GetCurrencyRequestModel requestModel) async {
       Either<Failure, GetCurrencyEntity> response = await repository.getCurrency(
      requestModel: requestModel,
    );
    return response;
  }
}