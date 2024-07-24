import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';

class SignUpWidgets {
  const SignUpWidgets._();
  static Widget footerWithText(
      {void Function()? onPressed,
      required String textPrefix,
      Color? textPrefixColor,
      TextAlign? textAlign,
      required String textSuffix}) {
    return RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: textPrefix,
              style: getAppTextStyleByVariant(AppTextVariant.text1).copyWith(
                  fontWeight: FontWeight.w400,
                  color: textPrefixColor ?? AppColors.greyStrong)),
          TextSpan(
              text: textSuffix,
              recognizer: TapGestureRecognizer()..onTap = onPressed,
              style: getAppTextStyleByVariant(AppTextVariant.button).copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.primaryColor)),
        ]));
  }

  static Widget authMessWithPhone(
      {required String textPrefix, required String textSuffix}) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: textPrefix,
              style: getAppTextStyleByVariant(AppTextVariant.button).copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textDark)),
          TextSpan(
              text: textSuffix,
              style: getAppTextStyleByVariant(AppTextVariant.button).copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.primaryColor)),
        ]));
  }
}
