import '../../../../domain/entities/currency_details/currency_details_entity.dart';
import './egp_response_model.dart';

class CurrencyDetailsResponseModel extends CurrencyDetailsEntity {
  const CurrencyDetailsResponseModel({
    super.date,
    super.egp,
  });

  factory CurrencyDetailsResponseModel.fromJson(dynamic json) {
    return CurrencyDetailsResponseModel(
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
