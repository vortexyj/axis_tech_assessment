import 'package:core/core.dart';

class GetCurrencyRequestModel extends RequestModel {
  GetCurrencyRequestModel(
    this.date,
    this.currencyEnums, {
    RequestProgressListener? progressListener,
  }) : super(progressListener);
  final String? date;
  final CurrencyEnums? currencyEnums;
  @override
  Future<Map<String, dynamic>> toMap() async => {};

  @override
  List<Object?> get props => [date, currencyEnums];
}
