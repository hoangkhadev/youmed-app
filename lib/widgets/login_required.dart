import 'package:flutter/material.dart';

import 'package:my_flutter_app/screens/auth/login_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

class LoginRequired extends StatelessWidget {
  const LoginRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(GlobalImageIcons.loginRequired, height: 100),
        SizedBox(height: 30),
        Text(
          'Bạn cần đăng nhập để sử dụng chức năng này.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: GlobalColors.textColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tạo tài khoản hoặc đăng nhập ngay',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: GlobalColors.textColor,
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            foregroundColor: GlobalColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            minimumSize: Size(150, 30),
          ),
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.id);
          },
          child: Text(
            'Đăng nhập',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
