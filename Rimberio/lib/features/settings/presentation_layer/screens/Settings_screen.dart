// ignore_for_file: file_names, deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_container3.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton2.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_url_launcher.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/Settings/presentation_layer/widgets/custom_row.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';
import 'package:service_provider/features/settings/business_logic_layer/settings_controller.dart';
import 'package:service_provider/features/settings/presentation_layer/widgets/custom_showbottomsheet.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final SettingsController settingsController = Get.put(SettingsController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    String currentLang = context.locale.languageCode == "en"
        ? "English"
        : "العربية";
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.publicImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              homeController.selectedindex.value = 3;
                            },
                            child: SvgPicture.asset(AppIcon.back_out),
                          ),
                          AppTextStyle.lato4(
                            'Settings Page'.tr(),
                            Color(0xFFFBFCFE),
                            24,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RoutingManager.notificationScr);
                            },
                            child: SvgPicture.asset(AppIcon.notification),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.068,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppPositioned(
            padding: EdgeInsets.symmetric(vertical: 64),
            top: MediaQuery.of(context).size.height * 0.199,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Obx(
                    () => AppTextStyle.lato4(
                      authController.currentUser.value != null
                          ? "${authController.currentUser.value!.first_name} ${authController.currentUser.value!.last_name}"
                          : 'Guest User'.tr(),
                      Color(0xFF000000),
                      24,
                    ),
                  ),
                  Obx(
                    () => AppTextStyle.lato4(
                      authController.currentUser.value != null
                          ? "${authController.currentUser.value!.cityName}, ${authController.currentUser.value!.stateName}"
                          : 'Location not set'.tr(),
                      Color(0xFF222B18),
                      14,
                    ),
                  ),
                  AppElevatedbutton2(
                    borderRadius: BorderRadiusGeometry.circular(7),
                    width: MediaQuery.of(context).size.width * 0.41,
                    child: AppTextStyle.lato2(
                      'Edit Profile'.tr(),
                      AppColor.secondaryColor_400,
                    ),
                    onPressed: () {
                      Get.toNamed(RoutingManager.editprofileScr);
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      AppTextStyle.lato4(
                        'About The App'.tr(),
                        Color(0xFF5A5A5A),
                        22,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutingManager.privacyScr);
                    },
                    child: CustomRow(
                      widget: SvgPicture.asset(AppIcon.terms),
                      text: 'Privacy Policy'.tr(),
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutingManager.providerScr);
                    },
                    child: CustomRow(
                      widget: SvgPicture.asset(
                        AppIcon.customer,
                        color: AppColor.secondaryColor_400,
                      ),
                      text: 'Become A Provider'.tr(),
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutingManager.contactUsScr);
                    },
                    child: CustomRow(
                      widget: SvgPicture.asset(AppIcon.headset),
                      text: 'Contact Us'.tr(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(() {
                    return CustomShowbottomsheet(
                      height: 450,
                      text: 'About Us'.tr(),
                      widget: settingsController.isLoading.value
                          ? const CircularProgressIndicator()
                          : RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                  color: Color(0xFF111B2F),
                                ),
                                children: [
                                  TextSpan(
                                    text: settingsController
                                        .aboutUsContent
                                        .value
                                        .tr(),
                                  ),
                                  TextSpan(
                                    text: 'View More'.tr(),
                                    style: TextStyle(color: Color(0XFF8C3D00)),
                                  ),
                                ],
                              ),
                            ),
                      widget2: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppContainer3(
                            onTap: () => AppUrlLauncher.launchStaticUrl(
                              settingsController.facebookUrl.value,
                              'URL',
                            ),
                            width: 103,
                            text2: AppIcon.facebook,
                            text: 'Facebook'.tr(),
                          ),
                          AppContainer3(
                            onTap: () => AppUrlLauncher.launchStaticUrl(
                              settingsController.instagramUrl.value,
                              'URL',
                            ),
                            width: 104,
                            text2: AppIcon.instagram,
                            text: 'Instagram'.tr(),
                          ),
                          AppContainer3(
                            onTap: () => AppUrlLauncher.launchStaticUrl(
                              settingsController.whatsappNumber.value,
                              'URL',
                            ),
                            width: 107,
                            text2: AppIcon.whatsapp,
                            text: 'Whats App'.tr(),
                          ),
                        ],
                      ),
                      widget3: AppContainer3(
                        onTap: () => AppUrlLauncher.launchStaticUrl(
                          settingsController.phoneNumber.value,
                          'PHONE',
                        ),
                        width: 140,
                        text2: AppIcon.call,
                        text: 'Phone number'.tr(),
                      ),
                      child: CustomRow(
                        widget: SvgPicture.asset(AppIcon.comment),
                        text: 'About Us'.tr(),
                      ),
                    );
                  }),
                  Divider(color: Color(0XFFDBE5FA)),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      AppTextStyle.lato4(
                        'Settings'.tr(),
                        Color(0xFF5A5A5A),
                        22,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomShowbottomsheet(
                    height: 250,
                    text: 'Language'.tr(),
                    widget: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.setLocale(Locale("en"));
                          Get.updateLocale(Locale("en"));
                          Get.offAllNamed(RoutingManager.splashScr);
                        },
                        splashColor: Color(0xFFFFF1E6),
                        highlightColor: Color(0xFFFFF1E6),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: AppTextStyle.lato2(
                            'English'.tr(),
                            const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    widget2: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.setLocale(Locale("ar"));
                          Get.updateLocale(Locale("ar"));
                          Get.offAllNamed(RoutingManager.splashScr);
                        },
                        splashColor: Color(0xFFFFF1E6),
                        highlightColor: Color(0xFFFFF1E6),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: AppTextStyle.lato2(
                            'Arabic'.tr(),
                            const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    child: CustomRow(
                      widget: SvgPicture.asset(AppIcon.lang),
                      text: 'Language'.tr(),
                      widget2: AppTextStyle.lato2(
                        currentLang,
                        Color(0xFF000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutingManager.changepasswordScr);
                    },
                    child: CustomRow(
                      widget: SvgPicture.asset(
                        AppIcon.lock,
                        color: AppColor.secondaryColor_400,
                      ),
                      text: 'Change Password'.tr(),
                    ),
                  ),
                  Divider(color: Color(0XFFDBE5FA)),
                  SizedBox(height: 16),
                  Obx(() {
                    return authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : AppElevatedbutton(
                            onPressed: () {
                              authController.logout();
                            },
                            title: 'Log out'.tr(),
                            backgroundColor: Color(0xFF222B18),
                          );
                  }),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 460),
              child: Obx(() {
                final imageUrl = authController.currentUser.value?.image;

                final localFile = settingsController.imageFile.value;

                return Container(
                  height: 122,
                  width: 122,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: localFile != null
                          ? FileImage(localFile) as ImageProvider
                          : (imageUrl != null && imageUrl.isNotEmpty)
                          ? NetworkImage(imageUrl)
                          : AssetImage(AppImage.person),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                        offset: const Offset(1, 1),
                        color: const Color(0xFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
