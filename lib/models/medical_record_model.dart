import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/models/user_model.dart';

class MedicalRecordModel {
  final String? id;
  final UserModel patient;
  final DoctorModel doctor;
  final AppointmentModel appointment;
  final String? diagnosis;
  final String? symptoms;

  MedicalRecordModel({
    this.id,
    required this.patient,
    required this.doctor,
    required this.appointment,
    this.diagnosis,
    this.symptoms,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['_id'],
      patient: UserModel.fromJson(json['patient']),
      doctor: DoctorModel.fromJson(json['doctor']),
      appointment: AppointmentModel.fromJson(json['appointment']),
      symptoms: json['symptoms'] ?? '',
      diagnosis: json['diagnosis'] ?? '',
    );
  }
}
