import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_color.dart';

class AppElevatedbutton2 extends StatelessWidget {
  const AppElevatedbutton2({
    super.key,
    required this.child,
    required this.onPressed,
    required this.width,
    required this.borderRadius,
  });
  final Widget? child;
  final void Function()? onPressed;
  final double width;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: AppColor.purple_50,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: AppColor.secondaryColor_400, width: 1),
        ),
        elevation: 0,
        fixedSize: Size(width, 42),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
