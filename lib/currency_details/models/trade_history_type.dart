import 'package:json_annotation/json_annotation.dart';

enum TradeHistoryType {
  @JsonValue('buy')
  buy,
  @JsonValue('sell')
  sell,
}
