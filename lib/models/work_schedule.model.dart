import 'package:my_flutter_app/models/time_slot.model.dart';

class WorkSchedule {
  final DateTime date; // Ngày khám (vd: 2025-05-26)
  final String period; // Buổi sáng, Buổi chiều
  final List<TimeSlot> slots; // Các khung giờ trong buổi

  WorkSchedule({required this.date, required this.period, required this.slots});
}
