import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_bloc.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_event.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_repository.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_state.dart';
import 'package:crypto_info/currency_details/models/chart_data_query.dart';
import 'package:crypto_info/currency_details/models/chart_data_response.dart';
import 'package:crypto_info/currency_details/models/chart_period.dart';
import 'package:crypto_info/currency_details/models/trade_history_response.dart';
import 'package:crypto_info/currency_details/models/trade_history_type.dart';
import 'package:crypto_info/currency_details/models/trade_history_ui.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_detail_bloc_test.mocks.dart';

@GenerateMocks([CurrencyDetailRepository, ErrorHandlerBloc])
void main() {
  group('CurrencyDetailBloc', () {
    late CurrencyDetailBloc currencyDetailBloc;
    late MockErrorHandlerBloc errorHandlerBloc;
    late MockCurrencyDetailRepository currencyDetailRepository;

    const currencyPair = 'BTC_DOGE';

    final currentDateTime = DateTime.now();

    const chartDataResponse = <ChartDataResponse>[
      ChartDataResponse(
        date: 1546300800,
        high: 1,
        low: 0.5,
        open: 0.5,
        close: 1,
        volume: 1,
        quoteVolume: 1,
        weightedAverage: 1,
      ),
      ChartDataResponse(
        date: 1546301100,
        high: 1.5,
        low: 1,
        open: 1,
        close: 1.5,
        volume: 1,
        quoteVolume: 1,
        weightedAverage: 1,
      ),
    ];

    final tradeHistoryResponse = <TradeHistoryResponse>[
      TradeHistoryResponse(
        globalTradeID: 1,
        tradeID: 1,
        date: currentDateTime,
        type: TradeHistoryType.buy,
        rate: '1',
        amount: 1,
        total: '1',
        orderNumber: 1,
      ),
      TradeHistoryResponse(
        globalTradeID: 1,
        tradeID: 1,
        date: currentDateTime,
        type: TradeHistoryType.sell,
        rate: '1',
        amount: 1,
        total: '1',
        orderNumber: 1,
      ),
    ];

    final tradeHistoryUi = <TradeHistoryUi>[
      TradeHistoryUi(
        date: currentDateTime,
        type: TradeHistoryType.buy,
        rate: '1',
        amount: '1',
      ),
      TradeHistoryUi(
        date: currentDateTime,
        type: TradeHistoryType.sell,
        rate: '1',
        amount: '1',
      ),
    ];

    const spots = <FlSpot>[
      FlSpot(1546300800, 1),
      FlSpot(1546301100, 1.5),
    ];

    final serverDioErr = DioError(
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: '/'),
      response: Response<dynamic>(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/'),
      ),
    );

    setUp(() {
      currencyDetailRepository = MockCurrencyDetailRepository();
      errorHandlerBloc = MockErrorHandlerBloc();
      currencyDetailBloc = CurrencyDetailBloc(
        errorHandlerBloc: errorHandlerBloc,
        currencyDetailRepository: currencyDetailRepository,
        currencyPair: currencyPair,
      );
    });

    test('Initial state is CurrencyDetailState.loading', () {
      expect(currencyDetailBloc.state, const CurrencyDetailState.loading());
    });

    group('CurrencyDetailLoaded', () {
      blocTest<CurrencyDetailBloc, CurrencyDetailState>(
        'Return ConfirmedUserState when confirm user processed',
        build: () {
          when(currencyDetailRepository.getChartData(
            parameters: const ChartDataQuery(
              currencyPair: currencyPair,
              period: ChartPeriod.fiveMinutes,
            ),
          )).thenAnswer((_) async => chartDataResponse);

          when(currencyDetailRepository.getTradeHistory(
            currencyPair: currencyPair,
          )).thenAnswer((_) async => tradeHistoryResponse);

          return currencyDetailBloc;
        },
        act: (bloc) async => bloc.add(const CurrencyDetailLoaded()),
        expect: () => [
          const CurrencyDetailState.loading(),
          CurrencyDetailState.loaded(
            spots: spots,
            tradeHistory: tradeHistoryUi,
          ),
        ],
      );

      blocTest<CurrencyDetailBloc, CurrencyDetailState>(
        'Handle Server Error and pass it to ErrorHandlerBloc',
        build: () {
          when(currencyDetailRepository.getChartData(
            parameters: const ChartDataQuery(
              currencyPair: currencyPair,
              period: ChartPeriod.fiveMinutes,
            ),
          )).thenThrow(serverDioErr);
          return currencyDetailBloc;
        },
        act: (bloc) async => bloc.add(const CurrencyDetailLoaded()),
        verify: (_) async => verify(errorHandlerBloc.add(any)).called(1),
        expect: () => [const CurrencyDetailState.loading()],
      );
    });
  });
}
