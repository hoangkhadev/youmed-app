import 'dart:convert';

import 'package:my_flutter_app/core/api_client.dart';
import 'package:my_flutter_app/core/storage.dart';
import 'package:my_flutter_app/models/user_model.dart';

class UserService {
  Future<UserModel?> update(UserModel user) async {
    final token = await AppStorage.getAccessToken();
    if (token == null) throw 'Token không tồn tại';
    final api = ApiClient(accessToken: token);

    final res = await api.put('users/${user.id}', user.toJson());

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return UserModel.fromJson(data);
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Có lỗi xảy ra vui lòng thử lại sau';
    }
  }
}
