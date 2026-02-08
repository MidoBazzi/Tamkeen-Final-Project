class OfferModel {
  final int id;
  final String title;
  final String imageUrl;
  final String providerName;
  final String shopName;

  OfferModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.providerName,
    required this.shopName,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    String url = '';
    if (json['media'] != null &&
        json['media']['image'] != null &&
        (json['media']['image'] as List).isNotEmpty) {
      url = json['media']['image'][0]['original_url'] ?? '';
    }

    return OfferModel(
      id: json['id'],
      title: json['title'] ?? '',
      imageUrl: url,
      providerName: json['serviceProvider']?['provider_name'] ?? '',
      shopName: json['serviceProvider']?['shop_name'] ?? '',
    );
  }

  static List<OfferModel> fromJsonList(Map<String, dynamic> json) {
    List<OfferModel> offers = [];
    if (json['data'] != null && json['data'] is List) {
      json['data'].forEach((e) => offers.add(OfferModel.fromJson(e)));
    }
    return offers;
  }
}
