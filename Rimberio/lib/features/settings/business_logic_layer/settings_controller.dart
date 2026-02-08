// ignore_for_file: avoid_print

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/features/settings/data_layer/services/settings_service.dart';

class SettingsController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);

  final SettingsService settingsService = SettingsService();
  RxBool isLoading = false.obs;
  RxList<Map<String, String>> privacyItems = <Map<String, String>>[].obs;
  RxString aboutUsContent = "".obs;
  RxString facebookUrl = "".obs;
  RxString instagramUrl = "".obs;
  RxString whatsappNumber = "".obs;
  RxString phoneNumber = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadPrivacyPage();
    loadAboutUsPage();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> sendContactMessage({
    required String firstName,
    required String lastName,
    required String phone,
    required String message,
  }) async {
    try {
      isLoading.value = true;
      bool success = await settingsService.contactUs(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        message: message,
      );

      if (success) {
        isLoading.value = false;
        Get.back();
        Get.snackbar(
          'Success'.tr(),
          'Your message has been sent successfully'.tr(),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error'.tr(), e.toString().tr());
    }
  }

  Future<void> loadPrivacyPage() async {
    isLoading.value = true;

    try {
      final pages = await settingsService.getPages();
      final privacyPage = pages.firstWhere((p) => p.title == 'privacy');

      privacyItems.value = parsePrivacyContent(privacyPage.content);
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAboutUsPage() async {
    isLoading.value = true;
    try {
      final pages = await settingsService.getPages();
      final aboutPage = pages.firstWhere(
        (p) => p.title.toLowerCase().contains('about'),
      );

      String rawContent = aboutPage.content;

      facebookUrl.value = extractUrl(
        rawContent,
        r'https://www.facebook.com/[^\s<]+',
      );
      instagramUrl.value = extractUrl(
        rawContent,
        r'https://www.instagram.com/[^\s<]+',
      );

      String rawNumber = extractUrl(rawContent, r'\+963[\s0-9]+');
      String cleanNumber = cleanPhoneNumber(rawNumber);

      whatsappNumber.value = 'https://wa.me/$cleanNumber';

      phoneNumber.value = cleanNumber;

      String cleanText = rawContent
          .replaceAll(RegExp(r'https?://[^\s<]+'), '')
          .replaceAll(RegExp(r'\+963[\s0-9]+'), '')
          .replaceAll('&nbsp;', ' ')
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .trim();

      aboutUsContent.value = cleanText;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\s+'), '');
  }

  String extractUrl(String text, String pattern) {
    final regExp = RegExp(pattern);
    final match = regExp.firstMatch(text);
    return match != null ? match.group(0)! : "";
  }

  List<Map<String, String>> parsePrivacyContent(String html) {
    final RegExp regExp = RegExp(
      r'<h3>(.*?)<\/h3>\s*<p>(.*?)<\/p>',
      dotAll: true,
    );

    final matches = regExp.allMatches(html);

    return matches.map((m) {
      return {'title': m.group(1)!.trim(), 'description': m.group(2)!.trim()};
    }).toList();
  }
}
