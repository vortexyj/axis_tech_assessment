import './egp_entity.dart';
import 'package:equatable/equatable.dart';

class CurrencyDetailsEntity extends Equatable {
  final String? date;
  final EgpEntity? egp;

  const CurrencyDetailsEntity({
    this.date,
    this.egp,
  });

  @override
  List<Object?> get props => [
        date,
        egp,
      ];
}
