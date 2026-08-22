import './egp_entity.dart';
import 'package:core/packages/equatable/equatable.dart';

class CurrencyDetailsEntity extends Equatable {
  final String? date;
  final EgpEntity? egp;

  /// True when this came from the local cache fallback rather than a live
  /// fetch — set by the repository when a connection failure hits but a
  /// previously cached response exists.
  final bool isFromCache;

  /// When the cached response was originally fetched. Only meaningful when
  /// [isFromCache] is true.
  final DateTime? cachedAt;

  const CurrencyDetailsEntity({
    this.date,
    this.egp,
    this.isFromCache = false,
    this.cachedAt,
  });

  @override
  List<Object?> get props => [date, egp, isFromCache, cachedAt];
}
