import 'package:flutter/material.dart';

import '../../utils/data.dart';
import '../../utils/global.colors.dart';
import '../../utils/global.images.icons.dart';
import '../../widgets/feature_item.dart';
import '../../widgets/heading_title.dart';

class HomeSpecialty extends StatefulWidget {
  const HomeSpecialty({super.key});

  @override
  State<HomeSpecialty> createState() => _HomeSpecialtyState();
}

class _HomeSpecialtyState extends State<HomeSpecialty> {
  var displayItems = specialties.take(8).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.specialtyBagIcon,
            title: 'Khám theo chuyên khoa',
          ),

          SizedBox(height: 20),
          FittedBox(
            child: Column(
              children: List.generate(2, (rowIndex) {
                int startIndex = rowIndex * 4;
                return Padding(
                  padding: EdgeInsets.only(bottom: rowIndex < 1 ? 20 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (colIndex) {
                      int itemIndex = startIndex + colIndex;
                      final item = displayItems[itemIndex];
                      return FeatureItem(
                        width: 55,
                        height: 55,
                        widthSizedBox: 90,
                        title: item['title']!,
                        imagePath: item['image']!,
                      );
                    }),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              displayItems = specialties.toList();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder:
                    (context) =>
                        modalBottomSheetSpecialty(context, displayItems),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              minimumSize: Size(double.infinity, 50),
              foregroundColor: GlobalColors.mainColor,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: const Color.fromARGB(255, 216, 216, 216),
                width: 0.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Xem tất cả các chuyên khoa',
              style: TextStyle(
                color: GlobalColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget modalBottomSheetSpecialty(
  BuildContext context,
  List<Map<String, String>> displayItems,
) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
    children: [
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.close,
                        size: 22,
                        color: GlobalColors.textColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tất cả chuyên khoa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: GlobalColors.textColor,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Icon(
                      Icons.exit_to_app,
                      size: 24,
                      color: GlobalColors.textColor,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate((displayItems.length / 4).ceil(), (
                    rowIndex,
                  ) {
                    int startIndex = rowIndex * 4;
                    int endIndex = (startIndex + 4).clamp(
                      0,
                      displayItems.length,
                    );
                    final rowItems = displayItems.sublist(startIndex, endIndex);

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom:
                            rowIndex < (displayItems.length / 4).ceil() - 1
                                ? 20
                                : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                            rowItems.map((item) {
                              return FeatureItem(
                                width: 55,
                                height: 55,
                                widthSizedBox: 85,
                                title: item['title']!,
                                imagePath: item['image']!,
                              );
                            }).toList(),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),

      Positioned(
        top: -14,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            width: 45,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    ],
  );
}
