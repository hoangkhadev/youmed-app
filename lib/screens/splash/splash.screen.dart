import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static final id = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, MainScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35),
            child: Image.asset(GlobalImageIcons.logo),
          ),

          Transform.translate(
            offset: Offset(0, -35),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: LinearProgressIndicator(
                color: GlobalColors.mainColor,
                backgroundColor: Colors.grey[300],
                minHeight: 4,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
