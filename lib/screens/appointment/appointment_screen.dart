import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/login_required.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
        title: Text(
          'Lịch khám',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: ScrollableScreenWrapper(
          child: auth.isLoggedIn ? Text('Trang lịch khám') : LoginRequired(),
        ),
      ),
    );
  }
}
