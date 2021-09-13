import 'package:crypto_info/common/api/json_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_data_response.g.dart';

@JsonSerializable(createToJson: false)
class CurrencyDataResponse {
  const CurrencyDataResponse({
    required this.id,
    required this.last,
    required this.lowestAsk,
    required this.highestBid,
    required this.percentChange,
    required this.baseVolume,
    required this.quoteVolume,
    required this.isFrozen,
    required this.postOnly,
    required this.high24hr,
    required this.low24hr,
  });

  factory CurrencyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDataResponseFromJson(json);

  final int id;

  @JsonKey(fromJson: double.parse)
  final double last;

  @JsonKey(fromJson: double.parse)
  final double lowestAsk;

  @JsonKey(fromJson: double.parse)
  final double highestBid;

  @JsonKey(fromJson: double.parse)
  final double percentChange;

  @JsonKey(fromJson: double.parse)
  final double baseVolume;

  @JsonKey(fromJson: double.parse)
  final double quoteVolume;

  @JsonKey(fromJson: JsonHelper.intToBool)
  final bool isFrozen;

  @JsonKey(fromJson: JsonHelper.intToBool)
  final bool postOnly;

  @JsonKey(fromJson: double.parse)
  final double high24hr;

  @JsonKey(fromJson: double.parse)
  final double low24hr;
}
