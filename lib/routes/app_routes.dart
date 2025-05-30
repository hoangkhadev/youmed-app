import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/auth/login_screen.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/screens/splash/splash.screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.id: (context) => const SplashScreen(),
    LoginScreen.id: (context) => const LoginScreen(),
    MainScreen.id: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as int?;
      return MainScreen(currentIndex: args ?? 0);
    },    
  };
}
