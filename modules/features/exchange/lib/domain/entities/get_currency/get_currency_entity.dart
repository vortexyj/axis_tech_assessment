import './egp_entity.dart';
import 'package:core/packages/equatable/equatable.dart';

class GetCurrencyEntity extends Equatable {
  final String? date;
  final EgpEntity? egp;

  final bool isFromCache;
  final DateTime? cachedAt;

  const GetCurrencyEntity({
    this.date,
    this.egp,
    this.isFromCache = false,
    this.cachedAt,
  });

  @override
  List<Object?> get props => [date, egp, isFromCache, cachedAt];
}
