import 'package:json_annotation/json_annotation.dart';

enum ChartPeriod {
  @JsonValue('300')
  fiveMinutes,
  @JsonValue('900')
  fifteenMinutes,
  @JsonValue('1800')
  thirtyMinutes,
  @JsonValue('7200')
  twoHours,
  @JsonValue('14400')
  fourHours,
  @JsonValue('86400')
  oneDay,
}
