import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

final iconMap = {
  ToastType.success: const Icon(
    Icons.check_circle_outline,
    color: Colors.white,
  ),
  ToastType.error: const Icon(Icons.error_outline, color: Colors.white),
  ToastType.warning: const Icon(
    Icons.warning_amber_outlined,
    color: Colors.white,
  ),
};

final bgColorMap = {
  ToastType.success: Colors.green,
  ToastType.error: Colors.red,
  ToastType.warning: Colors.orange,
};

enum ToastType { error, success, warning }

class Toast {
  static Flushbar? _currentFlushbar;

  static void show({
    required BuildContext context,
    required String message,
    required ToastType type,
    int? duration = 3,
  }) {
    _currentFlushbar?.dismiss();

    Flushbar(
      margin: EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: bgColorMap[type]!,
      icon: iconMap[type],
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
    ).show(context).then((_) {
      _currentFlushbar = null;
    });
  }
}
