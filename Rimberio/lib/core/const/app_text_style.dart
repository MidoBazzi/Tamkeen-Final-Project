import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_provider/core/const/app_color.dart';

class AppTextStyle {
  static Widget cairo(String text, Color color) {
    return Text(
      text,

      style: GoogleFonts.cairo(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0.2,
        height: 1.4,
      ),
    );
  }

  static Widget cairo2(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 28,
        height: 1.4,
      ),
    );
  }

  static Widget lato(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.4,
      ),
    );
  }

  static Widget lato2(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.4,
      ),
    );
  }

  static Widget lato3(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.4,
      ),
    );
  }

  static Widget lato4(String text, Color color, double size) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: size,
        height: 1.4,
      ),
    );
  }

  static Widget lato5(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: AppColor.secondaryColor_400,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.4,
        decoration: TextDecoration.underline,
        decorationColor: AppColor.secondaryColor_400,
      ),
    );
  }

  static Widget roboto1(String text, Color color, double size) {
    return Text(
      text,
      style: GoogleFonts.roboto(color: color, fontSize: size, height: 1.4),
    );
  }
}
