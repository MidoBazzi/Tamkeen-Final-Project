// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class AppContainer3 extends StatelessWidget {
  const AppContainer3({
    super.key,
    this.width,
    required this.text,
    required this.text2,
    required this.onTap,
  });
  final double? width;
  final String text;
  final String text2;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColor.secondaryColor_400, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(text2, color: AppColor.secondaryColor_400),
            AppTextStyle.lato4(text, AppColor.secondaryColor_400, 12),
          ],
        ),
      ),
    );
  }
}
