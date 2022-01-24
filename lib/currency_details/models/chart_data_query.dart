import 'package:crypto_info/currency_details/models/chart_period.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_data_query.g.dart';

@JsonSerializable(createFactory: false)
class ChartDataQuery {
  const ChartDataQuery({required this.currencyPair, required this.period});

  final String currencyPair;

  final ChartPeriod period;

  int get start {
    if (period == ChartPeriod.fiveMinutes) {
      return DateTime.now()
              .toUtc()
              .subtract(const Duration(hours: 24))
              .millisecondsSinceEpoch ~/
          Duration.millisecondsPerSecond;
    }

    if (period == ChartPeriod.fifteenMinutes) {
      return DateTime.now()
              .toUtc()
              .subtract(const Duration(days: 3))
              .millisecondsSinceEpoch ~/
          Duration.millisecondsPerSecond;
    }

    if (period == ChartPeriod.thirtyMinutes) {
      return DateTime.now()
              .toUtc()
              .subtract(const Duration(days: 7))
              .millisecondsSinceEpoch ~/
          Duration.millisecondsPerSecond;
    }

    if (period == ChartPeriod.twoHours || period == ChartPeriod.fourHours) {
      return DateTime.now()
              .toUtc()
              .subtract(const Duration(days: 30))
              .millisecondsSinceEpoch ~/
          Duration.millisecondsPerSecond;
    }

    return DateTime.now()
            .subtract(const Duration(days: 365))
            .millisecondsSinceEpoch ~/
        Duration.millisecondsPerSecond;
  }

  int get end =>
      DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  Map<String, dynamic> toJson() => _$ChartDataQueryToJson(this);
}
