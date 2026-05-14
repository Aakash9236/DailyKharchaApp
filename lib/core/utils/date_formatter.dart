import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatMonth(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  static String formatDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}