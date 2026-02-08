class CityModel {
  int cityId;
  String cityName;
  CityModel({required this.cityId, required this.cityName});
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(cityId: json['id'], cityName: json['name']);
  }
 static List<CityModel> fromJsonList(Map<String, dynamic> json) {
    List<CityModel> cities = [];
    json['data'].forEach((e) => cities.add(CityModel.fromJson(e)));
    return cities;
  }
}
