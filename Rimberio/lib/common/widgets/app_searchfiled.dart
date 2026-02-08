// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';

class AppSearchfiled extends StatelessWidget {
  AppSearchfiled({
    super.key,
    this.width,
    this.suffixIcon,
    this.onChanged,
    this.controller,
  });

  final double? width;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        autofocus: false,
        cursorHeight: 24,
        cursorErrorColor: AppColor.secondaryColor_400,
        cursorColor: AppColor.secondaryColor_400,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SvgPicture.asset(AppIcon.ser),
          ),
          suffixIcon: suffixIcon,
          hintText: 'Search..'.tr(),
          hintStyle: GoogleFonts.lato(
            color: Color(0XFFBFCBE3),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFBFCBE3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFFF8C33)),
          ),
        ),
      ),
    );
  }
}
