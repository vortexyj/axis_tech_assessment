import '../../../../domain/entities/get_currency/get_currency_entity.dart';
import './egp_response_model.dart';

class GetCurrencyResponseModel extends GetCurrencyEntity {
  const GetCurrencyResponseModel({
    super.date,
    super.egp,
  });

  factory GetCurrencyResponseModel.fromJson(dynamic json) {
    return GetCurrencyResponseModel(
      date: json['date'],
      egp: json['egp'] != null
          ? EgpResponseModel.fromJson(json['egp'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'egp': (egp as EgpResponseModel?)?.toJson(),
    };
  }
}
