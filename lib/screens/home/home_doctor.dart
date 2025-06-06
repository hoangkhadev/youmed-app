import 'package:flutter/material.dart';

import '../../utils/data.dart';
import '../../utils/global.colors.dart';
import '../../utils/global.images.icons.dart';
import '../../widgets/heading_title.dart';
import '../../widgets/scrollable_screen_wrapper.dart';

class HomeDoctor extends StatelessWidget {
  const HomeDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8, top: 6),
      padding: EdgeInsets.all(10),

      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.medicalStarIcon,
            title: 'Bác sĩ',
            isArrow: true,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: ScrollableScreenWrapper(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(doctors.length, (index) {
                  var item = doctors[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < doctors.length - 1 ? 16 : 0,
                    ),
                    child: doctorItem(
                      item['avatarUrl'],
                      item['name'].split(' ').last,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget doctorItem(String avatarUrl, String name) {
  return Column(
    children: [
      CircleAvatar(radius: 30, backgroundImage: AssetImage(avatarUrl)),
      SizedBox(height: 6),
      Text(
        'Bác sĩ $name',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: GlobalColors.textColor,
        ),
      ),
    ],
  );
}
