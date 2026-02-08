// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_dropdownbuttonfiled.dart';
import 'package:service_provider/common/widgets/app_elevatedbutton.dart';
import 'package:service_provider/common/widgets/app_link_input.dart';
import 'package:service_provider/common/widgets/app_phone_input_box.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_textformfiled.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/auth/business_logic_layer/serviceproviders_controller.dart';
import 'package:service_provider/features/category/business_logic_layer/category_controller.dart';

class ProviderScreen extends StatelessWidget {
  ProviderScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final ServiceprovidersController providerController = Get.put(
    ServiceprovidersController(),
  );
  final CategoryController categoryController = Get.put(CategoryController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController shopnamecontroller = TextEditingController();
  final TextEditingController discriptioncontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController wlinkcontroller = TextEditingController();
  final TextEditingController inlinkcontroller = TextEditingController();
  final TextEditingController faclinkcontroller = TextEditingController();
  int selectedStateId = 1;
  int selectedCityId = 1;
  int selectedCategory = 1;
  int selectedSubCategory = 1;
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                        'Become A Provider'.tr(),
                        AppColor.purple_50,
                      ),
                      AppTextStyle.lato4(
                        'Fill This Form To Send A Request'.tr(),
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
                  spacing: 24,
                  children: [
                    Obx(
                      () => Container(
                        height: 94,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD2B0),
                          borderRadius: BorderRadius.circular(10),
                          image: authController.imageFile.value != null
                              ? DecorationImage(
                                  image: FileImage(
                                    authController.imageFile.value!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: authController.imageFile.value == null
                            ? IconButton(
                                onPressed: () {
                                  authController.pickImage();
                                },
                                icon: SvgPicture.asset(AppIcon.camera),
                              )
                            : SizedBox.shrink(),
                      ),
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
                            child: SvgPicture.asset(
                              AppIcon.user,
                              color: AppColor.secondaryColor_400,
                            ),
                          ),
                          hintText: AppTextStyle.lato(
                            'Provider Name'.tr(),
                            AppColor.gray,
                          ),
                          textInputAction: TextInputAction.next,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        AppTextformfiled(
                          validator: authController.requiredFieldValidator(
                            'Please fill out this field',
                          ),
                          controller: shopnamecontroller,
                          height: 48,
                          width: MediaQuery.of(context).size.width * 0.44,
                          keyboardType: TextInputType.name,
                          prefixIcon: Padding(
                            padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              AppIcon.store,
                              color: AppColor.secondaryColor_400,
                            ),
                          ),
                          hintText: AppTextStyle.lato(
                            'Shop Name'.tr(),
                            AppColor.gray,
                          ),
                          textInputAction: TextInputAction.next,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    AppTextformfiled(
                      controller: discriptioncontroller,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => AppDropdownbuttonfiled(
                            items: categoryController.categories.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.id.toString(),
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
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.secondaryColor_400,
                              ),
                            ),
                            validator: authController.requiredFieldValidator(
                              'Please select a Category',
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              child: SvgPicture.asset(AppIcon.category),
                            ),
                            hintText: 'None'.tr(),
                            borderRadius: BorderRadius.circular(4),
                            height: MediaQuery.of(context).size.height * 0.052,
                            width: MediaQuery.of(context).size.width * 0.44,
                            onChanged: (value) {
                              selectedCategory = int.parse(value!);
                              categoryController.loadSubCategories(
                                selectedCategory,
                              );
                            },
                          ),
                        ),

                        Obx(
                          () => AppDropdownbuttonfiled(
                            items: categoryController.subCategories.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.id.toString(),
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
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.secondaryColor_400,
                              ),
                            ),
                            validator: authController.requiredFieldValidator(
                              'Please select a Sub..',
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                vertical: 11,
                              ),
                              child: SvgPicture.asset(AppIcon.category),
                            ),
                            hintText: 'None'.tr(),
                            borderRadius: BorderRadius.circular(4),
                            height: MediaQuery.of(context).size.height * 0.052,
                            width: MediaQuery.of(context).size.width * 0.44,
                            onChanged: (value) {
                              selectedSubCategory = int.parse(value!);
                              categoryController.loadSubCategories(
                                selectedSubCategory,
                              );
                            },
                          ),
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
                    AppLinkInput(
                      keyboardType: TextInputType.phone,
                      hintText: 'Write Your Whatsapp Number'.tr(),
                      widget: SvgPicture.asset(AppIcon.whatsapp),
                      widget2: SizedBox(width: 5),
                      controller: wlinkcontroller,
                      validator: authController.digitsOnlyValidator(),
                      textInputAction: TextInputAction.next,
                    ),
                    AppLinkInput(
                      keyboardType: TextInputType.url,
                      hintText: 'Write your Instagram link'.tr(),
                      widget: SvgPicture.asset(AppIcon.instagram),
                      controller: inlinkcontroller,
                      validator: authController.instagramValidator(),
                      textInputAction: TextInputAction.next,
                    ),
                    AppLinkInput(
                      keyboardType: TextInputType.url,
                      hintText: 'Write your facebook link'.tr(),
                      widget: SvgPicture.asset(AppIcon.facebook),
                      controller: faclinkcontroller,
                      validator: authController.facebookValidator(),
                      textInputAction: TextInputAction.done,
                    ),
                    Obx(() {
                      return providerController.isLoading.value
                          ? const CircularProgressIndicator()
                          : AppElevatedbutton(
                              backgroundColor: AppColor.green_500,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  providerController.providerRequest(
                                    phonecontroller.text,
                                    namecontroller.text,
                                    discriptioncontroller.text,
                                    discriptioncontroller.text,
                                    faclinkcontroller.text,
                                    wlinkcontroller.text,
                                    inlinkcontroller.text,
                                    selectedStateId,
                                    selectedCategory,
                                    selectedSubCategory,
                                    3, //frombackend keep it
                                    2, //frombackend keep it
                                    1, //frombackend keep it
                                    selectedCityId,
                                    shopnamecontroller.text,
                                    shopnamecontroller.text,
                                  );
                                }
                              },
                              title: 'Send Request'.tr(),
                            );
                    }),
                    SizedBox(height: 16),
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
