import 'package:flutter/material.dart';
import 'package:myapp/feature/authentication/login_with_phone/login_phone_cubit/login_phone_cubit.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_countdown_button.dart';
import 'package:myapp/shared/widgets/app_otp_input/app_code_input.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';

class VerifyPhoneView extends StatelessWidget {
  final LoginPhoneCubit bloc;
  const VerifyPhoneView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPhoneCubit, LoginWithPhoneState>(
      builder: (context, state) {
        return Column(
          children: [
            BodyWrappedWithChild(
              child: Column(
                children: [
                  AppSizedBox.square36,
                  TextCustom(
                    TranslationKeys.otpVerificationText.tr,
                    variant: AppTextVariant.h2,
                  ),
                  AppSizedBox.square10,
                  SignUpWidgets.authMessWithPhone(
                      textPrefix:
                          TranslationKeys.authMess.trParams({'param': ''}),
                      textSuffix: bloc.phone),
                  AppCodeInput(
                    controller: bloc.otpController,
                    focusNode: bloc.otpFocusNode,
                    onFullfilled: (otp) => bloc.onFullFiledOtp(otp),
                  ),
                  AppCountdownButton(
                    controller: bloc.cdController,
                    onResend: () => bloc.resendCode(context),
                  ),
                  AppSizedBox.square20,
                  AppButton(
                    title: TranslationKeys.verifyNow.tr,
                    onPressed: bloc.isValidOtp
                        ? () => bloc.submitSentOtp(context)
                        : null,
                  ),
                  AppSizedBox.square36,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
