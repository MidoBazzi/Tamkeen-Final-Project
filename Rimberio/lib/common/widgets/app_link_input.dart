import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';

class AppLinkInput extends StatelessWidget {
  const AppLinkInput({
    super.key,
    required this.controller,
    required this.validator,
    required this.textInputAction,
    required this.widget,
    this.widget2,
    this.hintText,
    this.keyboardType,
  });

  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Widget widget;
  final Widget? widget2;
  final String? hintText;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              onChanged: (val) => field.didChange(val),
              cursorHeight: 24,
              cursorErrorColor: AppColor.secondaryColor_400,
              cursorColor: AppColor.secondaryColor_400,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppColor.grayScaleLessDark),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Color(0xFFFF8C33)),
                ),
                hintText: hintText,
                hintStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.4,
                  color: AppColor.gray,
                ),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 19),
                    widget,
                    widget2 ?? Text(''),
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
                padding: const EdgeInsets.only(top: 4, left: 1),
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
