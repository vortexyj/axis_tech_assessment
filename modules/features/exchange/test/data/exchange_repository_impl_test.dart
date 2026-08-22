import 'package:core/core.dart';
import 'package:exchange/data/exchange_repository/exchange_repository_impl.dart';
import 'package:exchange/data/local_data_source/exchange_local_data_source.dart';
import 'package:exchange/data/models/get_currency/request/get_currency_request_model.dart';
import 'package:exchange/data/models/get_currency/response/get_currency_response.dart';
import 'package:exchange/data/remote_data_source/exchange_remote_data_source.dart';
import 'package:exchange/domain/entities/get_currency/egp_entity.dart';
import 'package:exchange/domain/entities/get_currency/get_currency_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExchangeRemoteDataSource extends Mock
    implements ExchangeRemoteDataSource {}

class MockExchangeLocalDataSource extends Mock
    implements ExchangeLocalDataSource {}

class FakeGetCurrencyRequestModel extends Fake
    implements GetCurrencyRequestModel {}

void main() {
  late MockExchangeRemoteDataSource remoteDataSource;
  late MockExchangeLocalDataSource localDataSource;
  late ExchangeRepositoryImpl repository;
  late GetCurrencyRequestModel requestModel;

  setUpAll(() {
    registerFallbackValue(FakeGetCurrencyRequestModel());
    registerFallbackValue(const GetCurrencyEntity());
  });

  setUp(() {
    remoteDataSource = MockExchangeRemoteDataSource();
    localDataSource = MockExchangeLocalDataSource();
    repository = ExchangeRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    requestModel = GetCurrencyRequestModel(null, CurrencyEnums.EGP);
    when(() => localDataSource.cacheCurrency(any(), any()))
        .thenAnswer((_) async {});
  });

  final entity = GetCurrencyEntity(
    date: '2026-08-21',
    egp: const EgpEntity(usd: 0.02, eur: 0.018, gbp: 0.015, sar: 0.075, jpy: 3.1),
  );

  group('ExchangeRepositoryImpl.getCurrency', () {
    test('returns Right and caches the entity on a successful fetch', () async {
      when(() => remoteDataSource.getCurrency(any())).thenAnswer(
        (_) async => GetCurrencyResponse(
          result: entity,
          statusCode: AppValues.successCode,
        ),
      );

      final result = await repository.getCurrency(requestModel: requestModel);

      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected Right'), (e) => expect(e, entity));
      verify(() => localDataSource.cacheCurrency(requestModel, entity)).called(1);
    });

    test(
      'falls back to the cache on a connection failure when a cache entry exists',
      () async {
        when(() => remoteDataSource.getCurrency(any()))
            .thenThrow(const ConnectionException());
        final cached = entity;
        when(() => localDataSource.getCachedCurrency(any()))
            .thenAnswer((_) async => cached);

        final result = await repository.getCurrency(requestModel: requestModel);

        expect(result.isRight(), isTrue);
        result.fold((_) => fail('expected Right'), (e) => expect(e, cached));
      },
    );

    test(
      'returns Left(NoConnectionFailure) on a connection failure with no cache',
      () async {
        when(() => remoteDataSource.getCurrency(any()))
            .thenThrow(const ConnectionException());
        when(() => localDataSource.getCachedCurrency(any()))
            .thenAnswer((_) async => null);

        final result = await repository.getCurrency(requestModel: requestModel);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<NoConnectionFailure>()),
          (_) => fail('expected Left'),
        );
      },
    );

    test(
      'does not attempt a cache fallback for a non-connection failure',
      () async {
        when(() => remoteDataSource.getCurrency(any()))
            .thenThrow(const ParsingException());

        final result = await repository.getCurrency(requestModel: requestModel);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<ParsingFailure>()),
          (_) => fail('expected Left'),
        );
        verifyNever(() => localDataSource.getCachedCurrency(any()));
      },
    );
  });
}
