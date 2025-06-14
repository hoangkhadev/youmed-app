import 'dart:convert';

import 'package:my_flutter_app/core/api_client.dart';
import 'package:my_flutter_app/models/medical_record_model.dart';

class MedicalRecordService {
  final _api = ApiClient();

  Future<MedicalRecordModel?> getMedicalRecordByAppointmentId(
    String appointmentId,
  ) async {
    final res = await _api.get('medical-records/$appointmentId/user');

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return MedicalRecordModel.fromJson(data);
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Có lỗi xảy ra vui lòng thử lại sau';
    }
  }
}
