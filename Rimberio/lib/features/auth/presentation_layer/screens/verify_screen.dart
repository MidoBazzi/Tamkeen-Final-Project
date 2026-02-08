import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/auth/business_logic_layer/otp_controller.dart';
import 'package:service_provider/features/auth/presentation_layer/widgets/custom_pinput.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key, required this.phone});
  final String phone;
  final AuthController authController = Get.put(AuthController());
  final OtpController otpController = Get.put(OtpController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController verifycontroller = TextEditingController();

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
                        'Verify your Phone number'.tr(),
                        AppColor.purple_50,
                      ),
                      AppTextStyle.lato4(
                        'Enter the 4-digit OTP sent to : +963 $phone'.tr(),
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
            top: MediaQuery.of(context).size.height * 0.252,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomPinput(
                      controller: verifycontroller,
                      validator: authController.requiredFieldValidator(
                        'Please fill out this field',
                      ),
                    ),
                    SizedBox(height: 24),
                    Column(
                      spacing: 7,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 3,
                          children: [
                            AppTextStyle.lato4(
                              'Didn’t receive code ?'.tr(),
                              Color(0xFF7F7F7F),
                              14,
                            ),
                            Obx(() {
                              return AppTextStyle.lato4(
                                otpController.timeText,
                                AppColor.secondaryColor_400,
                                14,
                              );
                            }),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if (otpController.seconds.value == 0) {
                              otpController.startTimer();
                            } else {
                              Get.snackbar(
                                'Error'.tr(),
                                'Please Wait The timer to resend the code'.tr(),
                              );
                            }
                          },
                          child: AppTextStyle.lato4(
                            'Resend Code'.tr(),
                            AppColor.secondaryColor_400,
                            14,
                          ),
                        ),
                        SizedBox(height: 24),
                        Obx(() {
                          return authController.isLoading.value
                              ? const CircularProgressIndicator()
                              : AppElevatedbutton(
                                  backgroundColor: AppColor.green_500,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      otpController.otp(
                                        phone,
                                        verifycontroller.text,
                                        0,
                                      );
                                    }
                                  },
                                  title: 'Verify'.tr(),
                                );
                        }),
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
