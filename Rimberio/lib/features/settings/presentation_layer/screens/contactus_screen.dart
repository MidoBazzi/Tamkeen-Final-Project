import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_phone_input_box.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_textformfiled.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/settings/business_logic_layer/settings_controller.dart';

class ContactusScreen extends StatelessWidget {
  ContactusScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final SettingsController settController = Get.put(SettingsController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                              Get.back();
                            },
                            child: SvgPicture.asset(AppIcon.back_out),
                          ),
                          AppTextStyle.lato4(
                            'Contact Us'.tr(),
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
            top: MediaQuery.of(context).size.height * 0.253,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 24,
                  children: [
                    AppTextformfiled(
                      validator: authController.requiredFieldValidator(
                        'Please fill out this field',
                      ),
                      controller: namecontroller,
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.92,
                      keyboardType: TextInputType.name,
                      prefixIcon: Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                        child: SvgPicture.asset(AppIcon.user),
                      ),
                      hintText: AppTextStyle.lato(
                        'First Name'.tr(),
                        AppColor.gray,
                      ),
                      textInputAction: TextInputAction.next,
                      borderRadius: BorderRadius.circular(4),
                    ),

                    AppTextformfiled(
                      validator: authController.requiredFieldValidator(
                        'Please fill out this field',
                      ),
                      controller: lastnamecontroller,
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.92,
                      keyboardType: TextInputType.name,
                      prefixIcon: Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                        child: SvgPicture.asset(AppIcon.user),
                      ),
                      hintText: AppTextStyle.lato(
                        'Last Name'.tr(),
                        AppColor.gray,
                      ),
                      textInputAction: TextInputAction.next,
                      borderRadius: BorderRadius.circular(4),
                    ),

                    AppPhoneInputBox(
                      textInputAction: TextInputAction.next,
                      controller: phonecontroller,
                      validator: authController.phoneValidator(),
                    ),

                    AppTextformfiled(
                      controller: descriptionController,
                      validator: authController.requiredFieldValidator(
                        'Please fill out this field',
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      keyboardType: TextInputType.text,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          bottom: MediaQuery.of(context).size.width * 0.16,
                        ),
                        child: SvgPicture.asset(AppIcon.vector),
                      ),
                      hintText: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.16,
                        ),
                        child: AppTextStyle.lato(
                          'Description...'.tr(),
                          AppColor.gray,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      borderRadius: BorderRadius.circular(4),
                    ),

                    Obx(() {
                      return settController.isLoading.value
                          ? const CircularProgressIndicator()
                          : AppElevatedbutton(
                              backgroundColor: const Color(0xFF222B18),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  settController.sendContactMessage(
                                    firstName: namecontroller.text,
                                    lastName: lastnamecontroller.text,
                                    phone: phonecontroller.text,
                                    message: descriptionController.text,
                                  );
                                }
                              },
                              title: 'Send'.tr(),
                            );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
