class TagsModel {
  final String name;
  TagsModel({required this.name});
  factory TagsModel.fromJson(Map<String, dynamic> json) {
    return TagsModel(name: json['name']);
  }

  static List<TagsModel> fromJsonList(Map<String, dynamic> json) {
    List<TagsModel> tags = [];
    json['data'].forEach((e) => tags.add(TagsModel.fromJson(e)));
    return tags;
  }
}
