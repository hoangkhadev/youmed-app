import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class HomeDoctorScreen extends StatelessWidget {
  const HomeDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.medicalStarIcon,
            title: 'Bác sĩ',
            isArrow: true,
          ),
          SizedBox(height: 30),
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
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: GlobalColors.textColor,
        ),
      ),
    ],
  );
}
