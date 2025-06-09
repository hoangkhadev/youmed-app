import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:my_flutter_app/models/schedule_model.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class ScheduleWeekDays extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final List<ScheduleModel> schedules;

  const ScheduleWeekDays({
    super.key,
    required this.onDateSelected,
    required this.schedules,
  });

  @override
  State<ScheduleWeekDays> createState() => _ScheduleWeekDaysState();
}

class _ScheduleWeekDaysState extends State<ScheduleWeekDays> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final weekdayNames = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];

    final ScheduleModel? scheduleForSelectedDate = widget.schedules
        .firstWhereOrNull((schedule) {
          final scheduleDate = schedule.date.toLocal();
          return scheduleDate.year == selectedDate.year &&
              scheduleDate.month == selectedDate.month &&
              scheduleDate.day == selectedDate.day;
        });

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
                      isSelected ? GlobalColors.mainColor : Colors.grey[200],
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

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 206, 86),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    scheduleForSelectedDate != null
                        ? "${scheduleForSelectedDate.sessions.fold<int>(0, (prev, session) => prev + session.timeSlots.length)} slot"
                        : "0 slot",
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.green,
                    ),
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
