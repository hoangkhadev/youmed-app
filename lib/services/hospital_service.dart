import 'dart:convert';

import 'package:my_flutter_app/core/api_client.dart';
import 'package:my_flutter_app/models/hospital_model.dart';

class HospitalService {
  final _api = ApiClient();

  Future<List<HospitalModel>?> getHospitals({int? limit}) async {
    final res = await _api.get('hospitals?limit=$limit');

    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);
      return data.map((item) => HospitalModel.fromJson(item)).toList();
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Có lỗi xảy ra vui lòng thử lại sau';
    }
  }
}
