class GovernmentEntityModel {
  final int id;
  final String name;
  final String svgImage;
  final List<SocialLink> socialLinks;

  GovernmentEntityModel({
    required this.id,
    required this.name,
    required this.svgImage,
    required this.socialLinks,
  });

  factory GovernmentEntityModel.fromJson(Map<String, dynamic> json) {
    return GovernmentEntityModel(
      id: json['id'],
      name: json['name'],
      svgImage: json['svg_image'],
      socialLinks: (json['socialLinks'] as List)
          .map((i) => SocialLink.fromJson(i))
          .toList(),
    );
  }

  static List<GovernmentEntityModel> fromJsonList(Map<String, dynamic> json) {
    List<GovernmentEntityModel> entities = [];
    json['data'].forEach(
      (e) => entities.add(GovernmentEntityModel.fromJson(e)),
    );
    return entities;
  }
}

class SocialLink {
  final int id;
  final String typeLabel;
  final String typeCaseName;
  final String value;

  SocialLink({
    required this.id,
    required this.typeLabel,
    required this.typeCaseName,
    required this.value,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      id: json['id'],
      typeLabel: json['type_label'],
      typeCaseName: json['type_case_name'],
      value: json['value'],
    );
  }

  static List<SocialLink> fromJsonList(Map<String, dynamic> json) {
    List<SocialLink> links = [];
    json['socialLinks'].forEach((e) => links.add(SocialLink.fromJson(e)));
    return links;
  }
}
