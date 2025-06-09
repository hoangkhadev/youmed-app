class TimeSlot {
  final String id;
  final String startTime;
  final String endTime;
  final bool isBooked;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      isBooked: json['is_booked'],
    );
  }
}

class Session {
  final String session;
  final List<TimeSlot> timeSlots;

  Session({required this.session, required this.timeSlots});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      session: json['session'],
      timeSlots:
          (json['time_slots'] as List)
              .map((slot) => TimeSlot.fromJson(slot))
              .toList(),
    );
  }
}

class ScheduleModel {
  final String id;
  final String doctorId;
  final DateTime date;
  final List<Session> sessions;

  ScheduleModel({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.sessions,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['_id'],
      doctorId: json['doctor'],
      date: DateTime.parse(json['date']),
      sessions:
          (json['sessions'] as List).map((s) => Session.fromJson(s)).toList(),
    );
  }
}
