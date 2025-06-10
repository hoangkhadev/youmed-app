import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/models/user_model.dart';

enum AppointmentStatus { pending, confirmed, cancelled, done }

class SnapshotTimeSlot {
  final String session;
  final String startTime;
  final String endTime;

  SnapshotTimeSlot({
    required this.session,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {"session": session, "start_time": startTime, "end_time": endTime};
  }

  factory SnapshotTimeSlot.fromJson(Map<String, dynamic> json) {
    return SnapshotTimeSlot(
      session: json['session'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

class AppointmentModel {
  final String? id;
  final UserModel patient;
  final DoctorModel doctor;
  final String datetime;
  final String reason;
  final AppointmentStatus? status;
  final SnapshotTimeSlot snapshotTimeSlot;

  AppointmentModel({
    this.id,
    required this.patient,
    required this.doctor,
    required this.datetime,
    required this.reason,
    required this.snapshotTimeSlot,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "patient": patient.id,
      "doctor": doctor.id,
      "datetime": datetime,
      "reason": reason,
      "snapshot_time_slot": snapshotTimeSlot.toJson(),
      if (status != null) "status": status!.name,
    };
  }

  static AppointmentStatus? _statusFromString(String? statusString) {
    if (statusString == null) return null;

    switch (statusString.toLowerCase()) {
      case 'pending':
        return AppointmentStatus.pending;
      case 'confirmed':
        return AppointmentStatus.confirmed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'done':
        return AppointmentStatus.done;
      default:
        return null;
    }
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'],
      patient: UserModel.fromJson(json['patient']),
      doctor: DoctorModel.fromJson(json['doctor']),
      datetime: json['datetime'],
      reason: json['reason'],
      status: _statusFromString(json['status']),
      snapshotTimeSlot: SnapshotTimeSlot.fromJson(json['snapshot_time_slot']),
    );
  }
}
