import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/features/home/business_logic_layer/home_controller.dart';
import 'package:service_provider/features/home/data_layer/models/classes_list.dart';

class SuperHome extends StatelessWidget {
  SuperHome({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ClassesList.pages[homeController.selectedindex.value]),
      extendBody: true,
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          height: 77,
          index: homeController.selectedindex.value,
          onTap: (value) {
            homeController.selectedindex.value = value;
          },
          buttonBackgroundColor: const Color(0xFFFF6F00),
          backgroundColor: Colors.transparent,
          items: [
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                homeController.selectedindex.value == 0
                    ? 'assets/icons/HOME.svg'
                    : 'assets/icons/ll.svg',
              ),
              label: homeController.selectedindex.value == 0
                  ? 'Home'.tr()
                  : null,
              labelStyle: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor_400,
                letterSpacing: 0.2,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                homeController.selectedindex.value == 1
                    ? 'assets/icons/badge-percent 2.svg'
                    : 'assets/icons/pp.svg',
              ),
              label: homeController.selectedindex.value == 1
                  ? 'Offers'.tr()
                  : null,
              labelStyle: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor_400,
                letterSpacing: 0.2,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                homeController.selectedindex.value == 2
                    ? 'assets/icons/Component 23.svg'
                    : 'assets/icons/3.svg',
              ),
              label: homeController.selectedindex.value == 2
                  ? 'Providers'.tr()
                  : null,
              labelStyle: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor_400,
                letterSpacing: 0.2,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                homeController.selectedindex.value == 3
                    ? 'assets/icons/Component 22.svg'
                    : 'assets/icons/4.svg',
              ),
              label: homeController.selectedindex.value == 3
                  ? 'Entities'.tr()
                  : null,
              labelStyle: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor_400,
                letterSpacing: 0.2,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                homeController.selectedindex.value == 4
                    ? 'assets/icons/Component 24.svg'
                    : 'assets/icons/5.svg',
              ),
              label: homeController.selectedindex.value == 4
                  ? 'Settings'.tr()
                  : null,
              labelStyle: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor_400,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
