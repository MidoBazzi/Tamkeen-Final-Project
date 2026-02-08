class ProviderModel {
  final int id;
  final String providerName;
  final String shopName;
  final String description;
  final String address;
  final int views;
  final String mainImage;
  final List<String> gallery;
  final String subCategoryName;
  final List<String> tags;

  ProviderModel({
    required this.id,
    required this.providerName,
    required this.shopName,
    required this.description,
    required this.address,
    required this.views,
    required this.mainImage,
    required this.gallery,
    required this.tags,
    required this.subCategoryName,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    String mainImg = '';
    if (json['media'] != null &&
        json['media']['image'] != null &&
        (json['media']['image'] as List).isNotEmpty) {
      mainImg = json['media']['image'][0]['original_url'] ?? '';
    }

    List<String> galleryUrls = [];
    if (json['media'] != null && json['media']['gallery'] != null) {
      galleryUrls = (json['media']['gallery'] as List)
          .map((e) => e['original_url'].toString())
          .toList();
    }

    List<String> tagNames = [];
    if (json['tags'] != null) {
      tagNames = (json['tags'] as List)
          .map((e) => e['name'].toString())
          .toList();
    }

    int parsedViews = 0;
    if (json['views'] != null) {
      parsedViews = int.tryParse(json['views'].toString()) ?? 0;
    }

    return ProviderModel(
      id: json['id'],
      providerName: json['provider_name'] ?? '',
      shopName: json['shop_name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      views: parsedViews,
      mainImage: mainImg,
      gallery: galleryUrls,
      subCategoryName: json['subCategory']?['name'] ?? '',
      tags: tagNames,
    );
  }

  static List<ProviderModel> fromJsonList(Map<String, dynamic> json) {
    List<ProviderModel> providers = [];
    if (json['data'] != null && json['data'] is List) {
      json['data'].forEach((e) => providers.add(ProviderModel.fromJson(e)));
    }
    return providers;
  }
}
