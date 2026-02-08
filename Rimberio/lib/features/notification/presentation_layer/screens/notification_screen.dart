import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/common/widgets/app_positioned.dart';
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/core/const/app_image.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
                  padding: EdgeInsets.symmetric(horizontal: 17),
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
                            'Notifications'.tr(),
                            Color(0xFFFBFCFE),
                            24,
                          ),
                          SvgPicture.asset('assets/icons/6.svg'),
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
            top: MediaQuery.of(context).size.height * 0.133,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle.lato2(
                    'New Opportunity Awaiting Your Expertise'.tr(),
                    Colors.black,
                  ),
                  AppTextStyle.lato4(
                    'April 25, 2025 / 12:00Am',
                    Color(0xFFACACAC),
                    12,
                  ),
                  SizedBox(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextStyle.lato4(
                          'A nearby customer is looking for your skills. Open Fixit to review the request, set your rate, and reply quickly to secure the job and boost your reputation.',
                          Color(0xFF000000),
                          14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: SvgPicture.asset('assets/icons/Ellipse 36.svg'),
                      ),
                    ],
                  ),
                  Divider(color: Color(0XFFBBBBBB)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
