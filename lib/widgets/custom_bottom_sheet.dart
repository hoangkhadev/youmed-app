import 'package:flutter/material.dart';

class CustomBottomSheet {
  static void show({
    required BuildContext context,
    required Widget child,
    double radius = 16,
    double height = 300,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 8,
    ),
    Color backgroundColor = Colors.white,
    bool isScrollControlled = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) {
        double dragStartY = 0;

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
          ),
          padding: padding,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              child,
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) {
                    dragStartY = details.globalPosition.dy;
                  },
                  onVerticalDragUpdate: (details) {
                    final dragDistance = details.globalPosition.dy - dragStartY;
                    if (dragDistance > 40) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Center(
                    child: Container(
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
