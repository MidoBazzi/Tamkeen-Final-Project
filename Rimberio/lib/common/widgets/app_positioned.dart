import 'package:flutter/material.dart';

class AppPositioned extends StatelessWidget {
  const AppPositioned({
    super.key,
    required this.child,
    required this.top,
    this.padding,
  });
  final Widget child;
  final double top;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: padding ?? EdgeInsets.all(0),
            child: ListView(children: [child]),
          ),
        ),
      ),
    );
  }
}
