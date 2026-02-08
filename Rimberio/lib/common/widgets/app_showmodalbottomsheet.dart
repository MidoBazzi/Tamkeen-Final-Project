// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_dropdownbuttonfiled.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';

class AppShowmodalbottomsheet extends StatelessWidget {
  AppShowmodalbottomsheet({
    super.key,
    this.widget,
    this.widget2,
    required this.onPressed,
    required this.height,
    this.widget3,
    this.widget4,
  });
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final Widget? widget;
  final Widget? widget2;
  final double height;
  final Widget? widget3;
  final Widget? widget4;
  final void Function() onPressed;
  int selectedStateId = 1;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 5,
                children: [
                  SizedBox(height: 15),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          size: 30,
                          Icons.close,
                          color: Color(0XFFB0B0B0),
                        ),
                      ),
                      AppTextStyle.lato4('Filters'.tr(), Color(0xFF000000), 22),
                      TextButton(
                        onPressed: () {},
                        child: AppTextStyle.lato2(
                          'Reset'.tr(),
                          AppColor.secondaryColor_400,
                        ),
                      ),
                    ],
                  ),
                  widget3 ?? SizedBox(height: 0),
                  widget ?? SizedBox(height: 0),
                  widget2 ?? SizedBox(height: 0),
                  widget4 ?? SizedBox(height: 0),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: AppTextStyle.lato2('State'.tr(), Colors.black),
                      ),

                      Expanded(
                        child: AppTextStyle.lato2('City'.tr(), Colors.black),
                      ),
                    ],
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
                            selectedStateId = int.parse(value!);
                            authController.loadCities(selectedStateId);
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
                            if (value != null) {
                              selectedStateId = int.parse(value);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 9),
                  Row(
                    children: [AppTextStyle.lato2('Tags'.tr(), Colors.black)],
                  ),
                  //-------------------------------------------------
                  AppDropdownbuttonfiled(
                    items: homeController.tags.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.name.toString(),
                        child: Text(
                          item.name.toString(),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF222B18),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0.18,
                            letterSpacing: 3,
                          ),
                        ),
                      );
                    }).toList(),
                    icon: Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColor.secondaryColor_400,
                      ),
                    ),
                    validator: authController.requiredFieldValidator(
                      'Please select a Tags'.tr(),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: SvgPicture.asset(AppIcon.tags),
                    ),
                    hintText: 'None'.tr(),
                    borderRadius: BorderRadius.circular(4),
                    height: 47,
                    width: MediaQuery.of(context).size.width * 0.99,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 24),
                  AppElevatedbutton(
                    backgroundColor: AppColor.green_500,
                    onPressed: onPressed,
                    title: 'Apply Filters (2)'.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      icon: SvgPicture.asset(AppIcon.ser2),
    );
  }
}
