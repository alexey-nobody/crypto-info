import 'package:crypto_info/common/api/json_helper.dart';
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

  @JsonKey(fromJson: JsonHelper.parseServerDate)
  final DateTime date;

  final TradeHistoryType type;

  final String rate;

  @JsonKey(fromJson: double.parse)
  final double amount;

  final String total;

  final int orderNumber;
}
