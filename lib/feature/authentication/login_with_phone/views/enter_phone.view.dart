import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/authentication/login_with_phone/login_phone_cubit/login_phone_cubit.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';

class EnterPhoneView extends StatelessWidget {
  final LoginPhoneCubit bloc;
  const EnterPhoneView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPhoneCubit, LoginWithPhoneState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            BodyWrappedWithChild(
              child: Padding(
                padding: const EdgeInsets.symmetric()
                    .copyWith(top: AppSpacing.x40, bottom: AppSpacing.x20),
                child: Column(
                  children: [
                    TextCustom(
                      TranslationKeys.login.tr,
                      variant: AppTextVariant.title,
                    ),
                    TextCustom(
                      TranslationKeys.signinWithPhoneContent.tr,
                      variant: AppTextVariant.title2,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyStrong),
                    ),
                    AppSizedBox.square24,
                    FormBuilder(
                      key: bloc.formKeyPhone,
                      child: CustomTextFormField(
                        controller: bloc.phoneController,
                        focusNode: bloc.phoneFocusNode,
                        hintText: TranslationKeys.placeholderPhoneNumber.tr,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: TranslationKeys.validateRequired.tr),
                          FormBuilderValidators.match(
                              AppRegex.phoneNumber.pattern,
                              errorText:
                                  TranslationKeys.validatePhoneNumber.tr),
                        ]),
                        onChange: bloc.onChangedPhone,
                        formatter: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\+?\d*$'),
                          )
                        ],
                        keyboardType: TextInputType.phone,
                        prefixIcon: Assets.icons.bangladesh
                            .image(width: AppSpacing.x28),
                        suffixIcon: bloc.isValidPhone
                            ? SvgPicture.asset(Assets.svg.markCheckPw)
                            : null,
                        fieldKey: bloc.formFieldKeys[FormFieldNames.phone]!,
                        name: bloc.formFieldNames[FormFieldNames.phone]!,
                      ),
                    ),
                    AppSizedBox.square30,
                    AppButton(
                      title: TranslationKeys.signinLower.tr,
                      onPressed: bloc.isValidPhone
                          ? () => bloc.handleRequestPhoneOtp(context)
                          : null,
                    ),
                    AppSizedBox.square36,
                  ],
                ),
              ),
            ),
            AppSizedBox.square36,
            SignUpWidgets.footerWithText(
                onPressed: () {},
                textPrefix: TranslationKeys.haveNotAnAccount.tr,
                textSuffix: ' ${TranslationKeys.signupLower.tr}')
          ],
        ),
      );
    });
  }
}
