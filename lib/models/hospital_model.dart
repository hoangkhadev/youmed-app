class HospitalModel {
  final String name;
  final String imageUrl;
  final String address;

  const HospitalModel({
    required this.name,
    required this.imageUrl,
    required this.address,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      name: json['name'],
      imageUrl: json['image_url'],
      address: json['address'],
    );
  }
}
