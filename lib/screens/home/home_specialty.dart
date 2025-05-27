import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';
import 'package:my_flutter_app/widgets/feature_item.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';

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
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.specialtyBagIcon,
            title: 'Khám theo chuyên khoa',
          ),
          SizedBox(height: 30),
          FittedBox(
            child: Column(
              children: List.generate(2, (rowIndex) {
                int startIndex = rowIndex * 4;
                return Padding(
                  padding: EdgeInsets.only(bottom: rowIndex < 1 ? 30 : 0),
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

          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
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
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 12),
                ),
                backgroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 228, 225, 225),
                      width: 1,
                    ),
                  ),
                ),
              ),
              child: Text(
                'Xem tất cả các chuyên khoa',
                style: TextStyle(color: GlobalColors.textColor, fontSize: 14),
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
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: GlobalColors.textColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tất cả chuyên khoa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
                                ? 30
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
