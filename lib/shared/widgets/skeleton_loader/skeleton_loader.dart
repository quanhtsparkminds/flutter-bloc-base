import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';

class SkeletonLoader extends StatelessWidget {
  final Color? color;
  final double? size;

  const SkeletonLoader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
          color: color ?? AppColors.greyStrong.withOpacity(0.2),
          size: size ?? AppSpacing.x40),
    );
  }
}
