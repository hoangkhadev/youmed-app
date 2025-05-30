import 'package:intl/intl.dart';

class UserEntity {
  final String id;
  final String fullName;
  final String phone;
  final String dob;
  final String gender;

  final String city;
  final String district;
  final String ward;
  final String? street;

  String get address => [street, ward, district, city].join(', ');
  String get dobFormated {
    DateTime date = DateTime.parse(dob);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  UserEntity({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.city,
    required this.district,
    required this.ward,
    this.street,
  });
}
