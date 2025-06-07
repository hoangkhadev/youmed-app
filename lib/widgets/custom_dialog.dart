import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String? title;
  final String? description;
  final String? cancleText;
  final String? confirmText;

  const CustomDialog({
    super.key,
    required this.onConfirm,
    this.onCancel,
    this.title,
    this.description,
    this.cancleText,
    this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              description ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: GlobalColors.textColor),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onCancel?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      cancleText ?? 'Hủy',
                      style: TextStyle(
                        fontSize: 16,
                        color: GlobalColors.textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalColors.mainColor,
                      foregroundColor: GlobalColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      confirmText ?? 'Xác nhận',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
