import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/appointment/appointment_booking.dart';
import 'package:my_flutter_app/screens/search/search_screen.dart';

import '../../screens/auth/login_screen.dart';
import '../../screens/main_screen.dart';
import '../../screens/splash/splash.screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.id: (context) => const SplashScreen(),
    LoginScreen.id: (context) => const LoginScreen(),
    MainScreen.id: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as int?;
      return MainScreen(currentIndex: args ?? 0);
    },
    SearchScreen.id: (context) => const SearchScreen(),
    AppointmentBooking.id: (context) => const AppointmentBooking(),
  };
}
