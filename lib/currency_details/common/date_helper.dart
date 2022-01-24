import 'package:intl/intl.dart';

class DateHelper {
  static DateTime parseServerDate(String date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date, true);
  }
}
