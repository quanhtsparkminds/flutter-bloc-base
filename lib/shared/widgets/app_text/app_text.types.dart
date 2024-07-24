import 'package:flutter/material.dart';
import 'package:myapp/gen/fonts.gen.dart';

enum AppTextVariant {
  bigger,
  h1,
  h2,
  h3,
  h4,
  biggerTitle,
  title,
  title2,
  text,
  text1,
  regular,
  text2,
  button,
  input,
  inputTitle,
  subtitle,
  subtitle1,
  subtitle2,
  menu,
  number,
  small,
}

Map<AppTextVariant, List<double>> appTextFontSizeAndLineHeight = {
  AppTextVariant.bigger: [40, 40],
  AppTextVariant.biggerTitle: [30, 24],
  AppTextVariant.h1: [30, 40],
  AppTextVariant.h2: [24, 28],
  AppTextVariant.title: [22, 25],
  AppTextVariant.title2: [20, 23],
  AppTextVariant.h3: [18, 24],
  AppTextVariant.h4: [14, 18],
  AppTextVariant.regular: [13, 18],
  AppTextVariant.text: [18, 22],
  AppTextVariant.text1: [14, 16],
  AppTextVariant.text2: [14, 24],
  AppTextVariant.button: [16, 18.75],
  AppTextVariant.input: [14, 18],
  AppTextVariant.inputTitle: [16, 18],
  AppTextVariant.subtitle: [12, 14],
  AppTextVariant.subtitle1: [12, 16],
  AppTextVariant.subtitle2: [12, 18],
  AppTextVariant.menu: [10, 12],
  AppTextVariant.number: [10, 10],
  AppTextVariant.small: [8, 10]
};

TextStyle getFontSizeAndLineHeightByVariant(AppTextVariant appTextVariant) {
  List<double>? payload = appTextFontSizeAndLineHeight[appTextVariant];
  if (payload != null) {
    return TextStyle(
        fontFamily: FontFamily.fontRegularRoboto,
        fontSize: payload.elementAt(0),
        letterSpacing: 0,
        height: payload.elementAt(1) / payload.elementAt(0));
  } else {
    return const TextStyle();
  }
}

TextStyle getAppTextStyleByVariant(AppTextVariant appTextVariant) {
  TextStyle baseStyle = getFontSizeAndLineHeightByVariant(
    appTextVariant,
  );

  switch (appTextVariant) {
    case AppTextVariant.biggerTitle:
      return const TextStyle(fontWeight: FontWeight.w700).merge(baseStyle);
    case AppTextVariant.bigger:
      return const TextStyle(fontWeight: FontWeight.w300).merge(baseStyle);
    case AppTextVariant.h1:
    case AppTextVariant.h2:
    case AppTextVariant.h3:
    case AppTextVariant.h4:
      return const TextStyle(fontWeight: FontWeight.w700).merge(baseStyle);
    case AppTextVariant.title:
    case AppTextVariant.title2:
      return const TextStyle(fontWeight: FontWeight.w700).merge(baseStyle);
    case AppTextVariant.text:
    case AppTextVariant.text1:
    case AppTextVariant.text2:
    case AppTextVariant.button:
      return const TextStyle(fontWeight: FontWeight.w400).merge(baseStyle);
    case AppTextVariant.input:
    case AppTextVariant.inputTitle:
      return const TextStyle(fontWeight: FontWeight.w700).merge(baseStyle);
    case AppTextVariant.subtitle:
    case AppTextVariant.subtitle1:
    case AppTextVariant.subtitle2:
    case AppTextVariant.regular:
    case AppTextVariant.menu:
      return const TextStyle(fontWeight: FontWeight.w500).merge(baseStyle);
    case AppTextVariant.number:
      return const TextStyle(fontWeight: FontWeight.w500).merge(baseStyle);
    case AppTextVariant.small:
      return const TextStyle(fontWeight: FontWeight.w900).merge(baseStyle);
    default:
      return const TextStyle().merge(baseStyle);
  }
}
