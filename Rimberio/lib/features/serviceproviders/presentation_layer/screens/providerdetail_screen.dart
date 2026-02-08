// ignore_for_file: deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/common/widgets/app_container.dart';
import 'package:service_provider/common/widgets/app_container3.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_url_launcher.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';
import 'package:service_provider/features/offer/business_logic_layer/offers_controller.dart';
import 'package:service_provider/features/serviceproviders/business_logic_layer/providers_controller.dart';
import 'package:service_provider/features/serviceproviders/presentation_layer/widgets/custom_container.dart';
import 'package:service_provider/features/serviceproviders/presentation_layer/widgets/custom_container2.dart';
import 'package:service_provider/features/settings/business_logic_layer/settings_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProviderdetailScreen extends StatelessWidget {
  ProviderdetailScreen({super.key});
  final ProviderController providerController = Get.put(ProviderController());
  final CarouselSliderController _controller = CarouselSliderController();
  final OffersController offersController = Get.find<OffersController>();
  final HomeController homeController = Get.put(HomeController());
  final SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    final provider = providerController.selectedProvider.value;

    return Scaffold(
      body: provider == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(provider.mainImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(AppIcon.frame),
                            ),
                            Spacer(flex: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                AppPositioned(
                  top: MediaQuery.of(context).size.height * 0.24,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(
                      () => Column(
                        spacing: 11,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppTextStyle.lato4(
                                provider.providerName,
                                Colors.black,
                                24,
                              ),
                              AppTextStyle.lato2(
                                provider.shopName,
                                AppColor.green_500,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 5,
                            children: [
                              SvgPicture.asset('assets/icons/tire.svg'),
                              AppTextStyle.lato4(
                                provider.subCategoryName,
                                Color(0xFF959EB1),
                                14,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              SvgPicture.asset(
                                AppIcon.state,
                                color: AppColor.secondaryColor_400,
                              ),
                              AppTextStyle.lato4(
                                provider.address,
                                Color(0XFF2C371F),
                                14,
                              ),
                            ],
                          ),
                          SizedBox(height: 1),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      providerController.selectedTab.value = 0,
                                  child: CustomContainer2(
                                    text: 'Details'.tr(),
                                    color:
                                        providerController.selectedTab.value ==
                                            0
                                        ? AppColor.secondaryColor_400
                                        : Color(0XFFF1F1F1),
                                    color2:
                                        providerController.selectedTab.value ==
                                            0
                                        ? Color(0xFFFAF1FD)
                                        : Color(0XFF717171),
                                  ),
                                ),
                              ),

                              SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      providerController.selectedTab.value = 1,
                                  child: CustomContainer2(
                                    text: 'Gallery'.tr(),
                                    color:
                                        providerController.selectedTab.value ==
                                            1
                                        ? AppColor.secondaryColor_400
                                        : Color(0XFFF1F1F1),
                                    color2:
                                        providerController.selectedTab.value ==
                                            1
                                        ? Color(0xFFFAF1FD)
                                        : Color(0XFF717171),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      providerController.selectedTab.value = 2,
                                  child: CustomContainer2(
                                    text: 'Offers'.tr(),
                                    color:
                                        providerController.selectedTab.value ==
                                            2
                                        ? AppColor.secondaryColor_400
                                        : Color(0XFFF1F1F1),
                                    color2:
                                        providerController.selectedTab.value ==
                                            2
                                        ? Color(0xFFFAF1FD)
                                        : Color(0XFF717171),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1),
                          if (providerController.selectedTab.value == 0) ...[
                            AppTextStyle.lato4(
                              'description'.tr(),
                              Colors.black,
                              24,
                            ),
                            Obx(
                              () => RichText(
                                textAlign: TextAlign.start,
                                overflow: providerController.isExpanded.value
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                maxLines: providerController.isExpanded.value
                                    ? null
                                    : 7,
                                text: TextSpan(
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: provider.description + " ",
                                      style: TextStyle(
                                        color: Color(0xFF717171),
                                      ),
                                    ),
                                    TextSpan(
                                      text: providerController.isExpanded.value
                                          ? 'View Less'.tr()
                                          : 'View More'.tr(),
                                      style: TextStyle(
                                        color: AppColor.secondaryColor_400,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          providerController.toggleExpanded();
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: provider.tags
                                  .map(
                                    (tag) => AppContainer(
                                      height: 36,
                                      text: '#$tag',
                                      borderRadius: BorderRadius.circular(6),
                                      width: 80,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 1),
                            AppTextStyle.lato4(
                              'Contact Details'.tr(),
                              Colors.black,
                              24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppContainer3(
                                  onTap: () => AppUrlLauncher.launchStaticUrl(
                                    settingsController.phoneNumber.value,
                                    'URL',
                                  ),
                                  width: 127,
                                  text2: AppIcon.call,
                                  text: 'Phone number'.tr(),
                                ),
                                AppContainer3(
                                  onTap: () => AppUrlLauncher.launchStaticUrl(
                                    settingsController.whatsappNumber.value,
                                    'URL',
                                  ),
                                  width: 107,
                                  text2: AppIcon.whatsapp,
                                  text: 'Whats App'.tr(),
                                ),
                                AppContainer3(
                                  onTap: () => AppUrlLauncher.launchStaticUrl(
                                    settingsController.facebookUrl.value,
                                    'URL',
                                  ),
                                  width: 103,
                                  text2: AppIcon.facebook,
                                  text: 'Facebook'.tr(),
                                ),
                              ],
                            ),
                            AppContainer3(
                              onTap: () => AppUrlLauncher.launchStaticUrl(
                                settingsController.instagramUrl.value,
                                'URL',
                              ),
                              width: 104,
                              text2: AppIcon.instagram,
                              text: 'Instagram'.tr(),
                            ),
                          ],

                          if (providerController.selectedTab.value == 1) ...[
                            AppTextStyle.lato4(
                              'Gallery'.tr(),
                              Colors.black,
                              24,
                            ),
                            SizedBox(height: 1),
                            Obx(
                              () => Column(
                                children: [
                                  CarouselSlider(
                                    carouselController: _controller,
                                    items: provider.gallery
                                        .map(
                                          (imgUrl) => CustomContainer(
                                            image:
                                                NetworkImage(imgUrl)
                                                    as ImageProvider,
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                      height: 363,
                                      viewportFraction: 0.8,
                                      padEnds: true,
                                      enableInfiniteScroll: true,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.22,
                                      onPageChanged: (index, reason) {
                                        homeController.currentIndex.value =
                                            index;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  AnimatedSmoothIndicator(
                                    activeIndex:
                                        homeController.currentIndex.value,
                                    count: 3,
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
                                        color: Color(0XFFE1EAFB),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      spacing: 4,
                                    ),
                                    onDotClicked: (index) {
                                      _controller.animateToPage(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],

                          if (providerController.selectedTab.value == 2) ...[
                            RichText(
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
                            SizedBox(height: 1),
                            Obx(() {
                              if (offersController.isLoading.value) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: const CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final providerOffers = offersController.offers
                                  .where((offer) {
                                    return offer.shopName == provider.shopName;
                                  })
                                  .toList();

                              if (offersController.offers.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: AppTextStyle.lato4(
                                      "No Offers Found".tr(),
                                      AppColor.gray,
                                      16,
                                    ),
                                  ),
                                );
                              }
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 31,
                                      childAspectRatio: 1,
                                      mainAxisExtent: 201,
                                    ),
                                itemCount: providerOffers.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final offer = providerOffers[index];
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 3.5,
                                      ),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: offer.imageUrl.isNotEmpty
                                              ? NetworkImage(offer.imageUrl)
                                              : AssetImage(AppImage.far)
                                                    as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        color: Color(0XFFFFFFFF),
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                            offset: Offset(0, 2),
                                            color: Color(
                                              0XFF000000,
                                            ).withOpacity(0.3),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height: 64,
                                        margin: EdgeInsets.only(top: 137),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(16),
                                            topLeft: Radius.circular(16),
                                          ),
                                          color: Color(
                                            0xFF000000,
                                          ).withOpacity(0.7),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10),
                                            Container(
                                              height: 44.377777099609375,
                                              width: 49.154361724853516,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                    'assets/images/Group 1000005007.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                ),
                                                child: AppTextStyle.lato4(
                                                  offer.title,
                                                  Color(0XFFE6E8EE),
                                                  12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ],
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
