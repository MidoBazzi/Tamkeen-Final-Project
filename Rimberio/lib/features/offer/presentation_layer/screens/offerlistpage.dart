// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_searchfiled.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';
import 'package:service_provider/features/offer/business_logic_layer/offers_controller.dart';
import 'package:service_provider/features/serviceproviders/business_logic_layer/providers_controller.dart';

class Offerlistpage extends StatelessWidget {
  Offerlistpage({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final OffersController offersController = Get.find<OffersController>();
  final ProviderController providerController = Get.find<ProviderController>();

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
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                              homeController.selectedindex.value = 0;
                            },
                            child: SvgPicture.asset(AppIcon.back_out),
                          ),
                          AppTextStyle.lato4(
                            'Offers List'.tr(),
                            const Color(0xFFFBFCFE),
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
            top: MediaQuery.of(context).size.height * 0.160,
            child: Column(
              children: [
                AppSearchfiled(
                  controller: offersController.searchController,
                  onChanged: (value) {
                    offersController.searchOffers(value);
                  },
                ),
                SizedBox(height: 24),
                Obx(() {
                  if (offersController.isLoading.value) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
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
                    itemCount: offersController.offers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final offer = offersController.offers[index];
                      return InkWell(
                        onTap: () {
                          final targetProvider = providerController
                              .providersList
                              .firstWhere((p) => p.shopName == offer.shopName);

                          providerController.selectedProvider.value =
                              targetProvider;

                          Get.toNamed(RoutingManager.providerdetailScr);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: offer.imageUrl.isNotEmpty
                                  ? NetworkImage(offer.imageUrl)
                                  : AssetImage(AppImage.far) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                            color: Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                                color: Color(0XFF000000).withOpacity(0.3),
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
                              color: Color(0xFF000000).withOpacity(0.7),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ),
        ],
      ),
    );
  }
}
