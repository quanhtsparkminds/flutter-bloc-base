import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/go_router/routes.types.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class SignupSuccessView extends StatelessWidget {
  const SignupSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSizedBox.square60,
        Center(child: Assets.images.success.image()),
        AppSizedBox.square60,
        Expanded(
          child: Container(
            padding: getScreensPadding(context),
            child: BodyWrappedWithChild(
                child: Column(
              children: [
                AppSizedBox.square20,
                TextCustom(
                  'Account Created!',
                  variant: AppTextVariant.title,
                  style: TextStyle(color: AppColors.greyStrong),
                ),
                AppSizedBox.square20,
                TextCustom(
                  'Your account had beed created successfully.',
                  variant: AppTextVariant.button,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textDark),
                ),
                TextCustom(
                  'Please sign in to use your account and enjoy',
                  variant: AppTextVariant.button,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textDark),
                ),
                AppSizedBox.square30,
                AppButton(
                    title: TranslationKeys.takeMetoSignin.tr,
                    onPressed: () {
                      NavigateToCommand().run(AppRoutes.authenticate.name);
                    }),
                AppSizedBox.square36,
              ],
            )),
          ),
        )
      ],
    );
  }
}
