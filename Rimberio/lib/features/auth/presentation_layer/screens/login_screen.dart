// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton2.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_textformfiled.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/common/widgets/app_phone_input_box.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
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
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle.cairo2(
                        'Log in to your Account'.tr(),
                        AppColor.purple_50,
                      ),
                      AppTextStyle.cairo(
                        'Welcome back! Log in to continue'.tr(),
                        AppColor.purple_50,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppPositioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AppPhoneInputBox(
                      textInputAction: TextInputAction.next,
                      controller: phonecontroller,
                      validator: authController.phoneValidator(),
                    ),
                    SizedBox(height: 32),
                    Obx(() {
                      return AppTextformfiled(
                        borderRadius: BorderRadius.circular(7),
                        validator: authController.requiredFieldValidator(
                          'Please fill out this field',
                        ),
                        obscureText: authController.isobscure.value,
                        controller: passcontroller,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(
                            AppIcon.lock,
                            color: AppColor.secondaryColor_400,
                          ),
                        ),
                        hintText: AppTextStyle.lato(
                          'Write Password...'.tr(),
                          AppColor.gray,
                        ),
                        textInputAction: TextInputAction.done,
                        suffixicon: InkWell(
                          onTap: () {
                            authController.isobscure.value =
                                !authController.isobscure.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              authController.isobscure.value
                                  ? AppIcon.eyesClosed
                                  : AppIcon.eyesOpen,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 32),
                    Obx(() {
                      return authController.isLoading.value
                          ? CircularProgressIndicator()
                          : AppElevatedbutton(
                              backgroundColor: AppColor.green_500,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  authController.login(
                                    phonecontroller.text,
                                    passcontroller.text,
                                  );
                                }
                              },
                              title: 'Login'.tr(),
                            );
                    }),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(RoutingManager.forgetpassword);
                          },
                          child: AppTextStyle.lato3(
                            'Forgot Password?'.tr(),
                            AppColor.secondaryColor_400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 1,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColor.grayScaleLessDark,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Or '.tr(),
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.grayScaleMostDark,
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Enter as a Guest '.tr(),
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.green_500,
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColor.grayScaleLessDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    AppElevatedbutton2(
                      borderRadius: BorderRadiusGeometry.circular(7),
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: AppTextStyle.lato2(
                        'Become a Provider'.tr(),
                        AppColor.secondaryColor_400,
                      ),
                      onPressed: () {
                        Get.toNamed(RoutingManager.providerScr);
                      },
                    ),
                    SizedBox(height: 24),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 3,
                          children: [
                            Spacer(),
                            AppTextStyle.lato4(
                              'Don’t have an account ?'.tr(),
                              Color(0xFF7F7F7F),
                              14,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RoutingManager.registerScr);
                              },
                              child: AppTextStyle.lato5('Click here'.tr()),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
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
