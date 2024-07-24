import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myapp/commands/core/app_spacing.dart';

class ProgressiveDotsLoader extends StatelessWidget {
  final Color? color;
  final double size;

  const ProgressiveDotsLoader(
      {super.key, this.color, this.size = AppSpacing.x40});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.prograssiveDots(
          color: color ??
              Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          size: size),
    );
  }
}
