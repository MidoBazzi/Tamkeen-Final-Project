class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String svgImage;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.svgImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      svgImage: json['svg_image'] ?? '',
    );
  }

  static List<CategoryModel> fromJsonList(Map<String, dynamic> json) {
    List<CategoryModel> categories = [];
    json['data'].forEach((e) => categories.add(CategoryModel.fromJson(e)));
    return categories;
  }
}
