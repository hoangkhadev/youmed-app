import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/splash/splash.screen.dart';
import '../routes/app_routes.dart';
import '../utils/global.colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: SafeArea(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouMed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: GlobalColors.bgColor,
      ),
      initialRoute: SplashScreen.id,
      routes: AppRoutes.routes,
    );
  }
}
