import 'package:json_annotation/json_annotation.dart';

part 'chart_data_response.g.dart';

@JsonSerializable(createToJson: false)
class ChartDataResponse {
  const ChartDataResponse({
    required this.date,
    required this.high,
    required this.low,
    required this.open,
    required this.close,
    required this.volume,
    required this.quoteVolume,
    required this.weightedAverage,
  });

  factory ChartDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartDataResponseFromJson(json);

  final int date;

  final double high;

  final double low;

  final double open;

  final double close;

  final double volume;

  final double quoteVolume;

  final double weightedAverage;
}
