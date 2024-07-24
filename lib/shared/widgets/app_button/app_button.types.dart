import 'package:flutter/material.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/constants/size_constant.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';

const double appButtonIconSize = 20;
const double appButtonHeight = AppSpacing.x48;

enum AppButtonVariant {
  primary,
  primaryAmber,
  secondary,
  secondaryLightSalmon,
  caribbean,
  ghost
}

TextStyle getFontSizeAndLineHeightByVariant() {
  return const TextStyle(
      fontFamily: FontFamily.fontRegularRoboto,
      fontSize: AppSpacing.x16,
      fontWeight: FontWeight.w700,
      height: AppSpacing.x18 / AppSpacing.x16);
}

TextStyle getAppTextButtonStyleByVariant(AppButtonVariant appButtonVariant,
    {required bool isEnable}) {
  TextStyle baseStyle = getFontSizeAndLineHeightByVariant();

  switch (appButtonVariant) {
    case AppButtonVariant.primary:
    case AppButtonVariant.primaryAmber:
    case AppButtonVariant.caribbean:
    case AppButtonVariant.ghost:
      return TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0,
              color: getAppTextButtonStyleByVariantButton(
                  appButtonVariant)[isEnable ? 'active' : 'disabled'])
          .merge(baseStyle);
    case AppButtonVariant.secondaryLightSalmon:
    case AppButtonVariant.secondary:
      return TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 0.0,
              color: getAppTextButtonStyleByVariantButton(
                  appButtonVariant)[isEnable ? 'active' : 'disabled'])
          .merge(baseStyle);
    default:
      return const TextStyle();
  }
}

enum AppButtonIcon { import, export, copy }

String getAppButtonIconByType(AppButtonIcon? appButtonIcon) {
  switch (appButtonIcon) {
    case AppButtonIcon.import:
      return Assets.svg.import;
    case AppButtonIcon.export:
      return Assets.svg.export;
    case AppButtonIcon.copy:
      return Assets.svg.copy;
    default:
      return '';
  }
}

Map<String, Color> getAppButtonIconColor(
    AppButtonVariant appButtonVariant, BuildContext context) {
  switch (appButtonVariant) {
    case AppButtonVariant.primary:
      return {
        'disabled': AppColors.primaryColor.withOpacity(.1),
        'active': AppColors.primaryColor,
      };
    case AppButtonVariant.primaryAmber:
      return {
        'disabled': AppColors.darkModeColor.withOpacity(0.5),
        'active': AppColors.ligthSalmon,
      };
    case AppButtonVariant.secondaryLightSalmon:
      return {
        'disabled': AppColors.darkModeColor.withOpacity(0.5),
        'active': AppColors.ligthSalmon,
      };
    default:
      return {
        'disabled': AppColors.white,
        'active': AppColors.white,
      };
  }
}

Map<String, Color> getAppTextButtonStyleByVariantButton(
    AppButtonVariant appButtonVariant) {
  switch (appButtonVariant) {
    case AppButtonVariant.primary:
      return {
        'disabled': AppColors.white.withOpacity(.6),
        'active': AppColors.white,
      };
    case AppButtonVariant.primaryAmber:
      return {
        'disabled': AppColors.lineGreyRow,
        'active': AppColors.secondaryColor3,
      };
    case AppButtonVariant.secondaryLightSalmon:
    case AppButtonVariant.secondary:
      return {
        'disabled': AppColors.white.withOpacity(0.7),
        'active': AppColors.white,
      };
    case AppButtonVariant.ghost:
    case AppButtonVariant.caribbean:
    default:
      return {
        'disabled': AppColors.primaryColor.withOpacity(.6),
        'active': AppColors.primaryColor,
      };
  }
}

Map<String, Color> getAppButtonColorByVariantButton(
    AppButtonVariant appButtonVariant) {
  switch (appButtonVariant) {
    case AppButtonVariant.caribbean:
      return {
        'disabled': AppColors.primaryColor.withOpacity(.1),
        'active': AppColors.primaryColor.withOpacity(.1),
      };
    case AppButtonVariant.primary:
      return {
        'disabled': AppColors.primaryColor.withOpacity(.1),
        'active': AppColors.primaryColor,
      };
    case AppButtonVariant.primaryAmber:
      return {
        'disabled': AppColors.ligthSalmon.withOpacity(.1),
        'active': AppColors.ligthSalmon.withOpacity(.1),
      };
    case AppButtonVariant.secondaryLightSalmon:
      return {
        'disabled': AppColors.secondaryColor3.withOpacity(0.5),
        'active': AppColors.secondaryColor3,
      };
    default:
      return {
        'disabled': AppColors.white,
        'active': AppColors.white,
      };
  }
}

