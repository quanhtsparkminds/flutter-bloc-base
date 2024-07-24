import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class AppNodata extends StatelessWidget {
  final Widget? title;
  final String? textTitle;
  final Widget? subtitle;
  final String? subTextTitle;
  final double? size;
  final Function()? onPressed;
  const AppNodata(
      {super.key,
      this.title,
      this.size,
      this.onPressed,
      this.subtitle,
      this.textTitle,
      this.subTextTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.appNodata.image(),
                  AppSizedBox.square60,
                  title ??
                      TextCustom(
                        textTitle ?? TranslationKeys.nodata.tr,
                        variant: AppTextVariant.h2,
                      ),
                  AppSizedBox.square20,
                  subtitle ??
                      (subTextTitle != null
                          ? TextCustom(
                              subTextTitle ?? TranslationKeys.nodata.tr,
                              variant: AppTextVariant.h2,
                            )
                          : const Offstage()),
                  AppSizedBox.square20,
                  AppButton(title: 'Start Booking', onPressed: onPressed)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
