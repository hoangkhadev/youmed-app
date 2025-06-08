import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/core/storage.dart';
import 'package:my_flutter_app/models/user_model.dart';
import 'package:my_flutter_app/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  final AuthService _authService = AuthService();

  Future<void> loadUser() async {
    final userJson = await AppStorage.getUser();
    if (userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
      notifyListeners();
    }
  }

  Future<void> login(String phone, String password) async {
    final user = await _authService.login(phone, password);
    if (user != null) {
      _user = user;
    }
    notifyListeners();
  }

  Future<void> register(String phone, String password) async {
    final user = await _authService.register(phone, password);
    _user = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
