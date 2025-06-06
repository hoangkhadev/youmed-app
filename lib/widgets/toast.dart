import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

enum ToastType { error, success, warning }

class Toast {
  static void show({
    required BuildContext context,
    required String message,
    required ToastType type,
    int? duration = 3,
  }) {
    Color bgColor;
    Icon icon;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green.shade600;
        icon = Icon(Icons.check_circle_outline, color: Colors.white);
        break;
      case ToastType.error:
        bgColor = Colors.red.shade700;
        icon = Icon(Icons.error_outline, color: Colors.white);
        break;
      case ToastType.warning:
        bgColor = Colors.orange.shade700;
        icon = Icon(Icons.warning_amber_outlined, color: Colors.white);
        break;
    }

    Flushbar(
      margin: EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: bgColor,
      icon: icon,
      duration: Duration(seconds: duration!),
      messageText: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP, // Hiển thị ở trên đầu
    ).show(context);
  }
}
