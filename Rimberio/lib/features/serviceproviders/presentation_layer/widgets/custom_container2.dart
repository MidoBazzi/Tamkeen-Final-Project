import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class CustomContainer2 extends StatelessWidget {
  const CustomContainer2({
    super.key,
    required this.text,
    required this.color,
    required this.color2,
  });

  final String text;
  final Color color;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 124.66667175292969,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: AppTextStyle.lato2(text, color2)),
    );
  }
}
