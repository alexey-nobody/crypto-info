import 'package:crypto_info/currency_details/common/date_helper.dart';
import 'package:crypto_info/currency_details/models/trade_history_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trade_history_response.g.dart';

@JsonSerializable(createToJson: false)
class TradeHistoryResponse {
  const TradeHistoryResponse({
    required this.globalTradeID,
    required this.tradeID,
    required this.date,
    required this.type,
    required this.rate,
    required this.amount,
    required this.total,
    required this.orderNumber,
  });

  factory TradeHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$TradeHistoryResponseFromJson(json);

  final int globalTradeID;

  final int tradeID;

  @JsonKey(fromJson: DateHelper.parseServerDate)
  final DateTime date;

  final TradeHistoryType type;

  @JsonKey(fromJson: double.parse)
  final double rate;

  @JsonKey(fromJson: double.parse)
  final double amount;

  @JsonKey(fromJson: double.parse)
  final double total;

  final int orderNumber;
}
