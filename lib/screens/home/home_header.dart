import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/auth/login_screen.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

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
    final auth = context.watch<AuthProvider>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                auth.isLoggedIn
                    ? Navigator.pushReplacementNamed(
                      context,
                      MainScreen.id,
                      arguments: {'currentIndex': 3},
                    )
                    : Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Row(
                children: [
                  auth.isLoggedIn
                      ? avatarFromName(auth.currentUser?.fullName ?? '')
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
                        auth.isLoggedIn
                            ? auth.currentUser?.fullName ?? ""
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
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SearchScreen.id);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                Image.asset(GlobalImageIcons.searchIcon, width: 16, height: 16),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tên bác sĩ, triệu chứng bệnh, chuyên khoa, bệnh viện',
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
        ),
      ],
    );
  }
}

Widget avatarFromName(String fullName) {
  String generateInitials(String name) {
    if (name.trim().isEmpty) return '';

    final words =
        name.trim().split(' ').where((word) => word.isNotEmpty).toList();

    if (words.isEmpty) return '';

    if (words.length == 1) {
      final word = words[0];
      return word.isNotEmpty ? word[0].toUpperCase() : '';
    }

    final firstWord = words.first;
    final lastWord = words.last;

    if (firstWord.isEmpty || lastWord.isEmpty) return '';

    final firstChar = firstWord[0].toUpperCase();
    final lastChar = lastWord[0].toUpperCase();

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
