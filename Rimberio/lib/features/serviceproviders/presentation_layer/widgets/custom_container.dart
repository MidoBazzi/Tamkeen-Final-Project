// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.image});
  final ImageProvider<Object> image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 363,
      width: 306,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
            color: Color(0xFF000000).withOpacity(0.25),
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 3, color: AppColor.green_500),
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