ButtonStyle getAppButtonStyleByVariant(
    AppButtonVariant appButtonVariant, BuildContext context,
    {required bool isEnable}) {
  /*
    Base style common for primary button
    Text style - shape - elevation
  */
  ButtonStyle baseStylePrimary = ButtonStyle(
    minimumSize:
        const MaterialStatePropertyAll(Size(double.infinity, appButtonHeight)),
    textStyle: MaterialStatePropertyAll(
        getAppTextButtonStyleByVariant(appButtonVariant, isEnable: isEnable)),
    animationDuration: animationDuration,
    elevation: const MaterialStatePropertyAll(elevation),
    side: MaterialStatePropertyAll(
        BorderSide(color: AppColors.transparent, width: AppSpacing.x0)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.x25),
      ),
    ),
  );

  ButtonStyle baseStyleSecondary = ButtonStyle(
    minimumSize:
        const MaterialStatePropertyAll(Size(double.infinity, appButtonHeight)),
    textStyle: MaterialStatePropertyAll(
        getAppTextButtonStyleByVariant(appButtonVariant, isEnable: isEnable)),
    animationDuration: animationDuration,
  );

  ButtonStyle baseStyle = ButtonStyle(
      minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, appButtonHeight)),
      textStyle: MaterialStatePropertyAll(
          getAppTextStyleByVariant(AppTextVariant.button)),
      elevation: const MaterialStatePropertyAll(0),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.x25),
        side: BorderSide.none,
      )));

  switch (appButtonVariant) {
    case AppButtonVariant.caribbean:
      return baseStylePrimary.merge(OutlinedButton.styleFrom(
          disabledBackgroundColor:
              getAppButtonColorByVariantButton(appButtonVariant)['disabled'],
          disabledForegroundColor: AppColors.primaryColor,
          backgroundColor:
              getAppButtonColorByVariantButton(appButtonVariant)['active'],
          shadowColor: AppColors.primaryColor.withOpacity(0.1)));
    case AppButtonVariant.primary:
      return baseStylePrimary.merge(OutlinedButton.styleFrom(
          disabledBackgroundColor:
              getAppButtonColorByVariantButton(appButtonVariant)['disabled'],
          disabledForegroundColor: AppColors.primaryColor,
          backgroundColor:
              getAppButtonColorByVariantButton(appButtonVariant)['active'],
          shadowColor: AppColors.primaryColor.withOpacity(0.3)));
    case AppButtonVariant.primaryAmber:
      return baseStylePrimary.merge(OutlinedButton.styleFrom(
        disabledBackgroundColor:
            getAppButtonColorByVariantButton(appButtonVariant)['disabled'],
        disabledForegroundColor: AppColors.ligthSalmon,
        backgroundColor:
            getAppButtonColorByVariantButton(appButtonVariant)['active'],
      ));
    case AppButtonVariant.secondaryLightSalmon:
      return baseStylePrimary.merge(OutlinedButton.styleFrom(
        disabledBackgroundColor:
            getAppButtonColorByVariantButton(appButtonVariant)['disabled'],
        disabledForegroundColor: AppColors.secondaryColor3,
        backgroundColor:
            getAppButtonColorByVariantButton(appButtonVariant)['active'],
      ));
    case AppButtonVariant.secondary:
      return baseStyleSecondary.merge(OutlinedButton.styleFrom(
        disabledBackgroundColor: AppColors.grey,
        disabledForegroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.x25),
          side: BorderSide(
              color: getAppTextButtonStyleByVariantButton(
                  appButtonVariant)[isEnable ? 'active' : 'disabled']!,
              width: 1.5),
        ),
      ));

    case AppButtonVariant.ghost:
      return baseStylePrimary.merge(OutlinedButton.styleFrom(
          disabledBackgroundColor:
              getAppButtonColorByVariantButton(appButtonVariant)['disabled'],
          disabledForegroundColor: AppColors.white,
          backgroundColor:
              getAppButtonColorByVariantButton(appButtonVariant)['active'],
          shadowColor: AppColors.white));
    default:
      return baseStyle;
  }
}
