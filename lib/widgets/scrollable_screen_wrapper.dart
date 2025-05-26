import 'package:flutter/material.dart';

class ScrollableScreenWrapper extends StatelessWidget {
  final Widget child;

  const ScrollableScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: child);
  }
}
