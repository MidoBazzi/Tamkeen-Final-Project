// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';
import 'package:service_provider/core/const/app_icon.dart';

class AppPhoneInputBox extends StatelessWidget {
  const AppPhoneInputBox({
    super.key,
    required this.controller,
    required this.validator,
    required this.textInputAction,
  });

  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLength: 10,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: TextInputType.phone,
              onChanged: (val) => field.didChange(val),
              cursorHeight: 24,
              cursorErrorColor: AppColor.secondaryColor_400,
              cursorColor: AppColor.secondaryColor_400,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppColor.grayScaleLessDark),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Color(0xFFFF8C33)),
                ),
                hintText: 'Write Your Phone Number'.tr(),
                hintStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.4,
                  color: AppColor.gray,
                ),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 19),
                    SvgPicture.asset(
                      AppIcon.call,
                      color: AppColor.secondaryColor_400,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '+963'.tr(),
                      style: GoogleFonts.lato(
                        color: const Color(0xFFFF6F00),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      height: 28,
                      width: 1,
                      color: const Color(0xFF717171),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),

            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 1, right: 1),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/exclamation (2) 1.svg',
                      height: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      field.errorText!,
                      style: GoogleFonts.lato(
                        color: const Color(0XFFCF362E),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
