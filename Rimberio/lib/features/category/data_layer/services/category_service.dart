import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/features/category/data_layer/models/category_model.dart';
import 'package:service_provider/features/category/data_layer/models/sub_category_model.dart';

class CategoryService {
  final Dio dio = Dio();
  final String baseUrl = 'http://94.72.98.154:8085/api';

  Future<List<CategoryModel>> getCategories({String? name}) async {
    try {
      final response = await dio.get(
        '$baseUrl/categories',
        queryParameters: name != null ? {'name': name} : null,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CategoryModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Failed to load categories'.tr();
      }
    } catch (e) {
      throw 'Error: $e'.tr();
    }
  }

  Future<List<SubCategoryModel>> getSubCategories(
    int categoryId, {
    String? name,
  }) async {
    try {
      Map<String, dynamic> queryParams = {'category_ids[0]': categoryId};

      if (name != null && name.isNotEmpty) {
        queryParams['name'] = name;
      }

      final response = await dio.get(
        '$baseUrl/sub-categories',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );

      if (response.statusCode == 200) {
        return SubCategoryModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ??
            'Failed to load sub-categories'.tr();
      }
    } catch (e) {
      throw 'Error: $e'.tr();
    }
  }
}
