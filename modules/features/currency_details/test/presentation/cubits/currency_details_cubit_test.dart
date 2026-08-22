import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/packages/dartz/dartz.dart';
import 'package:currency_details/data/models/currency_details/request/currency_details_request_model.dart';
import 'package:currency_details/domain/currency_details_usecase/currency_details_usecase/currency_details_usecase.dart';
import 'package:currency_details/domain/entities/currency_details/currency_details_entity.dart';
import 'package:currency_details/domain/entities/currency_details/egp_entity.dart';
import 'package:currency_details/presentation/cubits/currency_details/currency_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyDetailsUseCase extends Mock implements CurrencyDetailsUseCase {}

class FakeCurrencyDetailsRequestModel extends Fake
    implements CurrencyDetailsRequestModel {}

void main() {
  late MockCurrencyDetailsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(FakeCurrencyDetailsRequestModel());
  });

  setUp(() {
    useCase = MockCurrencyDetailsUseCase();
  });

  CurrencyDetailsEntity entity({
    required num usd,
    bool isFromCache = false,
    DateTime? cachedAt,
  }) {
    return CurrencyDetailsEntity(
      egp: EgpEntity(usd: usd, eur: usd, gbp: usd, sar: usd, jpy: usd),
      isFromCache: isFromCache,
      cachedAt: cachedAt,
    );
  }

  /// Always resolves successfully with the same rate, regardless of date —
  /// only the failure/history/shimmer *shape* is under test here, not the
  /// specific numbers (that's exchange_rate_item_test.dart's job).
  void stubAllDaysSucceed({num usd = 0.02}) {
    when(() => useCase.call(any()))
        .thenAnswer((_) async => Right(entity(usd: usd)));
  }

  group('CurrencyDetailsCubit.getCurrencyDetails', () {
    blocTest<CurrencyDetailsCubit, CurrencyDetailsState>(
      'goes loading -> shimmerLoading (rate ready) -> success (chart ready)',
      build: () {
        stubAllDaysSucceed();
        return CurrencyDetailsCubit(useCase);
      },
      act: (cubit) => cubit.getCurrencyDetails(CurrencyEnums.USD),
      expect: () => [
        isA<CurrencyDetailsState>().having((s) => s.pageState, 'pageState', PageState.loading),
        isA<CurrencyDetailsState>()
            .having((s) => s.pageState, 'pageState', PageState.shimmerLoading)
            .having((s) => s.rate, 'rate', isNotNull)
            .having((s) => s.history, 'history', isNull),
        isA<CurrencyDetailsState>()
            .having((s) => s.pageState, 'pageState', PageState.success)
            .having((s) => s.history, 'history', hasLength(7)),
      ],
    );

    blocTest<CurrencyDetailsCubit, CurrencyDetailsState>(
      'rate is inverted (1 unit = X EGP), not the raw API value',
      build: () {
        stubAllDaysSucceed(usd: 0.02);
        return CurrencyDetailsCubit(useCase);
      },
      act: (cubit) => cubit.getCurrencyDetails(CurrencyEnums.USD),
      verify: (cubit) {
        expect(cubit.state.rate, closeTo(50, 0.001));
      },
    );

    blocTest<CurrencyDetailsCubit, CurrencyDetailsState>(
      'a flat rate across the week produces zero change and 7 equal points',
      build: () {
        stubAllDaysSucceed(usd: 0.02);
        return CurrencyDetailsCubit(useCase);
      },
      act: (cubit) => cubit.getCurrencyDetails(CurrencyEnums.USD),
      verify: (cubit) {
        expect(cubit.state.absoluteChange, 0);
        expect(cubit.state.history!.map((p) => p.rate).toSet(), hasLength(1));
      },
    );

    blocTest<CurrencyDetailsCubit, CurrencyDetailsState>(
      'ends in failure when today/yesterday fails, before ever fetching history',
      build: () {
        when(() => useCase.call(any()))
            .thenAnswer((_) async => Left(NoConnectionFailure()));
        return CurrencyDetailsCubit(useCase);
      },
      act: (cubit) => cubit.getCurrencyDetails(CurrencyEnums.USD),
      verify: (cubit) {
        expect(cubit.state.pageState, PageState.failure);
        expect(cubit.state.rate, isNull);
        // Only today + yesterday should have been requested — the 5 history
        // days are never reached once the rate section itself failed.
        verify(() => useCase.call(any())).called(2);
      },
    );

    blocTest<CurrencyDetailsCubit, CurrencyDetailsState>(
      'ends in failure when one of the historical days fails, even though '
      "today/yesterday succeeded",
      build: () {
        var call = 0;
        when(() => useCase.call(any())).thenAnswer((_) async {
          call++;
          // First two calls (today, yesterday) succeed; the rest fail.
          return call <= 2 ? Right(entity(usd: 0.02)) : Left(NoConnectionFailure());
        });
        return CurrencyDetailsCubit(useCase);
      },
      act: (cubit) => cubit.getCurrencyDetails(CurrencyEnums.USD),
      verify: (cubit) {
        expect(cubit.state.pageState, PageState.failure);
      },
    );

    blocTest<CurrencyDetailsCubit, CurrencyDetailsState>(
      'surfaces isOffline/cachedAt when any day resolves from cache',
      build: () {
        final cachedAt = DateTime(2026, 8, 21, 9, 41);
        var call = 0;
        when(() => useCase.call(any())).thenAnswer((_) async {
          call++;
          return Right(entity(
            usd: 0.02,
            isFromCache: call == 1,
            cachedAt: call == 1 ? cachedAt : null,
          ));
        });
        return CurrencyDetailsCubit(useCase);
      },
      act: (cubit) => cubit.getCurrencyDetails(CurrencyEnums.USD),
      verify: (cubit) {
        expect(cubit.state.isOffline, isTrue);
        expect(cubit.state.cachedAt, DateTime(2026, 8, 21, 9, 41));
      },
    );
  });

  group('CurrencyDetailsState change getters', () {
    test('absoluteChange/percentChange are null before a rate is loaded', () {
      const state = CurrencyDetailsState();
      expect(state.absoluteChange, isNull);
      expect(state.percentChange, isNull);
    });
  });
}
