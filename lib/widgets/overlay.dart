// import 'package:flutter/material.dart';

// class LoadingOverlay extends StatelessWidget {
//   const LoadingOverlay({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Container(color: Colors.black.withValues(alpha: 0.2)),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;
  LoadingOverlay._internal();

  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  void show(BuildContext context) {
    if (_isVisible) return;
    _overlayEntry = OverlayEntry(
      builder:
          (_) => Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    _isVisible = true;
  }

  void hide() {
    if (!_isVisible) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isVisible = false;
  }
}
