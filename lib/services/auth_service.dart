import 'dart:convert';

import 'package:my_flutter_app/core/api_client.dart';
import 'package:my_flutter_app/core/storage.dart';
import 'package:my_flutter_app/models/user_model.dart';

class AuthService {
  final ApiClient _api = ApiClient();

  Future<UserModel?> login(String phone, String password) async {
    final res = await _api.post('auth/login', {
      'phone': phone,
      'password': password,
    });

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      if (data['access_token'] == null || data['user'] == null) {
        throw 'Dữ liệu phản hồi không hợp lệ';
      }

      final token = data['access_token'];
      final user = UserModel.fromJson(data['user']);

      await AppStorage.saveAccessToken(token);
      await AppStorage.saveUser(jsonEncode(user.toJson()));

      return user;
    } else {
      final error = jsonDecode(res.body);
      throw error['message'] ?? 'Có lỗi xảy ra vui lòng thử lại sau';
    }
  }

  Future<UserModel?> register(String phone, String password) async {
    final res = await _api.post('auth/register', {
      'phone': phone,
      'password': password,
    });

    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      final token = data['access_token'];
      final user = UserModel.fromJson(data['user']);

      await AppStorage.saveAccessToken(token);
      await AppStorage.saveUser(jsonEncode(user.toJson()));

      return user;
    } else if (res.statusCode == 400) {
      final error = jsonDecode(res.body);
      throw error['message'];
    } else {
      throw 'Đã xảy ra lỗi, vui lòng thử lại sau';
    }
  }

  Future<void> logout() async {
    await AppStorage.clearAll();
  }

  Future<UserModel?> getCurrentUser() async {
    final token = await AppStorage.getAccessToken();
    if (token == null) throw 'Token không tồn tại';

    final api = ApiClient(accessToken: token);
    try {
      final res = await api.get('auth/me');

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final user = UserModel.fromJson(data);

        await AppStorage.saveUser(jsonEncode(user));
        return user;
      } else {
        final error = jsonDecode(res.body);
        throw error['message'] ?? 'Lỗi khi lấy thông tin người dùng';
      }
    } catch (e) {
      rethrow;
    }
  }
}
