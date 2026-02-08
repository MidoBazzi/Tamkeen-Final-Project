import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    this.width,
    required this.text,
    required this.borderRadius,
    required this.height,
  });
  final double? width;
  final String text;
  final double height;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xFFBFCBE3),
        borderRadius: borderRadius,
      ),
      child: Center(child: AppTextStyle.lato(text, Color(0xFFFBFCFE))),
    );
  }
}
