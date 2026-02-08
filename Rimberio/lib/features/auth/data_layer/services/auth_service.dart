import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans, Response, MultipartFile, FormData;
import 'package:get_storage/get_storage.dart';
import 'package:service_provider/features/auth/data_layer/models/city_model.dart';
import 'package:service_provider/features/auth/data_layer/models/state_model.dart';
import 'package:service_provider/features/auth/data_layer/models/user_model.dart';

class AuthService {
  Dio dio = Dio();
  final box = GetStorage();
  final String baseUrl = 'http://94.72.98.154:8085/api';

  Future<bool> login({required String phone, required String password}) async {
    try {
      Response response = await dio.post(
        '$baseUrl/auth/login',
        data: {'phone': phone, 'password': password},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );
      if (response.statusCode == 200) {
        final token = response.data["data"]["token"];
        final userData = response.data["data"]["user"];

        box.write('token', token);
        box.write('user_info', userData);
        return true;
      } else {
        throw response.data['message'.tr()] ?? 'Login Failed'.tr();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()];
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  // -----------------OTP-----------------//
  Future<bool> otp({
    required String phone,
    required String code,
    required int forVerifiyAccount,
  }) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/verify-code',
        data: {
          "phone": phone,
          "code": code,
          "for_verifiy_account": forVerifiyAccount,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );
      if (response.statusCode == 200) {
        final token = response.data["data"]["token"];
        final userData = response.data["data"]["user"];

        box.write('token', token);
        box.write('user_info', userData);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()];
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  // -----------------Register-----------------//
  Future<List<CityModel>> getCities(int stateId) async {
    try {
      final response = await dio.get(
        '$baseUrl/cities',
        queryParameters: {'state_id': stateId},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return CityModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Failed to load categories'.tr();
      }
    } catch (e) {
      throw 'Error: $e'.tr();
    }
  }

  Future<List<StateModel>> getStates() async {
    try {
      final response = await dio.get(
        '$baseUrl/states',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return StateModel.fromJsonList(response.data);
      } else {
        throw response.data['message'.tr()] ?? 'Failed to load categories'.tr();
      }
    } catch (e) {
      throw 'Error: $e'.tr();
    }
  }

  Future<bool> signup({
    required String phone,
    required String firstname,
    required String lastname,
    required String password,
    required String passwordconfirmation,
    required int stateId,
    required int cityid,
  }) async {
    try {
      Response response = await dio.post(
        '$baseUrl/auth/register',
        data: {
          "first_name": firstname,
          "last_name": lastname,
          "phone": phone,
          "password": password,
          "password_confirmation": passwordconfirmation,
          "city_id": cityid,
          'state_id': stateId,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
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
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()];
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  //----------------ForgotPassword------------------//
  Future<bool> forgotPassword({required String phone}) async {
    try {
      Response response = await dio.post(
        '$baseUrl/auth/forget-password',
        data: {"phone": phone},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
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
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()];
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  //----------------Resetpassword------------------//
  Future<bool> resetpassword({
    required String phone,
    required String password,
    required String passwordconfirmation,
  }) async {
    try {
      Response response = await dio.post(
        '$baseUrl/auth/reset-password',
        data: {
          "phone": phone,
          "code": 1111,
          "password": password,
          "password_confirmation": passwordconfirmation,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
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
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()];
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  //--------------------------updateProfile-------------------------//
  Future<User?> updateProfile({
    required String firstName,
    required String lastName,
    required int cityid,
    File? imageFile,
  }) async {
    try {
      String? token = box.read('token');

      Map<String, dynamic> dataMap = {
        "first_name": firstName,
        "last_name": lastName,
        "city_id": cityid,
      };

      if (imageFile != null) {
        dataMap["image"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(dataMap);

      Response response = await dio.post(
        '$baseUrl/auth/update-profile',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data['data']);
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()] ?? 'Something went wrong'.tr();
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  Future<bool> logout() async {
    try {
      String? token = box.read('token');
      Response response = await dio.delete(
        '$baseUrl/auth/logout',
        data: {},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
          },
        ),
      );
      if (response.statusCode == 200) {
        await box.remove('user_info');
        await box.remove('token');
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()] ?? 'Something went wrong'.tr();
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }

  //----------------------changePassword--------------------------//
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordconfirmation,
  }) async {
    try {
      String? token = box.read('token');
      Response response = await dio.post(
        '$baseUrl/auth/change-password',
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordconfirmation,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept-Language': Get.context?.locale.languageCode ?? 'en',
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
        throw 'Connection error, Please check your internet'.tr();
      }
      throw e.response?.data["message".tr()] ?? 'Something went wrong'.tr();
    } catch (e) {
      throw 'Unexpected error: $e'.tr();
    }
  }
}
