import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_container.dart';
import 'package:service_provider/common/widgets/app_container2.dart';
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
import 'package:service_provider/features/category/data_layer/models/category_model.dart';
import 'package:service_provider/features/serviceproviders/business_logic_layer/providers_controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final CategoryController categoryController = Get.put(CategoryController());
  final ProviderController providerController = Get.put(ProviderController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CategoryModel category = Get.arguments;
    categoryController.loadSubCategories(category.id);

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
                            category.name.tr(),
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
            child: Form(
              key: formKey,
              child: Column(
                spacing: 24,
                children: [
                  AppSearchfiled(
                    controller: categoryController.subSearchController,
                    onChanged: (value) {
                      categoryController.searchSubCategories(
                        category.id,
                        value,
                      );
                    },
                    suffixIcon: SizedBox(
                      width: 82,
                      child: Row(
                        children: [
                          AppShowmodalbottomsheet(
                            height: 378,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
                            },
                          ),
                          SvgPicture.asset(AppIcon.sort),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (categoryController.isLoadingSub.value) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      height: 89,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: categoryController.subCategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var sub = categoryController.subCategories[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 13),

                            child: GestureDetector(
                              onTap: () =>
                                  categoryController
                                          .selectedSubCategoryIndex
                                          .value =
                                      index,
                              child: Obx(() {
                                bool isSelected =
                                    categoryController
                                        .selectedSubCategoryIndex
                                        .value ==
                                    index;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 63,
                                        width: 63,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColor.foundationSeconday
                                              : AppColor.foundationTertiary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: SvgPicture.string(
                                            sub.svgImage,
                                            colorFilter: ColorFilter.mode(
                                              isSelected
                                                  ? AppColor.secondaryColor_400
                                                  : AppColor.gray2,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      AppTextStyle.lato4(
                                        sub.name.tr(),
                                        isSelected
                                            ? AppColor.secondaryColor_400
                                            : const Color(0XFFBFCBE3),
                                        14,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    );
                  }),

                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final provider = providerController.providersList[index];
                      return AppContainer2(
                        image: AssetImage(
                          'assets/images/617208729109e2baa79842a93a0e02e1cc407cff.jpg',
                        ),
                        widget: AppTextStyle.lato4(
                          'Rossie’s',
                          Color(0xFF2C371F),
                          22,
                        ),
                        widget2: AppTextStyle.lato(
                          '${2500}\tViews'.tr(),
                          Color(0XFF717171),
                        ),
                        widget3: InkWell(
                          onTap: () {
                            providerController.selectedProvider.value =
                                provider;
                            Get.toNamed(RoutingManager.providerdetailScr);
                          },
                          child: SvgPicture.asset(
                            AppIcon.angle,
                            height: 38,
                            width: 38,
                          ),
                        ),
                        child: Row(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: provider.tags.take(3).map((tag) {
                            return AppContainer(
                              height: 20,
                              width: 60,
                              text: '#$tag'.tr(),
                              borderRadius: BorderRadius.circular(2),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
