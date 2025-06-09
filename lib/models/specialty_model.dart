class SpecialtyModel {
  final String id;
  final String name;
  final String imageUrl;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}
