import 'package:core/core.dart';

class CurrencyDetailsRequestModel extends RequestModel {
  CurrencyDetailsRequestModel({
    this.date,
    this.currencyEnums,
    RequestProgressListener? progressListener,
  }) : super(progressListener);
  final String? date;
  final CurrencyEnums? currencyEnums;
  @override
  Future<Map<String, dynamic>> toMap() async => {};

  @override
  List<Object?> get props => [date, currencyEnums];
}
