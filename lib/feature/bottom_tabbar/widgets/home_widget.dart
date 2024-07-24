import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class HomeDetailsWidget {
  HomeDetailsWidget._();

  static Widget notificationWidget({required Function() onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Stack(
        children: [
          const FaIcon(FontAwesomeIcons.bell),
          Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.x4),
                decoration: BoxDecoration(
                  color: AppColors.flameScarlet,
                  shape: BoxShape.circle,
                ),
              ))
        ],
      ),
    );
  }

  static Widget rownInLine(
      {required String prefixText,
      required String suffixedText,
      Function? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextCustom(
          prefixText,
          variant: AppTextVariant.text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.fontBoldRoboto,
              color: AppColors.greyStrong),
        ),
        CupertinoButton(
          onPressed: onPressed != null ? () => onPressed() : null,
          padding: EdgeInsets.zero,
          child: TextCustom(
            suffixedText,
            variant: AppTextVariant.button,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.fontBoldRoboto,
                color: AppColors.lavenderMist),
          ),
        ),
      ],
    );
  }

  static Widget listViewWidget<T>(BuildContext context,
      {required Widget child, required double size}) {
    return SizedBox(
      height: Screens.resizeHeightUtil(context, size),
      child: child,
    );
  }
}
