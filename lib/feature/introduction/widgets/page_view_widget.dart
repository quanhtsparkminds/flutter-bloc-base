import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class PageViewWidget extends StatelessWidget {
  final Widget image;
  final String title;
  final String subTitle;
  final String? textButton;
  final Function() onPressed;
  final int currentPage;

  const PageViewWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      this.textButton,
      required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(child: image),
        ),
        Positioned(
            bottom: 0,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: Screens.getHeight(context) / 2,
                    width: Screens.getWidth(context),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(Assets.svg.blurButtom,
                                fit: BoxFit.cover,
                                height: Screens.getWidth(context) / 1.2)),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(Assets.svg.blurButton2,
                                fit: BoxFit.cover,
                                height: Screens.getWidth(context) / 1.2)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.x20,
                              vertical: AppSpacing.x48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextCustom(
                                title,
                                variant: AppTextVariant.biggerTitle,
                                style: TextStyle(color: AppColors.white),
                              ),
                              AppSizedBox.square40,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.x40),
                                child: TextCustom(
                                  subTitle,
                                  variant: AppTextVariant.button,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              AppSizedBox.square60,
                              AppButton(
                                title:
                                    textButton ?? TranslationKeys.getStarted.tr,
                                variant: AppButtonVariant.ghost,
                                onPressed: onPressed,
                              ),
                              SizedBox(
                                  height:
                                      Screens.resizeFitDevice(context, 100)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
