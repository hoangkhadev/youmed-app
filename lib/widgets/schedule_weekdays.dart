import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

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
      children: List.generate(14, (index) {
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

            child: Column(
              children: [
                Text(
                  weekdayNames[date.weekday % 7],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 25,
                  backgroundColor:
                      isSelected
                          ? GlobalColors.mainColor
                          : Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      date.day.toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? GlobalColors.whiteColor : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "15 slot",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.green,
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
