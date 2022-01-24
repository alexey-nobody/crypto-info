import 'package:crypto_info/currency_details/models/trade_history_ui.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

class CurrencyDetailState extends Equatable {
  const CurrencyDetailState._({
    required this.status,
    this.spots = const [],
    this.tradeHistory = const [],
  });

  const CurrencyDetailState.loading()
      : this._(status: CurrencyDetailStateStatus.loading);

  const CurrencyDetailState.loaded({
    required List<FlSpot> spots,
    required List<TradeHistoryUi> tradeHistory,
  }) : this._(
          status: CurrencyDetailStateStatus.loaded,
          spots: spots,
          tradeHistory: tradeHistory,
        );

  final CurrencyDetailStateStatus status;

  final List<FlSpot> spots;

  final List<TradeHistoryUi> tradeHistory;

  @override
  List<Object?> get props => [status, spots, tradeHistory];
}

enum CurrencyDetailStateStatus { initial, loading, loaded }
