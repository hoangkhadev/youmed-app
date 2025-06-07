import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class TimeSlot extends StatefulWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlot({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color:
              widget.isSelected
                  ? GlobalColors.mainColor
                  : GlobalColors.whiteColor,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.time,
          style: TextStyle(
            color: widget.isSelected ? GlobalColors.whiteColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
