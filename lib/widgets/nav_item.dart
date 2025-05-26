import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class NavItem extends StatelessWidget {
  final String imagePath;
  final String imageActivePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.imagePath,
    required this.imageActivePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? GlobalColors.mainColor : GlobalColors.textColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.withValues(alpha: 0.1),
        highlightColor: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                isSelected ? imageActivePath : imagePath,
                width: 22,
                height: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
