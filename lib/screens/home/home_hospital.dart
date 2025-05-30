import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class HomeHospital extends StatelessWidget {
  const HomeHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.hospitalHeadingIcon,
            title: 'Bệnh viện',
            isArrow: true,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: ScrollableScreenWrapper(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(hospitals.length, (index) {
                  var item = hospitals[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < hospitals.length - 1 ? 16 : 0,
                    ),
                    child: hospitalItem(
                      item['image']!,
                      item['name']!,
                      item['address']!,
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

Widget hospitalItem(String avatarUrl, String name, String address) {
  return Container(
    color: Colors.white,
    width: 300,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(radius: 38, backgroundImage: AssetImage(avatarUrl)),
        SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: GlobalColors.textColor,
                ),
              ),
              SizedBox(height: 2),
              Text(
                address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: GlobalColors.subTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
