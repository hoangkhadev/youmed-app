import 'package:flutter/material.dart';

import 'package:my_flutter_app/screens/account/account_detail_user.dart';
import 'package:my_flutter_app/screens/account/account_info.dart';
import 'package:my_flutter_app/screens/auth/login_screen.dart';
import 'package:my_flutter_app/screens/auth/register_info_form_screen.dart';
import 'package:my_flutter_app/screens/auth/register_screen.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/screens/splash/splash.screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.id: (_) => const SplashScreen(),
    LoginScreen.id: (_) => const LoginScreen(),
    MainScreen.id: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as int?;
      return MainScreen(currentIndex: args ?? 0);
    },
    AccountInfo.id: (_) => const AccountInfo(),
    AccountDetailInfo.id: (_) => const AccountDetailInfo(),
    RegisterScreen.id: (_) => const RegisterScreen(),
    RegisterInfoFormScreen.id: (_) => const RegisterInfoFormScreen(),
  };
}
