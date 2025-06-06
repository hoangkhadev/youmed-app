import 'package:flutter/material.dart';

import '../../widgets/scrollable_screen_wrapper.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableScreenWrapper(child: Text('Trang message')),
    );
  }
}
