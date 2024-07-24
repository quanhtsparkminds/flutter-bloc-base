import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/go_router/routes.types.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/app_version/app_version.dart';

class AuthenticateView extends StatelessWidget {
  const AuthenticateView({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      context,
      image: Assets.images.mainAuthen
          .image(width: double.infinity, fit: BoxFit.contain),
      title: TranslationKeys.welcome1.tr,
      onPressedRegisterEmail: () {
        NavigateToCommand().run(AppRoutes.loginWithEmail.name);
      },
      onPressedRegisterPhone: () {
        NavigateToCommand().run(AppRoutes.loginWithPhone.name);
      },
      onPressedRegister: () {
        NavigateToCommand().run(AppRoutes.signup.name);
      },
    );
  }

  Widget _page(
    BuildContext context, {
    required Widget image,
    required String title,
    required Function() onPressedRegisterEmail,
    required Function() onPressedRegisterPhone,
    required Function() onPressedRegister,
  }) {
    return Stack(
      children: [
        Scaffold(body: Container(child: image)),
        Positioned(
            bottom: 0,
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
                              height: Screens.getWidth(context) / 1.4)),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(Assets.svg.blurButton2,
                              fit: BoxFit.cover,
                              height: Screens.getWidth(context) / 1.3)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.x40,
                            vertical: AppSpacing.x48),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextCustom(
                              title,
                              variant: AppTextVariant.biggerTitle,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            AppSizedBox.square60,
                            AppButton(
                              title: TranslationKeys.continueWithEmail.tr,
                              variant: AppButtonVariant.ghost,
                              onPressed: onPressedRegisterEmail,
                            ),
                            AppSizedBox.square20,
                            AppButton(
                              title: TranslationKeys.continueWithPhone.tr,
                              variant: AppButtonVariant.secondaryLightSalmon,
                              onPressed: onPressedRegisterPhone,
                            ),
                            AppSizedBox.square40,
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: TranslationKeys.dontHaveAnAccount.tr,
                                  style: getAppTextStyleByVariant(
                                          AppTextVariant.text1)
                                      .copyWith(fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: ' ${TranslationKeys.register.tr}',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = onPressedRegister,
                                  style: getAppTextStyleByVariant(
                                          AppTextVariant.text1)
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.ligthSalmon)),
                            ]))
                          ],
                        ),
                      ),
                      const Positioned(bottom: 40, child: AppVersion()),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
