// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_phone_input_box.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';

class ForgetpasswordScreen extends StatelessWidget {
  ForgetpasswordScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phonecontroller = TextEditingController();
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
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(AppIcon.frame),
                      ),

                      AppTextStyle.cairo2(
                        'Forget Password'.tr(),
                        AppColor.purple_50,
                      ),
                      AppTextStyle.lato4(
                        'Enter your phone number to receive the code'.tr(),
                        AppColor.purple_50,
                        14,
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
                  children: [
                    AppPhoneInputBox(
                      textInputAction: TextInputAction.next,
                      controller: phonecontroller,
                      validator: authController.phoneValidator(),
                    ),
                    SizedBox(height: 32),
                    Obx(() {
                      return authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : AppElevatedbutton(
                              backgroundColor: AppColor.green_500,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  authController.forgotPassword(
                                    phonecontroller.text,
                                  );
                                }
                              },
                              title: 'Send Code'.tr(),
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
