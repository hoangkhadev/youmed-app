import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/feature_item.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';

class HomeSpecialty extends StatefulWidget {
  const HomeSpecialty({super.key});

  @override
  State<HomeSpecialty> createState() => _HomeSpecialtyState();
}

class ForgotPasswordSheet extends StatefulWidget {
  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _HomeSpecialtyState extends State<HomeSpecialty> {
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
            isArrow: true,
          ),
          SizedBox(height: 30),
          Column(
            children: List.generate(2, (rowIndex) {
              int startIndex = rowIndex * 2;
              return Padding(
                padding: EdgeInsets.only(bottom: rowIndex < 1 ? 35 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (colIndex) {
                    int itemIndex = startIndex + colIndex;
                    final item = specialties[itemIndex];
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
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  builder: (context) => ForgotPasswordSheet(),
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

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // For keyboard
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Column(
              children: List.generate(2, (rowIndex) {
                int startIndex = rowIndex * 2;
                return Padding(
                  padding: EdgeInsets.only(bottom: rowIndex < 1 ? 35 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (colIndex) {
                      int itemIndex = startIndex + colIndex;
                      final item = specialties[itemIndex];
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
          ],
        ),
      ),
    );
  }
}
