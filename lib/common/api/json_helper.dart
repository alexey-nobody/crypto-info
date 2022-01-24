import 'package:intl/intl.dart';

class JsonHelper {
  static bool intToBool(dynamic data) {
    return data == 1;
  }

  static DateTime parseServerDate(String date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date, true);
  }
}
