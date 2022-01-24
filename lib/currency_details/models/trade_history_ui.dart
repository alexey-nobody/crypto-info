import 'package:crypto_info/currency_details/models/trade_history_type.dart';
import 'package:equatable/equatable.dart';

class TradeHistoryUi extends Equatable {
  const TradeHistoryUi({
    required this.date,
    required this.type,
    required this.rate,
    required this.amount,
  });

  final DateTime date;

  final TradeHistoryType type;

  final String rate;

  final String amount;

  @override
  List<Object?> get props => [date, type, rate, amount];
}
