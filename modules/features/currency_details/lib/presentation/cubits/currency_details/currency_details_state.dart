part of 'currency_details_cubit.dart';

class CurrencyDetailsState extends BaseState {
  const CurrencyDetailsState({super.failure, this.featureData,  super.pageState});
  final CurrencyDetailsEntity? featureData;

  @override
  CurrencyDetailsState copyWith({Failure? failure, PageState? pageState, CurrencyDetailsEntity? featureData}) {
    return CurrencyDetailsState(
      failure: failure ?? super.failure,
      pageState: pageState ?? super.pageState,
      featureData: featureData ?? this.featureData,
    );
  }
  @override
  List<Object?> get props => [pageState, failure, featureData];
}