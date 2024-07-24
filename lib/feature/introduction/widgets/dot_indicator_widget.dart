import 'package:flutter/widgets.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/exported_packages.dart';

Widget dotIndicator({required bool isActive, Tuple2<Color, Color>? color}) {
  Color colorActive = (color?.item0 ?? AppColors.ligthSalmon);
  Color colorDisable = (color?.item1 ?? AppColors.white);
  return Container(
    padding: const EdgeInsets.all(AppSpacing.x6),
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.x4),
    width: AppSpacing.x15,
    height: AppSpacing.x15,
    decoration: BoxDecoration(
        color: isActive ? colorActive : colorDisable,
        borderRadius: const BorderRadius.all(Radius.circular(30))),
  );
}
