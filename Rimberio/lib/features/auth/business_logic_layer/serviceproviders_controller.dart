import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/features/auth/data_layer/services/serviceproviders_services.dart';

class ServiceprovidersController extends GetxController {
  ServiceprovidersServices _serviceprovidersServices =
      ServiceprovidersServices();
  RxBool isLoading = false.obs;

  Future<void> providerRequest(
    String phone,
    String providerName,
    String discreptionAr,
    String discreptionEn,
    String facebookLink,
    String whatsappLink,
    String instaLink,
    int stateId,
    int categoryid,
    int subCategoryid,
    int socialLinkphone,
    int socialLinkinsta,
    int socialLinkface,
    int cityid,
    String shopNameAr,
    String shopNameen,
  ) async {
    try {
      isLoading.value = true;
      bool success = await _serviceprovidersServices.becomeABrovider(
        phone: phone,
        socialLinkphone: socialLinkphone,
        providerName: providerName,
        shopNameAr: shopNameAr,
        shopNameEn: shopNameAr,
        discreptionAr: discreptionAr,
        discreptionEn: discreptionEn,
        facebookLink: facebookLink,
        socialLinkface: socialLinkface,
        whatsappLink: whatsappLink,
        instaLink: instaLink,
        socialLinkinsta: socialLinkinsta,
        stateId: stateId,
        cityid: cityid,
        categoryid: categoryid,
        subCategoryid: subCategoryid,
      );

      if (success) {
        isLoading.value = false;
        Get.snackbar(
          'Your information accepted'.tr(),
          'you are now a provider'.tr(),
        );
      } else {}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Signup Failed'.tr(), e.toString().tr());
    }
  }
}
