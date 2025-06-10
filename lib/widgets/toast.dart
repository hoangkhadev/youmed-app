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

  static Future<void> show({
    required BuildContext context,
    required String message,
    required ToastType type,
    int? duration = 2,
  }) {
    _currentFlushbar?.dismiss();

    final flushbar = Flushbar(
      margin: EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: bgColorMap[type]!,
      duration: Duration(seconds: duration!),
      messageText: Row(
        children: [
          iconMap[type] as Icon,
          SizedBox(width: 4),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      flushbarPosition: FlushbarPosition.TOP, // Hiển thị ở trên đầu
    );

    _currentFlushbar = flushbar;
    return flushbar.show(context).then((_) {
      _currentFlushbar = null;
    });
  }
}
