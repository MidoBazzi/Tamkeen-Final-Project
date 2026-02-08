import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/data_layer/models/city_model.dart';
import 'package:service_provider/features/auth/data_layer/models/state_model.dart';
import 'package:service_provider/features/auth/data_layer/models/user_model.dart';
import 'package:service_provider/features/auth/data_layer/services/auth_service.dart';
import 'package:service_provider/features/settings/business_logic_layer/settings_controller.dart';

class AuthController extends GetxController {
  RxList<StateModel> states = <StateModel>[].obs;
  RxList<CityModel> cities = <CityModel>[].obs;
  RxInt selectedCityId = 0.obs;
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool isobscure = true.obs;
  RxBool isobscure2 = true.obs;
  RxBool isobscure3 = true.obs;
  RxBool isobscure4 = true.obs;
  RxBool isobscure5 = true.obs;
  RxBool isobscure6 = true.obs;
  RxBool isobscure7 = true.obs;
  RxBool isobscure8 = true.obs;
  RxBool isChecked = false.obs;
  final AuthService _authService = AuthService();
  RxBool isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);
  final box = GetStorage();

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  void onInit() {
    super.onInit();
    loadStates();
    loadUserData();
  }

  RxList<CityModel> cityItems = <CityModel>[].obs;

  // -----------------LogIn-----------------//
  Future<void> login(String phone, String password) async {
    try {
      isLoading.value = true;
      bool success = await _authService.login(phone: phone, password: password);
      if (success) {
        isLoading.value = false;
        Get.snackbar('Login successfuly'.tr(), 'Welcome!'.tr());
        loadUserData();
        Get.offNamed(RoutingManager.superHome);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Failed'.tr(), e.toString().tr());
      Get.snackbar('Login Failed'.tr(), e.toString().tr());
    }
  }

  Future<void> otp(String phone, String otp, int forverifiyaccount) async {
    try {
      isLoading.value = true;
      bool success = await _authService.otp(
        phone: phone,
        code: otp,
        forVerifiyAccount: forverifiyaccount,
      );
      if (success) {
        isLoading.value = false;
        Get.snackbar('Login successfuly'.tr(), 'Welcome!'.tr());
        Get.offNamed(RoutingManager.superHome);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Failed'.tr(), e.toString());
    }
  }

  // -----------------Register-----------------//
  Future<void> loadStates() async {
    isLoading.value = true;
    log('message');
    try {
      states.value = await _authService.getStates();
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCities(int stateId) async {
    selectedCityId.value = 0;
    try {
      cities.value = await _authService.getCities(stateId);
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoading.value = false;
    }
  }

  //-----------------------signup----------------------------//
  Future<void> signup(
    String phone,
    String firstname,
    String lastname,
    int stateId,
    int cityid,
    String password,
    String passwordconfirmation,
  ) async {
    try {
      isLoading.value = true;
      bool success = await _authService.signup(
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        stateId: stateId,
        cityid: cityid,
        password: password,
        passwordconfirmation: passwordconfirmation,
      );
      if (success) {
        isLoading.value = false;
        Get.snackbar(
          'Your information accepted'.tr(),
          'you will resive a code message'.tr(),
        );
        Get.toNamed(RoutingManager.verifyScr, arguments: phone);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Signup Failed'.tr(), e.toString().tr());
    }
  }

  //---------------------logout--------------------------//
  Future<void> logout() async {
    try {
      isLoading.value = true;
      bool success = await _authService.logout();
      if (success) {
        isLoading.value = false;
        Get.snackbar('Log out'.tr(), 'You are logged out'.tr());
        Get.offNamed(RoutingManager.loginScr);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Log out Failed'.tr(), e.toString().tr());
    }
  }

  //------------ForgotPassword-------------//
  Future<void> forgotPassword(String phone) async {
    try {
      isLoading.value = true;
      bool success = await _authService.forgotPassword(phone: phone);
      if (success) {
        isLoading.value = false;
        Get.snackbar(
          'Reset password code sent successfully'.tr(),
          'you will resive a code message'.tr(),
        );
        Get.toNamed(RoutingManager.resetPassword, arguments: phone);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error'.tr(), e.toString().tr());
    }
  }

  //------------resetpassword-------------//
  Future<void> resetpassword(
    String phone,
    String password,
    String passwordconfirmation,
  ) async {
    try {
      isLoading.value = true;
      bool success = await _authService.resetpassword(
        phone: phone,
        password: password,
        passwordconfirmation: passwordconfirmation,
      );
      if (success) {
        isLoading.value = false;
        Get.snackbar('Reset password successfully'.tr(), 'Log in again'.tr());
        Get.offAllNamed(RoutingManager.loginScr);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error'.tr(), e.toString().tr());
    }
  }

  //---------------------------updateProfile------------------------//
  Future<void> updateProfile(
    String fName,
    String lName,
    String phone,
    int cityId,
  ) async {
    try {
      isLoading.value = true;
      User? updatedUser = await _authService.updateProfile(
        firstName: fName,
        lastName: lName,
        cityid: cityId,
        imageFile: settingsController.imageFile.value,
      );
      if (updatedUser != null) {
        box.write('user_info', updatedUser.toJson());

        currentUser.value = updatedUser;

        isLoading.value = false;
        Get.snackbar('Update Profile'.tr(), 'Updated successfully'.tr());
        Get.offNamed(RoutingManager.superHome);
      } else {
        Get.snackbar('Error'.tr(), 'Something went wrong'.tr());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error'.tr(), e.toString().tr());
    }
  }

  //------------------loadProfile---------------------------//

  void loadUserData() {
    var storedUser = box.read('user_info');
    if (storedUser != null) {
      currentUser.value = User.fromJson(storedUser);
    }
  }

  Future<void> changePassword(
    String oldPassword,
    String newPassword,
    String newPasswordconfirmation,
  ) async {
    try {
      isLoading.value = true;
      bool success = await _authService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordconfirmation: newPasswordconfirmation,
      );
      if (success) {
        isLoading.value = false;
        Get.snackbar(
          'Change Password'.tr(),
          'Password Changed successfully'.tr(),
        );
        Get.offNamed(RoutingManager.superHome);
      } else {
        Get.snackbar('Error'.tr(), 'Unauthenticated'.tr());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error'.tr(), e.toString().tr());
    }
  }

  // -----------------validators-----------------//
  FormFieldValidator<String> instagramValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill out this field'.tr();
      }
      final uri = Uri.tryParse(value);

      if (uri == null || !uri.isAbsolute || !value.contains("instagram.com")) {
        return 'Please enter a valid Instagram link'.tr();
      }

      return null;
    };
  }

  FormFieldValidator<String> facebookValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill out this field'.tr();
      }

      final uri = Uri.tryParse(value);

      if (uri == null || !uri.isAbsolute || !value.contains("facebook.com")) {
        return 'Please enter a valid Facebook link'.tr();
      }

      return null;
    };
  }

  FormFieldValidator<String> digitsOnlyValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill out this field'.tr();
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'Only digits are allowed'.tr();
      }
      return null;
    };
  }

  FormFieldValidator<String> requiredFieldValidator(String message) {
    return (value) {
      if (value == null || value.isEmpty) {
        return message.tr();
      }
      return null;
    };
  }

  FormFieldValidator<String> phoneValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill out this field'.tr();
      } else if (value.length != 10) {
        return 'Phone number must be 10 digits'.tr();
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'Only digits are allowed'.tr();
      } else if (!value.startsWith('09')) {
        return 'Phone number must start with 09'.tr();
      }
      return null;
    };
  }

  FormFieldValidator<String> validatePassword() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill out this field'.tr();
      }
      if (value.length < 8) {
        return 'you need to have more than 8 characters'.tr();
      }
      return null;
    };
  }

  FormFieldValidator<String> confirmPasswordValidator(
    TextEditingController passController,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill out this field'.tr();
      }
      if (passController.text != value) {
        return 'Password do not match'.tr();
      }
      return null;
    };
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }
}
