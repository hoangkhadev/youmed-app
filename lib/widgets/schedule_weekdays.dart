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
  late List<ScheduleModel> _schedules;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _schedules = widget.schedules;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final weekdayNames = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            _schedules.map((schedule) {
              final date = schedule.date.toLocal();
              final isSelected =
                  selectedDate.year == date.year &&
                  selectedDate.month == date.month &&
                  selectedDate.day == date.day;

              final slotCount =
                  schedule.sessions
                      .expand((s) => s.timeSlots)
                      .where((slot) => !slot.isBooked)
                      .length;

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
                    color:
                        isSelected
                            ? GlobalColors.mainColor.withOpacity(0.1)
                            : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        weekdayNames[date.weekday % 7],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              isSelected
                                  ? GlobalColors.mainColor
                                  : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            isSelected
                                ? GlobalColors.mainColor
                                : Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            date.day.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 206, 86),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "$slotCount slot",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
