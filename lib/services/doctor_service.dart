import 'dart:convert';

import 'package:my_flutter_app/core/api_client.dart';
import 'package:my_flutter_app/models/doctor_model.dart';

class DoctorService {
  final _api = ApiClient();

  Future<List<DoctorModel>?> getAllDoctors({
    int? limit,
    String? search = '',
  }) async {
    final res = await _api.get('doctors?limit=$limit&q=$search');

    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);
      return data.map((item) => DoctorModel.fromJson(item)).toList();
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Lỗi khi lấy danh sách bác sĩ';
    }
  }

  Future<DoctorModel> getDoctorById(String id) async {
    final res = await _api.get('doctors/$id');

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return DoctorModel.fromJson(data);
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Lỗi khi lấy chi tiết bác sĩ';
    }
  }
}
