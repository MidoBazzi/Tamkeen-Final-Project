// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_textformfiled.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';

class ChangepasswordScreen extends StatelessWidget {
  ChangepasswordScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasscontroller = TextEditingController();
  final TextEditingController newPasscontroller = TextEditingController();
  final TextEditingController confPasscontroller = TextEditingController();
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
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    spacing: 13,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(AppIcon.frame),
                      ),
                      AppTextStyle.cairo2(
                        'Change Password'.tr(),
                        AppColor.purple_50,
                      ),
                      AppTextStyle.lato4(
                        'Create your new password to access your account'.tr(),
                        AppColor.purple_50,
                        14,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppPositioned(
            top: MediaQuery.of(context).size.height * 0.253,
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 32,
                    children: [
                      AppTextformfiled(
                        borderRadius: BorderRadius.circular(7),
                        validator: authController.requiredFieldValidator(
                          'Please fill out this field',
                        ),
                        obscureText: authController.isobscure6.value,
                        controller: oldPasscontroller,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(
                            AppIcon.lock,
                            color: AppColor.secondaryColor_400,
                          ),
                        ),
                        hintText: AppTextStyle.lato(
                          'Old Password...'.tr(),
                          AppColor.gray,
                        ),
                        textInputAction: TextInputAction.next,
                        suffixicon: InkWell(
                          onTap: () {
                            authController.isobscure6.value =
                                !authController.isobscure6.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              authController.isobscure6.value
                                  ? AppIcon.eyesClosed
                                  : AppIcon.eyesOpen,
                            ),
                          ),
                        ),
                      ),

                      AppTextformfiled(
                        borderRadius: BorderRadius.circular(7),
                        validator: authController.requiredFieldValidator(
                          'Please fill out this field',
                        ),
                        obscureText: authController.isobscure7.value,
                        controller: newPasscontroller,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),

                          child: SvgPicture.asset(
                            AppIcon.lock,
                            color: AppColor.secondaryColor_400,
                          ),
                        ),
                        hintText: AppTextStyle.lato(
                          'New Password...'.tr(),
                          AppColor.gray,
                        ),
                        textInputAction: TextInputAction.done,
                        suffixicon: InkWell(
                          onTap: () {
                            authController.isobscure7.value =
                                !authController.isobscure7.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              authController.isobscure7.value
                                  ? AppIcon.eyesClosed
                                  : AppIcon.eyesOpen,
                            ),
                          ),
                        ),
                      ),

                      AppTextformfiled(
                        borderRadius: BorderRadius.circular(7),
                        validator: authController.confirmPasswordValidator(
                          newPasscontroller,
                        ),
                        obscureText: authController.isobscure8.value,
                        controller: confPasscontroller,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),

                          child: SvgPicture.asset(AppIcon.lock),
                        ),
                        hintText: AppTextStyle.lato(
                          'Confirm New Password...'.tr(),
                          AppColor.gray,
                        ),
                        textInputAction: TextInputAction.done,
                        suffixicon: InkWell(
                          onTap: () {
                            authController.isobscure8.value =
                                !authController.isobscure8.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              authController.isobscure8.value
                                  ? AppIcon.eyesClosed
                                  : AppIcon.eyesOpen,
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : AppElevatedbutton(
                                backgroundColor: AppColor.green_500,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.changePassword(
                                      oldPasscontroller.text,
                                      newPasscontroller.text,
                                      confPasscontroller.text,
                                    );
                                  }
                                },
                                title: 'Reset Password'.tr(),
                              );
                      }),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
