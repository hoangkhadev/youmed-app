import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/main_screen.dart';
import '../../utils/global.colors.dart';
import '../../utils/gobal.images.icons.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 11) {
      return 'Buổi sáng tốt lành!';
    } else if (hour >= 11 && hour < 18) {
      return 'Buổi chiều rực rỡ!';
    } else {
      return 'Buổi tối an lành!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      color: GlobalColors.mainColor,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  authProvider.isLoggedIn
                      ? Navigator.pushReplacementNamed(
                        context,
                        MainScreen.id,
                        arguments: 3,
                      )
                      : Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Row(
                  children: [
                    authProvider.isLoggedIn
                        ? avatarFromName(authProvider.currentUser!.fullName)
                        : Image.asset(
                          GlobalImageIcons.userIcon,
                          width: 24,
                          height: 24,
                        ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getGreeting(),
                          style: TextStyle(
                            color: GlobalColors.whiteColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          authProvider.isLoggedIn
                              ? authProvider.currentUser!.fullName
                              : 'Đăng ký / Đăng nhập',
                          style: TextStyle(
                            color: GlobalColors.whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Image.asset(
                GlobalImageIcons.notificationIcon,
                width: 24,
                height: 24,
              ),
            ],
          ),

          SizedBox(height: 12),

          /* Header Search */
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: GlobalColors.whiteColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                Image.asset(GlobalImageIcons.searchIcon, width: 16, height: 16),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tên bác sĩ, triệu chứng bệnh, chuyên khoa, bệnh viện, bệnh viện',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: GlobalColors.subTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget avatarFromName(String fullName) {
  String generateInitials(String name) {
    final words = name.trim().split(' ');

    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();

    final firstChar = words.first[0].toUpperCase();
    final lastChar = words.last[0].toUpperCase();
    return '$firstChar$lastChar';
  }

  return CircleAvatar(
    radius: 22,
    backgroundColor: Colors.grey.shade600,
    child: Text(
      generateInitials(fullName),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
  );
}
