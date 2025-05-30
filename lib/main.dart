import 'package:flutter/material.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/splash/splash.screen.dart';
import 'package:my_flutter_app/routes/app_routes.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:provider/provider.dart';

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
