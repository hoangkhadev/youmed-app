import 'package:flutter/material.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableScreenWrapper(child: Text('Trang Account')),
    );
  }
}
