class Ward {
  final String id;
  final String name;
  final String level;

  Ward({required this.id, required this.name, required this.level});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['Id']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      level: json['Level']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'Id': id, 'Name': name, 'Level': level};
}

class District {
  final String id;
  final String name;
  final List<Ward> wards;

  District({required this.id, required this.name, required this.wards});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['Id']?.toString() ?? '', // Xử lý null safety
      name: json['Name']?.toString() ?? '',
      wards:
          (json['Wards'] as List<dynamic>?)
              ?.map((w) => Ward.fromJson(w as Map<String, dynamic>))
              .toList() ??
          [], // Xử lý trường hợp Wards là null
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'Wards': wards.map((w) => w.toJson()).toList(),
  };
}

class City {
  final String id;
  final String name;
  final List<District> districts;

  City({required this.id, required this.name, required this.districts});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['Id']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      districts:
          (json['Districts'] as List<dynamic>?)
              ?.map((d) => District.fromJson(d as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'Districts': districts.map((d) => d.toJson()).toList(),
  };
}
