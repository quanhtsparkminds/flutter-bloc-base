// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/constants/widget_key.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class TextButtonModel {
  String? title;
  Function()? onPress;
  TextButtonModel({this.title, this.onPress});
}

Future<T?>? showMessageDialog<T>(
  BuildContext ctx, {
  required String title,
  Widget? titleWidget,
  Widget? messageWidget,
  String? message,
  WidgetBuilder? additionalInformation,
  List<Widget>? buttons,
  bool dismissible = true,
  Function()? onPressedOk,
}) {
  return showCupertinoDialog<T>(
    barrierDismissible: dismissible,
    context: ctx,
    builder: (context) {
      return Center(
        key: WidgetKey.showPopup.key,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSpacing.x10)),
            child: Container(
              width: MediaQuery.of(context).size.width - AppSpacing.x30 * 2,
              padding: const EdgeInsets.all(AppSpacing.x16)
                  .copyWith(top: AppSpacing.x0, bottom: AppSpacing.x0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  titleWidget ??
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.x24)
                            .copyWith(bottom: 0),
                        child: TextCustom(
                          title,
                          variant: AppTextVariant.button,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.titleColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  AppSizedBox.square10,
                  messageWidget ??
                      TextCustom(
                        message ?? '',
                        variant: AppTextVariant.button,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w400),
                      ),
                  Container(
                    margin: const EdgeInsets.all(AppSpacing.x16)
                        .copyWith(top: AppSpacing.x30, bottom: AppSpacing.x30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buttons ??
                          [
                            Expanded(
                              child: AppButton(
                                  title: 'Ok',
                                  style: ButtonStyles.buttonPopupStyle,
                                  onPressed: onPressedOk?.call() ??
                                      () => Navigator.of(context).pop()),
                            ),
                          ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).then((value) {
    return value;
  });
}

Future<T?>? showInfoDialog<T>(
  BuildContext context, {
  required String title,
  required String message,
  WidgetBuilder? additionalInformation,
  List<Widget>? buttons,
  bool dismissible = true,
  String? titleButton,
  Function()? onPressedOk,
}) {
  return showCupertinoDialog<T>(
    barrierDismissible: dismissible,
    context: context,
    builder: (context) {
      return Center(
        key: WidgetKey.showPopup.key,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.x5)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - AppSpacing.x30 * 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSpacing.x5),
                          topRight: Radius.circular(AppSpacing.x5))),
                  width: MediaQuery.of(context).size.width - AppSpacing.x30 * 2,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.x16, horizontal: AppSpacing.x20),
                  child: TextCustom(
                    title,
                    variant: AppTextVariant.title2,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.x24)
                      .copyWith(bottom: AppSpacing.x6),
                  child: TextCustom(
                    message,
                    variant: AppTextVariant.button,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.greyStrong,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.x16)
                      .copyWith(top: AppSpacing.x25, bottom: AppSpacing.x25),
                  margin:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.x40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buttons ??
                        [
                          Expanded(
                            child: AppButton(
                                title: titleButton ?? 'OK',
                                style: ButtonStyles.buttonPopupStyle,
                                onPressed: onPressedOk ??
                                    () => Navigator.of(context).pop()),
                          ),
                        ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
