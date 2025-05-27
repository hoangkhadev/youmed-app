import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';

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
    return Container(
      color: GlobalColors.mainColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      GlobalImageIcons.userIcon,
                      width: 28,
                      height: 28,
                    ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getGreeting(),
                          style: TextStyle(
                            color: GlobalColors.whiteColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Đăng ký / Đăng nhập',
                          style: TextStyle(
                            color: GlobalColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Image.asset(
                  GlobalImageIcons.notificationIcon,
                  width: 28,
                  height: 28,
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
                  Image.asset(
                    GlobalImageIcons.searchIcon,
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tên bác sĩ, triệu chứng bệnh, chuyên khoa, bệnh viện, bệnh viện',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
