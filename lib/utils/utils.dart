import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/models/appointment_model.dart';

class Utils {
  static String covertDateTimeSendServer(DateTime input) {
    return DateFormat('yyyy-MM-dd').format(input);
  }

  static String formatDate(DateTime input) {
    return DateFormat('dd/MM/yyyy').format(input);
  }

  static String formatDateFromString(String datetimeStr) {
    DateTime parsedDate = DateTime.parse(datetimeStr);

    String formatted = DateFormat('EEE, dd/MM/yyyy', 'vi').format(parsedDate);
    return formatted;
  }

  static String getStatusName(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.pending:
        return 'Chờ duyệt';
      case AppointmentStatus.confirmed:
        return 'Đã duyệt';
      case AppointmentStatus.cancelled:
        return 'Đã hủy';
      case AppointmentStatus.done:
        return 'Đã khám';
      default:
        return 'Chờ duyệt';
    }
  }

  static Color getStatusColor(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Color(0xFFF59E0B);
      case AppointmentStatus.confirmed:
        return Color(0xFF3B82F6);
      case AppointmentStatus.cancelled:
        return Color(0xFFEF4444);
      case AppointmentStatus.done:
        return Color(0xFF047857);
      default:
        return Colors.grey;
    }
  }
}
