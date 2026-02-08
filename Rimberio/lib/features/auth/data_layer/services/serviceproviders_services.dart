import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Response, Trans, FormData;
import 'package:get_storage/get_storage.dart';

class ServiceprovidersServices {
  Dio dio = Dio();
  final box = GetStorage();
  final String baseUrl = 'http://94.72.98.154:8085/api';
  Future<bool> becomeABrovider({
    required String phone,
    required String providerName,
    required String shopNameAr,
    required String shopNameEn,
    required String discreptionAr,
    required String discreptionEn,
    required String facebookLink,
    required String whatsappLink,
    required String instaLink,
    required int stateId,
    required int cityid,
    required int categoryid,
    required int subCategoryid,
    required int socialLinkphone,
    required int socialLinkinsta,
    required int socialLinkface,
  }) async {
    try {
      String? token = box.read('token');
      FormData formData = FormData.fromMap({
        "provider_name": providerName,
        "shop_name[ar]": shopNameAr,
        "shop_name[en]": shopNameEn,
        "description[ar]": discreptionAr,
        "description[en]": discreptionEn,
        "city_id": cityid.toString(),
        "state_id": stateId.toString(),
        "category_id": categoryid.toString(),
        "sub_category_id": subCategoryid.toString(),
        "social_links": [
          {"type": socialLinkphone, "value": phone},
          {"type": socialLinkface, "value": facebookLink},
          {"type": socialLinkinsta, "value": instaLink},
        ],
      });
      Response response = await dio.post(
        '$baseUrl/service-providers',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error, Please check your internet'.tr();
      }
      Map<String, dynamic> errors = e.response?.data['errors'.tr()];
      errors.forEach((field, errorList) {});
      throw e.response?.data["message".tr()];
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }
}
