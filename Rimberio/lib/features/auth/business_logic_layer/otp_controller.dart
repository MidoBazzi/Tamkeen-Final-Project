import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/data_layer/models/user_model.dart';
import 'package:service_provider/features/auth/data_layer/services/auth_service.dart';

class OtpController extends GetxController {
  RxInt seconds = 60.obs;
  final AuthService _authService = AuthService();
  RxBool isLoading = false.obs;
  RxBool canResend = false.obs;
  bool isFromRegester = true;
  Timer? timer;

  Rx<User?> currentUser = Rx<User?>(null);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    startTimer();
    loadUserData();
  }

  Future<void> otp(String phone, String otp, int forVerifiyAccount) async {
    try {
      isLoading.value = true;
      bool success = await _authService.otp(
        phone: phone,
        code: otp,
        forVerifiyAccount: forVerifiyAccount,
      );
      if (success) {
        isLoading.value = false;
        Get.snackbar('Verified successfuly'.tr(), 'Welcome!'.tr());
        loadUserData();
        Get.offNamed(RoutingManager.loginScr);
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Failed'.tr(), e.toString().tr());
    }
  }

  void startTimer() {
    canResend.value = false;
    seconds.value = 60;

    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
        canResend.value = true;
      } else {
        seconds.value--;
      }
    });
  }

  String get timeText {
    final s = seconds.value;
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  void resendCode(String phoneNumber) {
    if (!canResend.value) return;

    startTimer();
  }

  void loadUserData() {
    var storedUser = box.read('user_info');
    if (storedUser != null) {
      currentUser.value = User.fromJson(storedUser);
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
