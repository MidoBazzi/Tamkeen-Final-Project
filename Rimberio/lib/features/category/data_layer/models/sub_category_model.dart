// ignore_for_file: non_constant_identifier_names

class SubCategoryModel {
  final int id;
  final String name;
  final String svgImage;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.svgImage,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      svgImage: json['svg_image'] ?? '',
    );
  }

  static List<SubCategoryModel> fromJsonList(Map<String, dynamic> json) {
    List<SubCategoryModel> sub_categories = [];
    json['data'].forEach(
      (e) => sub_categories.add(SubCategoryModel.fromJson(e)),
    );
    return sub_categories;
  }
}
