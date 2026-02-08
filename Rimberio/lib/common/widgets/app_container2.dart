// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_provider/core/const/app_icon.dart';

class AppContainer2 extends StatelessWidget {
  const AppContainer2({
    super.key,
    required this.image,
    required this.widget,
    required this.widget2,
    required this.widget3,
    required this.child,
  });
  final ImageProvider<Object> image;
  final Widget widget;
  final Widget widget2;
  final Widget widget3;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 129,
      width: 401,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0XFFFBFCFE),
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(width: 1, color: Color(0xFFDBE5FA)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 97,
                width: 107,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      offset: Offset(2, 1),
                      color: Color(0xFF000000).withOpacity(0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(fit: BoxFit.cover, image: image),
                ),
              ),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget,
                  Row(
                    spacing: 4,
                    children: [SvgPicture.asset(AppIcon.ey), widget2],
                  ),
                  child,
                ],
              ),
              widget3,
            ],
          ),
        ],
      ),
    );
  }
}
