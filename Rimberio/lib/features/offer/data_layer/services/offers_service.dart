import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/features/offer/data_layer/models/offers_model.dart';

class OffersService {
  final Dio dio = Dio();
  final String baseUrl = 'http://94.72.98.154:8085/api';

  Future<List<OfferModel>> getOffers({String? name}) async {
    try {
      final response = await dio.get(
        '$baseUrl/offers',
        queryParameters: name != null ? {'name': name} : null,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );

      if (response.statusCode == 200) {
        return OfferModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Failed to load offers'.tr();
      }
    } catch (e) {
      throw 'Error: $e'.tr();
    }
  }
}
