import 'package:flutter/material.dart';

class ScheduleWeekDays extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const ScheduleWeekDays({super.key, required this.onDateSelected});

  @override
  State<ScheduleWeekDays> createState() => _ScheduleWeekDaysState();
}

class _ScheduleWeekDaysState extends State<ScheduleWeekDays> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final weekdayNames = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];

    return Row(
      children: List.generate(7, (index) {
        final date = today.add(Duration(days: index));
        final isSelected =
            selectedDate.day == date.day &&
            selectedDate.month == date.month &&
            selectedDate.year == date.year;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
            widget.onDateSelected(date);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue),
            ),
            child: Column(
              children: [
                Text(
                  weekdayNames[date.weekday % 7],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                CircleAvatar(
                  backgroundColor:
                      isSelected ? Colors.white : Colors.blue.shade100,
                  child: Text(
                    date.day.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "15 slot",
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
