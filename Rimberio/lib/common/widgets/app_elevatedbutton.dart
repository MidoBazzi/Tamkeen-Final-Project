// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class AppElevatedbutton extends StatelessWidget {
  AppElevatedbutton({
    super.key,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
  });
  void Function()? onPressed;
  String title;
  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        overlayColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(7),
        ),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.99, 42),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: AppTextStyle.lato2(title, Color(0xFFFFFFFF)),
    );
  }
}
