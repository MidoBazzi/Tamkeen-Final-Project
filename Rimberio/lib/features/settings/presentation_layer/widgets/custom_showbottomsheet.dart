import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class CustomShowbottomsheet extends StatelessWidget {
  const CustomShowbottomsheet({
    super.key,
    this.child,
    this.height,
    required this.text,
    this.widget,
    this.widget2,
    this.widget3,
  });
  final Widget? child;
  final double? height;
  final String text;
  final Widget? widget;
  final Widget? widget2;
  final Widget? widget3;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 22),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 54, right: 76),
                        child: AppTextStyle.lato4(text, Color(0xFF000000), 22),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          size: 30,
                          Icons.close,
                          color: Color(0XFFB0B0B0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  widget ?? Text(''),
                  SizedBox(height: 24),
                  widget2 ?? Text(''),
                  SizedBox(height: 24),
                  widget3 ?? Text(''),
                ],
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
