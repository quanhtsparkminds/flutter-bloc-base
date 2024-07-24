import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';

class AppTheme {
  static ThemeData light() => ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: FontFamily.fontRegularRoboto,
            bodyColor: AppColors.darkModeColor,
            displayColor: AppColors.darkModeColor,
          ),
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
          primary: AppColors.white,
          secondary: AppColors.white,
          background: AppColors.white,
          surface: AppColors.white,
          error: AppColors.error),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
        selectionColor: AppColors.primaryColor.withOpacity(.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.white,
        filled: true,
        hintStyle: getAppTextStyleByVariant(AppTextVariant.text1)
            .copyWith(color: AppColors.textDark, fontWeight: FontWeight.w400),
        errorStyle: getAppTextStyleByVariant(AppTextVariant.text1).apply(
            color: AppColors.error,
            fontWeightDelta: 500,
            overflow: TextOverflow.ellipsis),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x25),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x25),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x25),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x25),
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark));

  static ThemeData dark() => ThemeData.dark().copyWith(
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: FontFamily.fontRegularRoboto,
            bodyColor: AppColors.white,
            displayColor: AppColors.white,
          ),
      brightness: Brightness.dark,
      colorScheme: ColorScheme.light(
          primary: AppColors.darkModeColor,
          secondary: AppColors.darkModeColor,
          background: AppColors.darkModeColor,
          surface: AppColors.white,
          error: AppColors.error),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.darkModeColor,
        selectionHandleColor: Colors.transparent,
        selectionColor: AppColors.darkModeColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.x16, vertical: AppSpacing.x8),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle:
            TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500),
        errorStyle: getAppTextStyleByVariant(AppTextVariant.text1).apply(
            color: AppColors.error,
            fontWeightDelta: 500,
            overflow: TextOverflow.ellipsis),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.x8),
        ),
      ),
      appBarTheme: AppBarTheme(backgroundColor: AppColors.darkModeColor));
}
