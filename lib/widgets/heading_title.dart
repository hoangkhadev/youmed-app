import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class HeadingTitle extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool? isArrow;
  final VoidCallback? onTap;

  const HeadingTitle({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.isArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 24, height: 24),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: GlobalColors.textColor,
              ),
            ),
          ),

          if (isArrow!)
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Colors.grey,
              weight: 5000,
            ),
        ],
      ),
    );
  }
}
