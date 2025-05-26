class TimeSlot {
  final String start; // "17:30"
  final String end; // "17:40"
  final bool isAvailable;

  TimeSlot({required this.start, required this.end, required this.isAvailable});

  String get display => '$start-$end';
}
