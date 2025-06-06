import 'package:flutter/material.dart';

class ScrollableScreenWrapper extends StatelessWidget {
  final Widget child;
  final Axis? scrollDirection;

  const ScrollableScreenWrapper({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection!,
      child: child,
    );
  }
}
