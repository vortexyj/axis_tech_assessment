import 'package:core/core.dart';
import 'package:exchange/data/models/get_currency/request/get_currency_request_model.dart';
import 'package:exchange/domain/entities/get_currency/get_currency_entity.dart';
import 'package:exchange/domain/exchange_usecase/get_currency_usecase/get_currency_usecase.dart';
part 'exchange_state.dart';

class ExchangeCubit extends BaseCubit<ExchangeState> {
  final GetCurrencyUseCase _getCurrencyUseCase;
  ExchangeCubit(this._getCurrencyUseCase) : super(const ExchangeState());

  @override
  Future<void> initState() async {
    await getCurrency();
  }

  Future<void> getCurrency({CurrencyEnums? currencyEnums, String? date}) async {
    emitIfNotClosed(state.copyWith(pageState: PageState.loading));
    final result = await _getCurrencyUseCase.call(
      GetCurrencyRequestModel(date, currencyEnums ?? CurrencyEnums.EGP),
    );
    result.fold(
      (failure) => emitIfNotClosed(
        state.copyWith(pageState: PageState.errorWithDialog, failure: failure),
      ),
      (currencyEntity) => emitIfNotClosed(
        state.copyWith(
          pageState: PageState.success,
          getCurrencyEntity: currencyEntity,
        ),
      ),
    );
  }
}
