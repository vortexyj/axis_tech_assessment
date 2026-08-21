import 'package:core/core.dart';
import 'package:core/packages/dartz/dartz.dart';
import '../../../data/models/currency_details/request/currency_details_request_model.dart';
import '../../../domain/entities/currency_details/currency_details_entity.dart';
import '../../../domain/currency_details_usecase/currency_details_usecase/currency_details_usecase.dart';
part 'currency_details_state.dart';

class CurrencyDetailsCubit extends BaseCubit<CurrencyDetailsState> {
  final CurrencyDetailsUseCase currencyDetailsUseCase;

  CurrencyDetailsCubit(this.currencyDetailsUseCase)
    : super(const CurrencyDetailsState());
  @override
  Future<void> initState() async {}

  Future<void> getCurrencyDetails() async {
    emit(state.copyWith(pageState: PageState.loading));
    final Either<Failure, CurrencyDetailsEntity> response =
        await currencyDetailsUseCase.call(CurrencyDetailsRequestModel());
    response.fold(
      (failure) => emit(
        state.copyWith(failure: failure, pageState: PageState.errorWithDialog),
      ),
      (data) =>
          emit(state.copyWith(featureData: data, pageState: PageState.success)),
    );
  }
}
