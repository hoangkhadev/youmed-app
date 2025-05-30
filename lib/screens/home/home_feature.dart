import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/widgets/feature_item.dart';

class HomeFeature extends StatelessWidget {
  const HomeFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6, right: 6),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
      ),
    );
  }
}
