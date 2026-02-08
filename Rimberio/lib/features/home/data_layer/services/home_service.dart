import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:service_provider/features/home/data_layer/models/slider_model.dart';
import 'package:service_provider/features/home/data_layer/models/tags_model.dart';

class HomeService {
  final Dio dio = Dio();
  final box = GetStorage();
  final String baseUrl = 'http://94.72.98.154:8085/api';

  Future<List<SliderModel>> getSliders() async {
    try {
      final response = await dio.get(
        '$baseUrl/sliders',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );

      if (response.statusCode == 200) {
        return SliderModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Slider loading failed'.tr();
      }
    } catch (e) {
      throw 'An error occurred while loading the slider: $e'.tr();
    }
  }

  Future<List<TagsModel>> getTags() async {
    try {
      final response = await dio.get(
        '$baseUrl/tags',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );

      if (response.statusCode == 200) {
        return TagsModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Tag loading failed'.tr();
      }
    } catch (e) {
      throw 'An error occurred while loading the Tag: $e'.tr();
    }
  }
}
