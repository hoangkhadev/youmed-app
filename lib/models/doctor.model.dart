import 'package:my_flutter_app/models/work_schedule.model.dart';

class Doctor {
  final String id;
  final String name;
  final String title; // Ví dụ: "TS. BS"
  final String avatarUrl;
  final String specialty; // Bác sĩ
  final List<String> specialties; // Nội thận, Ngoại tiết niệu
  final String position; // Trưởng khoa...
  final int experience; // Số năm kinh nghiệm
  final String department; // Nội thận - Tiết niệu
  final String address;
  final List<WorkSchedule> schedules;
  final bool isSaved; // Đã lưu bác sĩ
  final bool isVerified; // Có tick xanh
  final String? introduce;

  Doctor({
    required this.id,
    required this.name,
    required this.title,
    required this.avatarUrl,
    required this.specialty,
    required this.specialties,
    required this.position,
    required this.experience,
    required this.department,
    required this.address,
    required this.schedules,
    required this.isSaved,
    required this.isVerified,
    this.introduce,
  });

  Doctor copyWith({
    String? id,
    String? name,
    String? title,
    String? avatarUrl,
    String? specialty,
    List<String>? specialties,
    String? position,
    int? experience,
    String? department,
    String? address,
    List<WorkSchedule>? schedules,
    bool? isSaved,
    bool? isVerified,
    String? introduce,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      specialty: specialty ?? this.specialty,
      specialties: specialties ?? this.specialties,
      position: position ?? this.position,
      experience: experience ?? this.experience,
      department: department ?? this.department,
      address: address ?? this.address,
      schedules: schedules ?? this.schedules,
      isSaved: isSaved ?? this.isSaved,
      isVerified: isVerified ?? this.isVerified,
      introduce: introduce ?? this.introduce,
    );
  }
}
