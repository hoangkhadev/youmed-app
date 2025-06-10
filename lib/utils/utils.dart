import 'package:intl/intl.dart';

class Utils {
  static String covertDateTimeSendServer(DateTime input) {
    return DateFormat('yyyy/MM/dd').format(input);
  }

  static String formatDate(DateTime input) {
    return DateFormat('dd/MM/yyyy').format(input);
  }
}
