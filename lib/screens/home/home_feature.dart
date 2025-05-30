import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/feature_item.dart';

class HomeFeature extends StatelessWidget {
  const HomeFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: GlobalColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: List.generate(3, (rowIndex) {
            int startIndex = rowIndex * 3;
            return Padding(
              padding: EdgeInsets.only(bottom: rowIndex < 2 ? 20 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (colIndex) {
                  int itemIndex = startIndex + colIndex;
                  final item = features[itemIndex];
                  return FeatureItem(
                    title: item['title']!,
                    imagePath: item['image']!,
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}
