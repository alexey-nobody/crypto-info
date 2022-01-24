import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_event.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_repository.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_state.dart';
import 'package:crypto_info/currency_details/common/double_extensions.dart';
import 'package:crypto_info/currency_details/models/chart_data_query.dart';
import 'package:crypto_info/currency_details/models/chart_period.dart';
import 'package:crypto_info/currency_details/models/trade_history_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyDetailBloc
    extends Bloc<CurrencyDetailEvent, CurrencyDetailState> {
  CurrencyDetailBloc({
    required ErrorHandlerBloc errorHandlerBloc,
    required CurrencyDetailRepository currencyDetailRepository,
    required String currencyPair,
  })  : _errorHandlerBloc = errorHandlerBloc,
        _currencyDetailRepository = currencyDetailRepository,
        _currencyPair = currencyPair,
        super(const CurrencyDetailState.loading()) {
    on<CurrencyDetailLoaded>(_mapCurrencyDetailLoaded);
  }

  final ErrorHandlerBloc _errorHandlerBloc;
  final CurrencyDetailRepository _currencyDetailRepository;

  final String _currencyPair;

  Future<void> _mapCurrencyDetailLoaded(
    CurrencyDetailLoaded event,
    Emitter emit,
  ) async {
    try {
      emit(const CurrencyDetailState.loading());

      final chartDataResponse = await _currencyDetailRepository.getChartData(
        parameters: ChartDataQuery(
          currencyPair: _currencyPair,
          period: ChartPeriod.fiveMinutes,
        ),
      );

      final tradeHistoryResponse =
          await _currencyDetailRepository.getTradeHistory(
        currencyPair: _currencyPair,
      );

      final spots = chartDataResponse
          .map((spotData) => FlSpot(spotData.date.toDouble(), spotData.close))
          .toList();

      final tradeHistoryUi = tradeHistoryResponse
          .map((tradeHistory) => TradeHistoryUi(
                date: tradeHistory.date,
                type: tradeHistory.type,
                rate: tradeHistory.rate,
                amount: tradeHistory.amount
                    .toStringWithoutTrailingZeros()
                    .toString(),
              ))
          .toList();

      emit(CurrencyDetailState.loaded(
        spots: spots,
        tradeHistory: tradeHistoryUi,
      ));
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
    }
  }
}
