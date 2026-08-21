import '../../../../domain/entities/currency_details/egp_entity.dart';

class EgpResponseModel extends EgpEntity {
  const EgpResponseModel({
    super.usd,
    super.eur,
    super.gbp,
    super.sar,
    super.jpy,
  });

  factory EgpResponseModel.fromJson(dynamic json) {
    return EgpResponseModel(
      usd: json['usd'],
      eur: json['eur'],
      gbp: json['gbp'],
      sar: json['sar'],
      jpy: json['jpy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'usd': usd, 'eur': eur, 'gbp': gbp, 'sar': sar, 'jpy': jpy};
  }
}
