import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_container3.dart';
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/common/widgets/app_searchfiled.dart';
import 'package:service_provider/common/widgets/app_url_launcher.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/governmententities/business_logic_layer/governmententities_controller.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';

class GovernmententitiesScreen extends StatelessWidget {
  GovernmententitiesScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final GovernmententitiesController govController = Get.put(
    GovernmententitiesController(),
  );
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
                              homeController.selectedindex.value = 2;
                            },
                            child: SvgPicture.asset(AppIcon.back_out),
                          ),
                          AppTextStyle.lato4(
                            'Government entities'.tr(),
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
            top: MediaQuery.of(context).size.height * 0.160,
            child: Column(
              spacing: 16,
              children: [
                AppSearchfiled(
                  controller: govController.searchController,
                  onChanged: (value) {
                    govController.searchEntities(value);
                  },
                ),

                Obx(() {
                  if (govController.isLoading.value) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (govController.govEntities.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: AppTextStyle.lato4(
                          "No Governmentent Found".tr(),
                          AppColor.gray,
                          16,
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.6,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: govController.govEntities.length,
                    itemBuilder: (context, index) {
                      final entity = govController.govEntities[index];
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                height: 167,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    topLeft: Radius.circular(40),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Spacer(),
                                          SvgPicture.string(
                                            entity.svgImage,
                                            width: 28,
                                            height: 28,
                                            colorFilter: const ColorFilter.mode(
                                              Color(0XFF7E8872),
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
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: Icon(
                                              size: 30,
                                              Icons.close,
                                              color: Color(0XFFB0B0B0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24),
                                      Wrap(
                                        spacing: 10,
                                        alignment: WrapAlignment.center,
                                        children: entity.socialLinks.map((
                                          link,
                                        ) {
                                          return AppContainer3(
                                            width: 104,
                                            text: link.typeLabel.tr(),
                                            text2: govController.mapIcon(
                                              link.typeCaseName.tr(),
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
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.green_500,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.string(
                                  entity.svgImage,
                                  colorFilter: const ColorFilter.mode(
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
