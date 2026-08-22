import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/packages/dartz/dartz.dart';
import 'package:exchange/data/models/get_currency/request/get_currency_request_model.dart';
import 'package:exchange/domain/entities/get_currency/egp_entity.dart';
import 'package:exchange/domain/entities/get_currency/get_currency_entity.dart';
import 'package:exchange/domain/exchange_usecase/get_currency_usecase/get_currency_usecase.dart';
import 'package:exchange/presentation/cubits/exchange/exchange_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrencyUseCase extends Mock implements GetCurrencyUseCase {}

class FakeGetCurrencyRequestModel extends Fake
    implements GetCurrencyRequestModel {}

void main() {
  late MockGetCurrencyUseCase useCase;

  setUpAll(() {
    registerFallbackValue(FakeGetCurrencyRequestModel());
  });

  setUp(() {
    useCase = MockGetCurrencyUseCase();
  });

  GetCurrencyEntity entity({
    required num usd,
    bool isFromCache = false,
    DateTime? cachedAt,
  }) {
    return GetCurrencyEntity(
      date: '2026-08-21',
      egp: EgpEntity(usd: usd, eur: usd, gbp: usd, sar: usd, jpy: usd),
      isFromCache: isFromCache,
      cachedAt: cachedAt,
    );
  }

  /// Stubs the use case to answer today's (date == null) and yesterday's
  /// requests differently, based on [GetCurrencyRequestModel.date].
  void stubBothDays({
    required Either<Failure, GetCurrencyEntity> Function() today,
    required Either<Failure, GetCurrencyEntity> Function() yesterday,
  }) {
    when(() => useCase.call(any())).thenAnswer((invocation) async {
      final model =
          invocation.positionalArguments[0] as GetCurrencyRequestModel;
      return model.date == null ? today() : yesterday();
    });
  }

  group('ExchangeCubit.initState', () {
    blocTest<ExchangeCubit, ExchangeState>(
      'builds 5 rates and reaches success when both fetches succeed',
      build: () {
        stubBothDays(
          today: () => Right(entity(usd: 0.02)),
          yesterday: () => Right(entity(usd: 0.021)),
        );
        return ExchangeCubit(useCase);
      },
      act: (cubit) => cubit.initState(),
      verify: (cubit) {
        expect(cubit.state.pageState, PageState.success);
        expect(cubit.state.rates, hasLength(5));
        expect(cubit.state.isOffline, isFalse);
      },
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'rates are inverted (1 unit = X EGP), not the raw API value',
      build: () {
        // API returns "1 EGP = 0.02 USD"; the UI shows "1 USD = 50 EGP".
        stubBothDays(
          today: () => Right(entity(usd: 0.02)),
          yesterday: () => Right(entity(usd: 0.02)),
        );
        return ExchangeCubit(useCase);
      },
      act: (cubit) => cubit.initState(),
      verify: (cubit) {
        final usdRow = cubit.state.rates!.firstWhere(
          (r) => r.currency == CurrencyEnums.USD,
        );
        expect(usdRow.rate, closeTo(50, 0.001));
      },
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'ends in failure when the fetch fails and no cache is available',
      build: () {
        stubBothDays(
          today: () => Left(NoConnectionFailure()),
          yesterday: () => Left(NoConnectionFailure()),
        );
        return ExchangeCubit(useCase);
      },
      act: (cubit) => cubit.initState(),
      verify: (cubit) {
        expect(cubit.state.pageState, PageState.failure);
        expect(cubit.state.failure, isA<NoConnectionFailure>());
      },
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'surfaces isOffline/cachedAt when a fetch resolves from cache',
      build: () {
        final cachedAt = DateTime(2026, 8, 21, 9, 41);
        stubBothDays(
          today: () => Right(entity(usd: 0.02, isFromCache: true, cachedAt: cachedAt)),
          yesterday: () => Right(entity(usd: 0.021)),
        );
        return ExchangeCubit(useCase);
      },
      act: (cubit) => cubit.initState(),
      verify: (cubit) {
        expect(cubit.state.pageState, PageState.success);
        expect(cubit.state.isOffline, isTrue);
        expect(cubit.state.cachedAt, DateTime(2026, 8, 21, 9, 41));
      },
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'emits a loading state before resolving',
      build: () {
        stubBothDays(
          today: () => Right(entity(usd: 0.02)),
          yesterday: () => Right(entity(usd: 0.021)),
        );
        return ExchangeCubit(useCase);
      },
      act: (cubit) => cubit.initState(),
      expect: () => contains(
        isA<ExchangeState>().having(
          (s) => s.pageState,
          'pageState',
          PageState.loading,
        ),
      ),
    );
  });
}
