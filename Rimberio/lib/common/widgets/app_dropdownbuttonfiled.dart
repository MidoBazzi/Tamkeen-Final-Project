// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';

class AppDropdownbuttonfiled extends StatelessWidget {
  const AppDropdownbuttonfiled({
    super.key,
    this.height,
    this.width,
    required this.onChanged,
    required this.borderRadius,
    required this.prefixIcon,
    required this.hintText,
    required this.validator,
    required this.items,
    this.icon,
    this.onTap,
  });

  final double? height;
  final double? width;
  final Widget prefixIcon;
  final String hintText;
  final void Function(String?) onChanged;
  final BorderRadius borderRadius;
  final String? Function(String?) validator;
  final Widget? icon;
  final List<DropdownMenuItem<String>> items;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: DropdownButtonFormField<String>(
                value: field.value,
                onTap: onTap,
                isExpanded: true,
                dropdownColor: const Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                icon: icon,
                onChanged: (String? newValue) {
                  field.didChange(newValue);
                  onChanged(newValue);
                },
                style: GoogleFonts.lato(
                  color: const Color(0xFF222B18),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.18,
                ),
                items: items,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: AppColor.grayScaleLessDark),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: Color(0xFFFF8C33)),
                  ),
                  prefixIcon: prefixIcon,
                  hintText: hintText,
                ),
              ),
            ),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 1),
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
