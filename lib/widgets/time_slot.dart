import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class TimeSlotItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isBooked;
  final VoidCallback onTap;

  const TimeSlotItem({
    super.key,
    // required this.id,
    required this.time,
    required this.isSelected,
    this.isBooked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBooked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isBooked
                  ? Colors.grey[300]
                  : isSelected
                  ? GlobalColors.mainColor
                  : Colors.white,
          border: Border.all(
            color:
                isBooked
                    ? Colors.grey
                    : isSelected
                    ? GlobalColors.mainColor
                    : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          time,
          style: TextStyle(
            color:
                isBooked
                    ? Colors.grey[600]
                    : isSelected
                    ? Colors.white
                    : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
