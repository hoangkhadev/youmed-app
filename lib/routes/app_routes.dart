import 'package:my_flutter_app/screens/account/account_screen.dart';
import 'package:my_flutter_app/screens/appointment/appointment_screen.dart';
import 'package:my_flutter_app/screens/home/home_screen.dart';
import 'package:my_flutter_app/screens/message/message_screen.dart';
import 'package:my_flutter_app/screens/splash/splash.screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.id: (context) => const SplashScreen(),
    HomeScreen.id: (context) => const HomeScreen(),
    AccountScreen.id: (context) => const AccountScreen(),
    MessageScreen.id: (context) => const MessageScreen(),
    AppointmentScreen.id: (context) => const AppointmentScreen(),
  };
}
