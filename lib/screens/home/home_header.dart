import 'package:flutter/material.dart';
import '../../screens/search/search_screen.dart';
import '../../utils/global.colors.dart';
import '../../utils/global.images.icons.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
                          'Buổi chiều rực rỡ!',
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
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: GlobalColors.whiteColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.search, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Tên bác sĩ, triệu chứng bệnh, chuyên khoa...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black12,
            //         blurRadius: 4,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       suffixIcon: IconButton(
            //         icon: const Icon(Icons.search, color: Colors.green),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => const FindDoctorScreen(),
            //             ),
            //           );
            //         },
            //       ),
            //       hintText: "Search...",
            //       border: InputBorder.none,
            //       contentPadding: const EdgeInsets.symmetric(vertical: 14),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
