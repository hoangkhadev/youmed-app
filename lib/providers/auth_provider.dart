import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/entities/user_entity.dart';
import 'package:my_flutter_app/models/request/login_request.dart';
import 'package:my_flutter_app/models/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? _currentUser;
  bool _isLoggedIn = false;

  UserEntity? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(Duration(seconds: 5));

    if (request.phone != '0342333084' || request.password != '123456') {
      return LoginResponse(
        success: false,
        message: 'Số điện thoại hoặc mật khẩu không đúng!',
      );
    }

    _currentUser = UserEntity(
      id: 'YMP123456789',
      fullName: 'Trần Hoàng Kha',
      dob: '2004-04-03T00:00:00',
      gender: 'Male',
      phone: '0342333084',
      city: 'Hồ Chí Minh',
      district: 'Quận Tân Phú',
      ward: 'Phường Tây Thạnh',
    );

    _isLoggedIn = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', _currentUser!.id);
    await prefs.setString('userName', _currentUser!.fullName);

    notifyListeners();

    return LoginResponse(success: true, message: 'Đăng nhập thành công!');
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }
}
