import 'package:intl/intl.dart';

class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String dob;
  final String gender;

  final String city;
  final String district;
  final String ward;
  final String? address2;

  String get address => [
    address2,
    ward,
    district,
    city,
  ].where((e) => e != null && e.trim().isNotEmpty).join(', ');

  String get dobFormated {
    try {
      DateTime date = DateTime.parse(dob);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return dob;
    }
  }

  UserModel({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.email,
    required this.city,
    required this.district,
    required this.ward,
    this.address2,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final address = json['address'] as Map<String, dynamic>? ?? {};

    return UserModel(
      id: json['_id'] ?? '',
      fullName: json['full_name'] ?? '',
      dob: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      city: address['city'] ?? '',
      district: address['district'] ?? '',
      ward: address['ward'] ?? '',
      address2: address['address2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'full_name': fullName,
      'date_of_birth': dob,
      'gender': gender,
      'phone': phone,
      'email': email,
      'address': {
        'city': city,
        'district': district,
        'ward': ward,
        'address2': address2,
      },
    };
  }
}
