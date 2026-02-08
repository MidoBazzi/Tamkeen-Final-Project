// ignore_for_file: non_constant_identifier_names

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String phone;
  final String? image;
  final String? cityName;
  final String? stateName;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.phone,
    this.image,
    this.cityName,
    this.stateName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      phone: json['phone'],
      image: json['image'],
      cityName: json['city'] != null ? json['city']['name'] : null,
      stateName: (json['city'] != null && json['city']['state'] != null)
          ? json['city']['state']['name']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'phone': phone,
      'image': image,
      'city': {
        'name': cityName,
        'state': {'name': stateName},
      },
    };
  }
}
