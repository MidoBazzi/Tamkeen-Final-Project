// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/settings/business_logic_layer/settings_controller.dart';

class EditprofileScreen extends StatelessWidget {
  EditprofileScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final SettingsController settingsController = Get.put(SettingsController());
  final RxInt selectedStateId = 1.obs;
  final RxInt selectedCityId = 1.obs;
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
                            'Edit Profile'.tr(),
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
            top: MediaQuery.of(context).size.height * 0.166,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 24,
                  children: [
                    Stack(
                      children: [
                        Obx(
                          () => Container(
                            height: 122,
                            width: 122,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:
                                    settingsController.imageFile.value != null
                                    ? FileImage(
                                        settingsController.imageFile.value!,
                                      )
                                    : AssetImage(
                                        'assets/images/person-male-svgrepo-com.png',
                                      ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Color(0xFF000000).withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 74, top: 90),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  settingsController.pickImage();
                                },
                                icon: SvgPicture.asset(AppIcon.edit),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                          width: MediaQuery.of(context).size.width * 0.44,
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
                        Obx(
                          () => AppDropdownbuttonfiled(
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
                              selectedStateId.value = int.parse(value!);
                              authController.loadCities(selectedStateId.value);
                            },
                          ),
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
                            height: MediaQuery.of(context).size.height * 0.052,
                            width: MediaQuery.of(context).size.width * 0.44,
                            onChanged: (value) {
                              selectedCityId.value = int.parse(value!);
                            },
                          );
                        }),
                      ],
                    ),

                    Obx(() {
                      return settingsController.isLoading.value
                          ? const CircularProgressIndicator()
                          : AppElevatedbutton(
                              backgroundColor: AppColor.green_500,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  authController.updateProfile(
                                    namecontroller.text,
                                    lastnamecontroller.text,
                                    phonecontroller.text,
                                    selectedCityId.value,
                                  );
                                }
                              },
                              title: 'Save'.tr(),
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
