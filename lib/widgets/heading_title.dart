import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 22, height: 22),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: GlobalColors.textColor,
              ),
            ),
          ),

          if (isArrow!)
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: GlobalColors.subTextColor,
            ),
        ],
      ),
    );
  }
}
