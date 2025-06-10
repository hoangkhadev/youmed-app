import 'dart:convert';

import 'package:my_flutter_app/core/api_client.dart';
import 'package:my_flutter_app/models/appointment_model.dart';

class AppointmentService {
  final _api = ApiClient();

  Future<AppointmentModel?> createAppointment(
    AppointmentModel appointment,
  ) async {
    final res = await _api.post('appointments', appointment.toJson());
    if (res.statusCode == 201) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return AppointmentModel.fromJson(data);
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Có lỗi xảy ra vui lòng thử lại sau';
    }
  }

  Future<List<AppointmentModel>?> getAppointments(String userId) async {
    final res = await _api.get('appointments/$userId/user');
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((item) => AppointmentModel.fromJson(item)).toList();
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Có lỗi xảy ra vui lòng thử lại sau';
    }
  }
}
