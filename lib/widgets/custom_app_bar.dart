import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomAppBar({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: GlobalColors.mainColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      leadingWidth: 40,
      leading: GestureDetector(
        onTap:
            onTap ??
            () {
              Navigator.pop(context);
            },
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
