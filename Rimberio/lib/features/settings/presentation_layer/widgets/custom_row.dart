import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.widget,
    required this.text,
    this.widget2,
  });
  final Widget widget;
  final Widget? widget2;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget,
        Expanded(child: AppTextStyle.lato4(text, Color(0xFF5A5A5A), 16)),
        widget2 ?? Text(''),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xFF5A5A5A),
          size: 20,
        ),
      ],
    );
  }
}
