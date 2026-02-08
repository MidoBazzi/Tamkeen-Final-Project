// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/get_utils.dart' hide Trans;
import 'package:service_provider/features/governmententities/data_layer/models/government_entity_model.dart';

class GovernmententitiesService {
  final Dio dio = Dio();

  Future<List<GovernmentEntityModel>> getGovernmentEntities({
    String? name,
  }) async {
    try {
      final response = await dio.get(
        'http://94.72.98.154:8085/api/goverment-entities',
        queryParameters: name != null ? {'name': name} : {},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );
      if (response.statusCode == 200) {
        return GovernmentEntityModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Entities loading failed'.tr();
      }
    } catch (e) {
      throw 'Error loading entities: $e'.tr();
    }
  }
}
