import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? widthSizedBox;

  const FeatureItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.width = 40,
    this.height = 40,
    this.fontSize = 14,
    this.widthSizedBox = 85,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(imagePath, width: width, height: height),
          const SizedBox(height: 8),
          SizedBox(
            width: widthSizedBox,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: GlobalColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
