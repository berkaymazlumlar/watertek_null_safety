import 'package:intl/intl.dart';

class DateHelper {
  static String getStringDateHourTR(DateTime date) {
    var formatter = DateFormat.yMMMMd("tr_TR").add_Hm();
    return formatter.format(date);
  }

  static String getStringDateTR(DateTime date) {
    var formatter = DateFormat.yMMMMd("tr_TR");
    return formatter.format(date);
  }

  static String getStringShortDateTR(DateTime date) {
    var formatter = DateFormat.MMMd("tr_TR").add_Hms();
    return formatter.format(date);
  }

  static String getStringMonth(DateTime date) {
    var formatter = DateFormat.MMM("tr_TR");
    return formatter.format(date).toUpperCase();
  }
}
