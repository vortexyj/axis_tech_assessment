import './egp_entity.dart';
import 'package:core/packages/equatable/equatable.dart';

class GetCurrencyEntity extends Equatable {
  final String? date;
  final EgpEntity? egp;

  const GetCurrencyEntity({
    this.date,
    this.egp,
  });

  @override
  List<Object?> get props => [
        date,
        egp,
      ];
}
