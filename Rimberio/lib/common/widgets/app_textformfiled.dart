import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';

class AppTextformfiled extends StatelessWidget {
  const AppTextformfiled({
    super.key,
    required this.keyboardType,
    required this.prefixIcon,
    required this.hintText,
    required this.textInputAction,
    this.controller,
    this.validator,
    this.obscureText,
    this.suffixicon,
    required this.borderRadius,
    this.height,
    this.width,
    this.contentPadding,
  });

  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final Widget hintText;
  final Widget? suffixicon;
  final bool? obscureText;
  final BorderRadius borderRadius;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: TextFormField(
                cursorHeight: 24,
                cursorErrorColor: AppColor.secondaryColor_400,
                cursorColor: AppColor.secondaryColor_400,
                style: TextStyle(fontSize: 12),
                controller: controller,
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                obscureText: obscureText ?? false,
                onChanged: (value) => field.didChange(value),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: contentPadding,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: AppColor.grayScaleLessDark),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: Color(0xFFFF8C33)),
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixicon,
                  hint: hintText,
                ),
              ),
            ),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 1),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/exclamation (2) 1.svg',
                      height: 16,
                    ),

                    SizedBox(width: 5),
                    Text(
                      field.errorText!,
                      style: GoogleFonts.lato(
                        color: Color(0XFFCF362E),
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
