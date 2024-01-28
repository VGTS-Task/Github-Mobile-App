import 'package:intl/intl.dart';

String getFormatString(String date, String format) {
  return DateFormat(format).format(DateTime.parse(date));
}
