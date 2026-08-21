import 'package:core/packages/equatable/equatable.dart';

class EgpEntity extends Equatable {
  final num? usd;
  final num? eur;
  final num? gbp;
  final num? sar;
  final num? jpy;

  const EgpEntity({this.usd, this.eur, this.gbp, this.sar, this.jpy});

  Map<String, num?> get asMap => {
    'usd': usd,
    'eur': eur,
    'gbp': gbp,
    'sar': sar,
    'jpy': jpy,
  };

  @override
  List<Object?> get props => [usd, eur, gbp, sar, jpy];
}
