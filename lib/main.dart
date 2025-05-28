import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/splash/splash.screen.dart';
import 'package:my_flutter_app/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouMed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
      initialRoute: SplashScreen.id,
      routes: AppRoutes.routes,
    );
  }
}
