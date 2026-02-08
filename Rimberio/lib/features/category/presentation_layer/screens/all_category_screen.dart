// ignore_for_file: unused_import, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart'
    hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_dropdownbuttonfiled.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_searchfiled.dart';
import 'package:service_provider/common/widgets/app_showmodalbottomsheet.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/category/business_logic_layer/category_controller.dart';

class AllCategoryScreen extends StatelessWidget {
  AllCategoryScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final CategoryController categoryController = Get.put(CategoryController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  padding: EdgeInsets.symmetric(horizontal: 13),
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
                            'All Categories'.tr(),
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
            top: MediaQuery.of(context).size.height * 0.137,
            child: Column(
              spacing: 32,
              children: [
                AppSearchfiled(
                  controller: categoryController.searchController,
                  onChanged: (value) {
                    categoryController.searchCategories(value);
                  },
                  suffixIcon: AppShowmodalbottomsheet(
                    height: 481,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    widget3: SizedBox(height: 9),
                    widget: Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: AppTextStyle.lato2(
                            'Category'.tr(),
                            Colors.black,
                          ),
                        ),
                        Expanded(
                          child: AppTextStyle.lato2(
                            'Sub Category'.tr(),
                            Colors.black,
                          ),
                        ),
                      ],
                    ),
                    //-----------------------------
                    widget2: Row(
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
                    widget4: SizedBox(height: 9),
                  ),
                ),

                Obx(
                  () => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: categoryController.categories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var category = categoryController.categories[index];
                      return Column(
                        children: [
                          Container(
                            height: 63,
                            width: 63,
                            decoration: BoxDecoration(
                              color: AppColor.foundationTertiary,
                              borderRadius: BorderRadius.circular(29.5),
                            ),
                            child: IconButton(
                              onPressed: () => categoryController
                                  .navigateBasedOnCategory(category),
                              icon: SvgPicture.string(category.svgImage),
                            ),
                          ),
                          AppTextStyle.lato4(
                            category.name,
                            Color(0XFFBFCBE3),
                            14,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
