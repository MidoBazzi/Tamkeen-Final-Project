// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_dropdownbuttonfiled.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_phone_input_box.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_textformfiled.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';

class RegisterScr extends StatelessWidget {
  RegisterScr({super.key, this.phone});

  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController passcontroller2 = TextEditingController();
  final String? phone;
  int selectedStateId = 1;
  int selectedCityId = 1;
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
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(AppIcon.frame),
                      ),
                      AppTextStyle.cairo2(
                        'Sign up to create account'.tr(),
                        AppColor.purple_50,
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
                    spacing: 24,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextformfiled(
                            validator: authController.requiredFieldValidator(
                              'Please fill out this field',
                            ),
                            controller: namecontroller,
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.44,
                            keyboardType: TextInputType.name,
                            prefixIcon: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 12,
                              ),
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
                            width: MediaQuery.of(context).size.width * 0.44,
                            keyboardType: TextInputType.name,
                            prefixIcon: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 12,
                              ),
                              child: SvgPicture.asset(AppIcon.user),
                            ),
                            hintText: AppTextStyle.lato(
                              'Last Name'.tr(),
                              AppColor.gray,
                            ),
                            textInputAction: TextInputAction.next,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      AppPhoneInputBox(
                        textInputAction: TextInputAction.next,
                        controller: phonecontroller,
                        validator: authController.phoneValidator(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppDropdownbuttonfiled(
                            onTap: () {},
                            items: authController.states.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.stateId.toString(),
                                child: Text(
                                  item.stateName.removeAllWhitespace,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF222B18),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 0.18,
                                  ),
                                ),
                              );
                            }).toList(),
                            icon: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.secondaryColor_400,
                              ),
                            ),
                            validator: authController.requiredFieldValidator(
                              'Please select a state',
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              child: SvgPicture.asset(AppIcon.state),
                            ),
                            hintText: 'State'.tr(),
                            borderRadius: BorderRadius.circular(4),
                            height: MediaQuery.of(context).size.height * 0.052,
                            width: MediaQuery.of(context).size.width * 0.44,
                            onChanged: (value) {
                              selectedStateId = int.parse(value!);
                              authController.loadCities(selectedStateId);
                            },
                          ),
                          Obx(() {
                            return AppDropdownbuttonfiled(
                              items: authController.cities.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.cityId.toString(),
                                  child: Text(
                                    item.cityName,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF222B18),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0.18,
                                    ),
                                  ),
                                );
                              }).toList(),
                              icon: Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 8,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColor.secondaryColor_400,
                                ),
                              ),
                              validator: authController.requiredFieldValidator(
                                'Please select a city',
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsetsGeometry.symmetric(
                                  vertical: 11,
                                ),
                                child: SvgPicture.asset(AppIcon.building),
                              ),
                              hintText: 'City'.tr(),
                              borderRadius: BorderRadius.circular(4),
                              height:
                                  MediaQuery.of(context).size.height * 0.052,
                              width: MediaQuery.of(context).size.width * 0.44,
                              onChanged: (value) {
                                if (value != null) {
                                  selectedStateId = int.parse(value);
                                }
                              },
                            );
                          }),
                        ],
                      ),
                      AppTextformfiled(
                        borderRadius: BorderRadius.circular(7),
                        validator: authController.validatePassword(),
                        obscureText: authController.isobscure3.value,
                        controller: passcontroller,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(AppIcon.lock),
                        ),
                        hintText: AppTextStyle.lato(
                          'Write Password...'.tr(),
                          AppColor.gray,
                        ),
                        textInputAction: TextInputAction.done,
                        suffixicon: InkWell(
                          onTap: () {
                            authController.isobscure3.value =
                                !authController.isobscure3.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              authController.isobscure3.value
                                  ? AppIcon.eyesClosed
                                  : AppIcon.eyesOpen,
                            ),
                          ),
                        ),
                      ),
                      AppTextformfiled(
                        borderRadius: BorderRadius.circular(7),
                        validator: authController.confirmPasswordValidator(
                          passcontroller,
                        ),
                        obscureText: authController.isobscure2.value,
                        controller: passcontroller2,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),

                          child: SvgPicture.asset(AppIcon.lock),
                        ),
                        hintText: AppTextStyle.lato(
                          'Confirm Password...'.tr(),
                          AppColor.gray,
                        ),
                        textInputAction: TextInputAction.done,
                        suffixicon: InkWell(
                          onTap: () {
                            authController.isobscure2.value =
                                !authController.isobscure2.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              authController.isobscure2.value
                                  ? AppIcon.eyesClosed
                                  : AppIcon.eyesOpen,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        spacing: 3,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: InkWell(
                              splashColor: Colors.grey,
                              onTap: () {
                                authController.isChecked.toggle();
                              },
                              child: authController.isChecked.value
                                  ? SvgPicture.asset(AppIcon.clickedCheckBox)
                                  : SvgPicture.asset(AppIcon.unClickedCheckBox),
                            ),
                          ),
                          AppTextStyle.lato4(
                            'I agree with'.tr(),
                            Color(0xFF181622),
                            14,
                          ),
                          InkWell(
                            onTap: () {},
                            child: AppTextStyle.lato5('terms & policies'.tr()),
                          ),
                          Spacer(),
                        ],
                      ),
                      Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : AppElevatedbutton(
                                backgroundColor: AppColor.green_500,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (authController.isChecked.value) {
                                      authController.signup(
                                        phonecontroller.text,
                                        namecontroller.text,
                                        lastnamecontroller.text,
                                        selectedStateId,
                                        selectedCityId,
                                        passcontroller.text,
                                        passcontroller2.text,
                                      );
                                    } else {
                                      Get.snackbar(
                                        'Error'.tr(),
                                        'please Accept the terms & policies'
                                            .tr(),
                                      );
                                    }
                                  }
                                },
                                title: 'Sign Up'.tr(),
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
