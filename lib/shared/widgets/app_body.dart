import 'package:flutter/material.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';

class BodyWrappedWithChild extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  const BodyWrappedWithChild(
      {super.key,
      required this.child,
      this.decoration,
      this.padding,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration ??
          BoxDecoration(
              color: AppColors.white,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSpacing.x10))),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.x20),
      child: child,
    );
  }
}
