import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/routes/app_routes.dart';
import 'package:my_flutter_app/screens/splash/splash.screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Booking',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: GlobalColors.bgColor,
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(GlobalColors.mainColor),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: AppRoutes.routes,
    );
  }
}
