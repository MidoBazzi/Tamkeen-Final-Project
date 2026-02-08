import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans, Response;
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:service_provider/features/settings/data_layer/models/policy_model.dart';

class SettingsService {
  Dio dio = Dio();
  final box = GetStorage();

  Future<bool> contactUs({
    required String firstName,
    required String lastName,
    required String phone,
    required String message,
  }) async {
    try {
      String? token = box.read('token');

      Response response = await dio.post(
        'http://94.72.98.154:8085/api/contacts',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "message": message,
          "phone": phone,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error, Please check your internet';
      }
      throw e.response?.data["message".tr()] ?? 'Something went wrong'.tr();
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  Future<List<PolicyModel>> getPages() async {
    try {
      final response = await dio.get(
        'http://94.72.98.154:8085/api/pages',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return PolicyModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Failed to load pages'.tr();
      }
    } catch (e) {
      throw 'Error: $e'.tr();
    }
  }
}
