import 'package:my_flutter_app/models/schedule_model.dart';
import 'package:my_flutter_app/models/specialty_model.dart';
import 'package:my_flutter_app/models/user_model.dart';

class DoctorModel {
  final String id;
  final UserModel user;
  final String avatarUrl;
  final String title;
  final int experienceYears;
  final String position;
  final List<SpecialtyModel> specializations;
  final List<ScheduleModel> schedules;
  final String bio;
  final String workplace;

  DoctorModel({
    required this.id,
    required this.user,
    required this.avatarUrl,
    required this.title,
    required this.experienceYears,
    required this.position,
    required this.specializations,
    required this.schedules,
    required this.bio,
    required this.workplace,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      title: json['title'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      position: json['position'] ?? '',
      bio: json['bio'] ?? '',
      workplace: json['workplace'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      specializations:
          (json['specializations'] as List?)
              ?.map((e) => SpecialtyModel.fromJson(e))
              .toList() ??
          [],
      schedules:
          (json['schedules'] as List?)
              ?.map((e) => ScheduleModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
