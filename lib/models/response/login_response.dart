import 'package:my_flutter_app/models/entities/user_entity.dart';

class LoginResponse {
  final bool success;
  final String message;
  final UserEntity? user;

  LoginResponse({required this.success, required this.message, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user:
          json['data'] != null
              ? UserEntity(
                id: json['data']['id'] ?? '',
                fullName: json['data']['name'] ?? '',
                dob: json['data']['dob'] ?? '',
                gender: json['data']['gender'] ?? '',
                phone: json['data']['phone'] ?? '',
                city: json['data']['city'] ?? '',
                district: json['data']['district'] ?? '',
                ward: json['data']['ward'] ?? '',
                street: json['data']['street'] ?? '',
              )
              : null,
    );
  }
}
