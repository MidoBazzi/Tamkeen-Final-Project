// ignore_for_file: deprecated_member_use, must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_container3.dart';
import 'package:service_provider/common/widgets/app_dropdownbuttonfiled.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_searchfiled.dart';
import 'package:service_provider/common/widgets/app_showmodalbottomsheet.dart';
import 'package:service_provider/common/widgets/app_url_launcher.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/auth/business_logic_layer/auth_controller.dart';
import 'package:service_provider/features/category/business_logic_layer/category_controller.dart';
import 'package:service_provider/features/governmententities/business_logic_layer/governmententities_controller.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';
import 'package:service_provider/common/widgets/app_container.dart';
import 'package:service_provider/features/offer/business_logic_layer/offers_controller.dart';
import 'package:service_provider/features/serviceproviders/business_logic_layer/providers_controller.dart';
import 'package:service_provider/features/serviceproviders/presentation_layer/screens/providerdetail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final CarouselSliderController _controller = CarouselSliderController();
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  final GovernmententitiesController govController = Get.put(
    GovernmententitiesController(),
  );
  final AuthController authController = Get.put(AuthController());
  final OffersController offersController = Get.put(OffersController());
  final ProviderController providerController = Get.put(ProviderController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedCategory = 1;
  int selectedSubCategory = 1;
  @override
  Widget build(BuildContext context) {
    govController.fetchGovEntities();
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
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            final imageUrl =
                                authController.currentUser.value?.image;
                            return CircleAvatar(
                              radius: 24.5,
                              backgroundColor: AppColor.gray,
                              backgroundImage:
                                  (imageUrl != null && imageUrl.isNotEmpty)
                                  ? NetworkImage(imageUrl) as ImageProvider
                                  : AssetImage(AppImage.person),
                            );
                          }),
                          SizedBox(width: 11),
                          Obx(() {
                            final user = authController.currentUser.value;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  user != null
                                      ? "${user.first_name} ${user.last_name}"
                                      : "Guest User",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  user != null
                                      ? "${user.cityName}, ${user.stateName}"
                                      : "Location not set",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            );
                          }),
                          Spacer(flex: 16),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RoutingManager.notificationScr);
                            },
                            child: SvgPicture.asset(AppIcon.notification),
                          ),
                        ],
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
            top: MediaQuery.of(context).size.height * 0.157,
            child: Form(
              key: formKey,
              child: Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'Lets Find The\t'.tr(),
                            style: TextStyle(color: Color(0xFF010A1C)),
                          ),
                          TextSpan(
                            text: 'Perfect\t'.tr(),
                            style: TextStyle(color: Color(0xFFFF8C33)),
                          ),
                          TextSpan(
                            text: 'Service\t'.tr(),
                            style: TextStyle(color: Color(0xFFFF8C33)),
                          ),
                          TextSpan(
                            text: 'Expert'.tr(),
                            style: TextStyle(color: Color(0xFF010A1C)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSearchfiled(
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                ),
                                child: SvgPicture.asset(AppIcon.category),
                              ),
                              hintText: 'None'.tr(),
                              borderRadius: BorderRadius.circular(4),
                              height:
                                  MediaQuery.of(context).size.height * 0.052,
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
                              items: categoryController.subCategories.map((
                                item,
                              ) {
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
                              height:
                                  MediaQuery.of(context).size.height * 0.052,
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
                  Obx(() {
                    if (homeController.isLoadingSliders.value) {
                      return Center(child: const CircularProgressIndicator());
                    }

                    if (homeController.sliders.isEmpty) {
                      return Image.asset(AppImage.per1, fit: BoxFit.cover);
                    }

                    return Column(
                      spacing: 24,
                      children: [
                        CarouselSlider(
                          carouselController: _controller,
                          items: homeController.sliders.map((slider) {
                            return Image.network(
                              slider.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 160.25,
                            viewportFraction: 0.95,
                            padEnds: false,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              homeController.currentIndex.value = index;
                            },
                          ),
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: homeController.currentIndex.value,
                          count: homeController.sliders.length,
                          effect: CustomizableEffect(
                            activeDotDecoration: DotDecoration(
                              width: 30,
                              height: 9,
                              color: Color(0xFFFF9F54),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            dotDecoration: DotDecoration(
                              width: 11,
                              height: 10,
                              color: const Color(0XFFE1EAFB),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            spacing: 4,
                          ),
                          onDotClicked: (index) {
                            _controller.animateToPage(index);
                          },
                        ),
                      ],
                    );
                  }),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextStyle.lato4(
                              'Categories'.tr(),
                              Color(0XFF2C371F),
                              22,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RoutingManager.allCategoryScr);
                              },
                              child: AppTextStyle.roboto1(
                                'Show All'.tr(),
                                AppColor.secondaryColor_400,
                                15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        if (categoryController.isLoading.value) {
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          height: 109,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: categoryController.categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var category =
                                  categoryController.categories[index];
                              return Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 63,
                                        width: 63,
                                        margin: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color:
                                              categoryController
                                                      .selectedCategory
                                                      .value ==
                                                  index
                                              ? AppColor.foundationSeconday
                                              : AppColor.foundationTertiary,
                                          borderRadius: BorderRadius.circular(
                                            29.5,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            categoryController
                                                    .selectedCategory
                                                    .value =
                                                index;
                                            categoryController
                                                .navigateBasedOnCategory(
                                                  category,
                                                );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            child: SvgPicture.string(
                                              category.svgImage,
                                              color:
                                                  categoryController
                                                          .selectedCategory
                                                          .value ==
                                                      index
                                                  ? AppColor.secondaryColor_400
                                                  : AppColor.gray2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      AppTextStyle.lato4(
                                        category.name,
                                        categoryController
                                                    .selectedCategory
                                                    .value ==
                                                index
                                            ? AppColor.secondaryColor_400
                                            : Color(0XFFBFCBE3),
                                        14,
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        );
                      }),
                      SizedBox(height: 16),
                      Obx(() {
                        return govController.isLoading.value
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                height: 84,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: govController.govEntities.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final entity =
                                        govController.govEntities[index];
                                    return InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          useRootNavigator: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return Container(
                                              height: 219,
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFFFFF),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  topLeft: Radius.circular(40),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                child: Column(
                                                  spacing: 5,
                                                  children: [
                                                    SizedBox(height: 15),
                                                    Row(
                                                      spacing: 5,
                                                      children: [
                                                        Spacer(),
                                                        SvgPicture.string(
                                                          entity.svgImage,
                                                          width: 28,
                                                          height: 28,
                                                          colorFilter:
                                                              const ColorFilter.mode(
                                                                Color(
                                                                  0XFF7E8872,
                                                                ),
                                                                BlendMode.srcIn,
                                                              ),
                                                        ),
                                                        AppTextStyle.lato4(
                                                          entity.name.tr(),
                                                          Color(0xFF000000),
                                                          22,
                                                        ),
                                                        Spacer(),
                                                        IconButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          icon: Icon(
                                                            Icons.close,
                                                            size: 30,
                                                            color: Color(
                                                              0XFFB0B0B0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 16),
                                                    Wrap(
                                                      spacing: 10,
                                                      alignment:
                                                          WrapAlignment.center,
                                                      children: entity.socialLinks.map((
                                                        link,
                                                      ) {
                                                        return AppContainer3(
                                                          width: 104,
                                                          text: link.typeLabel
                                                              .tr(),
                                                          text2: govController
                                                              .mapIcon(
                                                                link.typeCaseName,
                                                              ),
                                                          onTap: () {
                                                            AppUrlLauncher.launchStaticUrl(
                                                              link.value,
                                                              link.typeCaseName,
                                                            );
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(12),
                                        height: 64,
                                        width: 174,
                                        decoration: BoxDecoration(
                                          color: AppColor.green_500,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.string(
                                                entity.svgImage,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                      Color(0xFFE6E8EE),
                                                      BlendMode.srcIn,
                                                    ),
                                              ),
                                            ),
                                            AppTextStyle.lato4(
                                              entity.name.tr(),
                                              Color(0xFFE6E8EE),
                                              12,
                                            ),
                                            SvgPicture.asset(
                                              AppIcon.circlephone,
                                              width: 18,
                                              height: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      }),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Best\t'.tr(),
                                    style: TextStyle(color: Color(0xFF010A1C)),
                                  ),
                                  TextSpan(
                                    text: 'Offers\t'.tr(),
                                    style: TextStyle(color: Color(0xFFFF8C33)),
                                  ),
                                  TextSpan(
                                    text: 'just for you\t'.tr(),
                                    style: TextStyle(color: Color(0xFF010A1C)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Obx(() {
                        if (offersController.isLoading.value) {
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        }
                        if (offersController.offers.isEmpty) {
                          return Center(
                            child: AppTextStyle.lato4(
                              'No Offers Available'.tr(),
                              AppColor.gray,
                              16,
                            ),
                          );
                        }
                        return SizedBox(
                          height: 162.25,
                          child: ListView.builder(
                            itemCount: offersController.offers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final offer = offersController.offers[index];
                              return InkWell(
                                onTap: () {
                                  final targetProvider = providerController
                                      .providersList
                                      .firstWhere(
                                        (p) => p.shopName == offer.shopName,
                                      );

                                  providerController.selectedProvider.value =
                                      targetProvider;

                                  Get.toNamed(RoutingManager.providerdetailScr);
                                },
                                child: Container(
                                  height: 162,
                                  width: 143,
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: offer.imageUrl.isNotEmpty
                                          ? NetworkImage(offer.imageUrl)
                                          : AssetImage(AppImage.far)
                                                as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    color: const Color(0XFFFFFFFF),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: const Color(
                                          0XFF000000,
                                        ).withOpacity(0.25),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextStyle.lato4(
                              'Service Provider'.tr(),
                              Color(0XFF2C371F),
                              22,
                            ),
                            InkWell(
                              //-============================
                              onTap: () {
                                homeController.selectedindex.value = 2;
                              },
                              child: AppTextStyle.roboto1(
                                'Show All'.tr(),
                                AppColor.secondaryColor_400,
                                15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Obx(() {
                        if (providerController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          height: 255,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: providerController.providersList.length,
                            itemBuilder: (context, index) {
                              final provider =
                                  providerController.providersList[index];

                              return Container(
                                height: 248,
                                width: 181,
                                margin: const EdgeInsets.all(12),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFFBFCFE),
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: const Color(0xFFDBE5FA),
                                  ),
                                ),
                                child: Column(
                                  spacing: 6,
                                  children: [
                                    Image.network(
                                      provider.mainImage,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Spacer(),
                                        AppTextStyle.lato2(
                                          provider.providerName,
                                          const Color(0xFF2C371F),
                                        ),
                                        const Spacer(flex: 5),
                                        InkWell(
                                          onTap: () {
                                            providerController
                                                    .selectedProvider
                                                    .value =
                                                provider;
                                            Get.to(
                                              () => ProviderdetailScreen(),
                                            );
                                          },
                                          child: SvgPicture.asset(
                                            AppIcon.angle,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),

                                    Row(
                                      spacing: 4,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 8),
                                        SvgPicture.asset(
                                          AppIcon.eye,
                                          width: 14,
                                        ),
                                        AppTextStyle.lato(
                                          "${provider.views} ${'Views'.tr()}",
                                          const Color(0XFF717171),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: provider.tags.take(3).map((
                                          tag,
                                        ) {
                                          return AppContainer(
                                            height: 20,
                                            width: 60,
                                            text: '#$tag'.tr(),
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
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
