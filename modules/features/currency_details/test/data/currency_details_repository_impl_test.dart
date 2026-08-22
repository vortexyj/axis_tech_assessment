import 'package:core/core.dart';
import 'package:currency_details/data/currency_details_repository/currency_details_repository_impl.dart';
import 'package:currency_details/data/local_data_source/currency_details_local_data_source.dart';
import 'package:currency_details/data/models/currency_details/request/currency_details_request_model.dart';
import 'package:currency_details/data/models/currency_details/response/currency_details_response.dart';
import 'package:currency_details/data/remote_data_source/currency_details_remote_data_source.dart';
import 'package:currency_details/domain/entities/currency_details/currency_details_entity.dart';
import 'package:currency_details/domain/entities/currency_details/egp_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyDetailsRemoteDataSource extends Mock
    implements CurrencyDetailsRemoteDataSource {}

class MockCurrencyDetailsLocalDataSource extends Mock
    implements CurrencyDetailsLocalDataSource {}

class FakeCurrencyDetailsRequestModel extends Fake
    implements CurrencyDetailsRequestModel {}

void main() {
  late MockCurrencyDetailsRemoteDataSource remoteDataSource;
  late MockCurrencyDetailsLocalDataSource localDataSource;
  late CurrencyDetailsRepositoryImpl repository;
  late CurrencyDetailsRequestModel requestModel;

  setUpAll(() {
    registerFallbackValue(FakeCurrencyDetailsRequestModel());
    registerFallbackValue(const CurrencyDetailsEntity());
  });

  setUp(() {
    remoteDataSource = MockCurrencyDetailsRemoteDataSource();
    localDataSource = MockCurrencyDetailsLocalDataSource();
    repository = CurrencyDetailsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    requestModel = CurrencyDetailsRequestModel(currencyEnums: CurrencyEnums.EGP);
    when(() => localDataSource.cacheCurrency(any(), any())).thenAnswer((_) async {});
  });

  final entity = const CurrencyDetailsEntity(
    date: '2026-08-21',
    egp: EgpEntity(usd: 0.02, eur: 0.018, gbp: 0.015, sar: 0.075, jpy: 3.1),
  );

  group('CurrencyDetailsRepositoryImpl.currencyDetails', () {
    test('returns Right and caches the entity on a successful fetch', () async {
      when(() => remoteDataSource.currencyDetails(any())).thenAnswer(
        (_) async => CurrencyDetailsResponse(
          result: entity,
          statusCode: AppValues.successCode,
        ),
      );

      final result = await repository.currencyDetails(requestModel: requestModel);

      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected Right'), (e) => expect(e, entity));
      verify(() => localDataSource.cacheCurrency(requestModel, entity)).called(1);
    });

    test(
      'falls back to the cache on a connection failure when a cache entry exists',
      () async {
        when(() => remoteDataSource.currencyDetails(any()))
            .thenThrow(const ConnectionException());
        when(() => localDataSource.getCachedCurrency(any()))
            .thenAnswer((_) async => entity);

        final result = await repository.currencyDetails(requestModel: requestModel);

        expect(result.isRight(), isTrue);
        result.fold((_) => fail('expected Right'), (e) => expect(e, entity));
      },
    );

    test(
      'returns Left(NoConnectionFailure) on a connection failure with no cache',
      () async {
        when(() => remoteDataSource.currencyDetails(any()))
            .thenThrow(const ConnectionException());
        when(() => localDataSource.getCachedCurrency(any()))
            .thenAnswer((_) async => null);

        final result = await repository.currencyDetails(requestModel: requestModel);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<NoConnectionFailure>()),
          (_) => fail('expected Left'),
        );
      },
    );

    test('does not attempt a cache fallback for a non-connection failure', () async {
      when(() => remoteDataSource.currencyDetails(any()))
          .thenThrow(const ParsingException());

      final result = await repository.currencyDetails(requestModel: requestModel);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (_) => fail('expected Left'),
      );
      verifyNever(() => localDataSource.getCachedCurrency(any()));
    });
  });
}
