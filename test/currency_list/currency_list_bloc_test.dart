import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_bloc.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_repository.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_state.dart';
import 'package:crypto_info/currency_list/model/currency_data_response.dart';
import 'package:crypto_info/currency_list/model/currency_list_sorting_type.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_list_bloc_test.mocks.dart';

@GenerateMocks([CurrencyListRepository, ErrorHandlerBloc])
void main() {
  group('CurrencyListBloc', () {
    late CurrencyListBloc currencyListBloc;
    late MockErrorHandlerBloc errorHandlerBloc;
    late MockCurrencyListRepository currencyListRepository;

    final serverDioErr = DioError(
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: '/'),
      response: Response<dynamic>(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/'),
      ),
    );

    final currenciesResponse = {
      'BTC_LTC': const CurrencyDataResponse(
        id: 1,
        last: 5,
        lowestAsk: 1,
        highestBid: 10,
        percentChange: 0.1,
        baseVolume: 10,
        quoteVolume: 10,
        isFrozen: false,
        postOnly: false,
        high24hr: 10,
        low24hr: 1,
      ),
      'BTC_DOGE': const CurrencyDataResponse(
        id: 2,
        last: 1,
        lowestAsk: 1,
        highestBid: 10,
        percentChange: -0.01,
        baseVolume: 20,
        quoteVolume: 10,
        isFrozen: false,
        postOnly: false,
        high24hr: 10,
        low24hr: 1,
      ),
      'BTC_ETH': const CurrencyDataResponse(
        id: 3,
        last: 0.432,
        lowestAsk: 1,
        highestBid: 10,
        percentChange: 0.2,
        baseVolume: 0,
        quoteVolume: 10,
        isFrozen: false,
        postOnly: false,
        high24hr: 1,
        low24hr: 0.432,
      ),
    };

    const currenciesUi = [
      CurrencyUi(
        id: 1,
        currencyPair: 'BTC_LTC',
        name: 'LTC/BTC',
        price: '5',
        baseVolume: '10',
        percentChange: '10',
        priceState: CurrencyUiPriceState.rise,
      ),
      CurrencyUi(
        id: 2,
        currencyPair: 'BTC_DOGE',
        name: 'DOGE/BTC',
        price: '1',
        baseVolume: '20',
        percentChange: '-1',
        priceState: CurrencyUiPriceState.drop,
      ),
      CurrencyUi(
        id: 3,
        currencyPair: 'BTC_ETH',
        name: 'ETH/BTC',
        price: '0.432',
        baseVolume: '0',
        percentChange: '20',
        priceState: CurrencyUiPriceState.rise,
      ),
    ];

    const currenciesUiPriseAsc = [
      CurrencyUi(
        id: 3,
        currencyPair: 'BTC_ETH',
        name: 'ETH/BTC',
        price: '0.432',
        baseVolume: '0',
        percentChange: '20',
        priceState: CurrencyUiPriceState.rise,
      ),
      CurrencyUi(
        id: 1,
        currencyPair: 'BTC_LTC',
        name: 'LTC/BTC',
        price: '5',
        baseVolume: '10',
        percentChange: '10',
        priceState: CurrencyUiPriceState.rise,
      ),
      CurrencyUi(
        id: 2,
        currencyPair: 'BTC_DOGE',
        name: 'DOGE/BTC',
        price: '1',
        baseVolume: '20',
        percentChange: '-1',
        priceState: CurrencyUiPriceState.drop,
      ),
    ];

    const currenciesUiVolumeAsc = [
      CurrencyUi(
        id: 2,
        currencyPair: 'BTC_DOGE',
        name: 'DOGE/BTC',
        price: '1',
        baseVolume: '20',
        percentChange: '-1',
        priceState: CurrencyUiPriceState.drop,
      ),
      CurrencyUi(
        id: 1,
        currencyPair: 'BTC_LTC',
        name: 'LTC/BTC',
        price: '5',
        baseVolume: '10',
        percentChange: '10',
        priceState: CurrencyUiPriceState.rise,
      ),
      CurrencyUi(
        id: 3,
        currencyPair: 'BTC_ETH',
        name: 'ETH/BTC',
        price: '0.432',
        baseVolume: '0',
        percentChange: '20',
        priceState: CurrencyUiPriceState.rise,
      ),
    ];

    setUp(() {
      currencyListRepository = MockCurrencyListRepository();
      errorHandlerBloc = MockErrorHandlerBloc();
      currencyListBloc = CurrencyListBloc(
        errorHandlerBloc: errorHandlerBloc,
        currencyListRepository: currencyListRepository,
      );
    });

    test('Initial state is CurrencyListState.loading', () {
      expect(currencyListBloc.state, const CurrencyListState.loading());
    });

    group('CurrencyListLoaded', () {
      blocTest<CurrencyListBloc, CurrencyListState>(
        'Return ConfirmedUserState when confirm user processed',
        build: () {
          when(currencyListRepository.getCurrency()).thenAnswer(
            (_) async => currenciesResponse,
          );
          return currencyListBloc;
        },
        act: (bloc) async => bloc.add(const CurrencyListLoaded()),
        expect: () => [
          const CurrencyListState.loading(),
          const CurrencyListState.loaded(
            currencies: currenciesUi,
            sortingType: CurrencyListSortingType.none,
          ),
        ],
      );

      blocTest<CurrencyListBloc, CurrencyListState>(
        'Handle Server Error and pass it to ErrorHandlerBloc',
        build: () {
          when(currencyListRepository.getCurrency()).thenThrow(serverDioErr);
          return currencyListBloc;
        },
        act: (bloc) async => bloc.add(const CurrencyListLoaded()),
        verify: (_) async => verify(errorHandlerBloc.add(any)).called(1),
        expect: () => [const CurrencyListState.loading()],
      );
    });

    group('CurrencyListLoaded', () {
      blocTest<CurrencyListBloc, CurrencyListState>(
        'Sort by price ASC',
        build: () {
          when(currencyListRepository.getCurrency()).thenAnswer(
            (_) async => currenciesResponse,
          );
          return currencyListBloc;
        },
        act: (bloc) async => bloc
          ..add(const CurrencyListLoaded())
          ..add(const CurrencyListSorted(CurrencyListSortingType.priceAsc)),
        expect: () => [
          const CurrencyListState.loading(),
          const CurrencyListState.loaded(
            currencies: currenciesUi,
            sortingType: CurrencyListSortingType.none,
          ),
          const CurrencyListState.loaded(
            currencies: currenciesUiPriseAsc,
            sortingType: CurrencyListSortingType.priceAsc,
          ),
        ],
      );

      blocTest<CurrencyListBloc, CurrencyListState>(
        'Sort by price DESC',
        build: () {
          when(currencyListRepository.getCurrency()).thenAnswer(
            (_) async => currenciesResponse,
          );
          return currencyListBloc;
        },
        act: (bloc) async => bloc
          ..add(const CurrencyListLoaded())
          ..add(const CurrencyListSorted(CurrencyListSortingType.priceDesc)),
        expect: () => [
          const CurrencyListState.loading(),
          const CurrencyListState.loaded(
            currencies: currenciesUi,
            sortingType: CurrencyListSortingType.none,
          ),
          CurrencyListState.loaded(
            currencies: currenciesUiPriseAsc.reversed.toList(),
            sortingType: CurrencyListSortingType.priceDesc,
          ),
        ],
      );

      blocTest<CurrencyListBloc, CurrencyListState>(
        'Sort by volume ASC',
        build: () {
          when(currencyListRepository.getCurrency()).thenAnswer(
            (_) async => currenciesResponse,
          );
          return currencyListBloc;
        },
        act: (bloc) async => bloc
          ..add(const CurrencyListLoaded())
          ..add(const CurrencyListSorted(CurrencyListSortingType.volumeAsc)),
        expect: () => [
          const CurrencyListState.loading(),
          const CurrencyListState.loaded(
            currencies: currenciesUi,
            sortingType: CurrencyListSortingType.none,
          ),
          const CurrencyListState.loaded(
            currencies: currenciesUiVolumeAsc,
            sortingType: CurrencyListSortingType.volumeAsc,
          ),
        ],
      );

      blocTest<CurrencyListBloc, CurrencyListState>(
        'Sort by volume DESC',
        build: () {
          when(currencyListRepository.getCurrency()).thenAnswer(
            (_) async => currenciesResponse,
          );
          return currencyListBloc;
        },
        act: (bloc) async => bloc
          ..add(const CurrencyListLoaded())
          ..add(const CurrencyListSorted(CurrencyListSortingType.volumeDesc)),
        expect: () => [
          const CurrencyListState.loading(),
          const CurrencyListState.loaded(
            currencies: currenciesUi,
            sortingType: CurrencyListSortingType.none,
          ),
          CurrencyListState.loaded(
            currencies: currenciesUiVolumeAsc.reversed.toList(),
            sortingType: CurrencyListSortingType.volumeDesc,
          ),
        ],
      );
    });
  });
}
