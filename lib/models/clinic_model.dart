class ClinicModel {
  final String name;
  final String imageUrl;
  final String address;

  const ClinicModel({
    required this.name,
    required this.imageUrl,
    required this.address,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      name: json['name'],
      imageUrl: json['image_url'],
      address: json['address'],
    );
  }
}
