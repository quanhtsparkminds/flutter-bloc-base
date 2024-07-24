import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/authentication/signup/signup_cubit/signup_cubit.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';
import 'package:myapp/shared/widgets/padding.dart';

class SignupUserNameStepView extends StatefulWidget {
  final SignupCubit bloc;
  const SignupUserNameStepView({super.key, required this.bloc});

  @override
  State<SignupUserNameStepView> createState() => _SignupUserNameStepViewState();
}

class _SignupUserNameStepViewState extends State<SignupUserNameStepView> {
  late SignupCubit _bloc;
  @override
  void initState() {
    _bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return Container(
        padding: getScreensPadding(context)
            .copyWith(top: AppSpacing.x20, bottom: AppSpacing.x16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BodyWrappedWithChild(
                      child: FormBuilder(
                        key: _bloc.formKeyLogin,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.x24,
                                  vertical: AppSpacing.x28),
                              child: _titleWidget(),
                            ),
                            AppSizedBox.square24,
                            CustomTextFormField(
                              controller: _bloc.emailController,
                              hintText: TranslationKeys.placeholderEmail.tr,
                              fieldKey:
                                  _bloc.formFieldKeys[FormFieldName.email]!,
                              prefixIcon: SvgPicture.asset(Assets.svg.mailBox),
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _bloc.emailFocusNode,
                              enabled: _bloc.isDisableEmail,
                              name: _bloc.formFieldNames[FormFieldName.email]!,
                              validator: _bloc.isDisablePhoneNumber
                                  ? null
                                  : FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: TranslationKeys
                                              .validateRequired.tr),
                                      FormBuilderValidators.match(
                                          AppRegex.emailRegex.pattern,
                                          errorText:
                                              TranslationKeys.validateEmail.tr),
                                      FormBuilderValidators.maxLength(
                                          TlLengthFiled.maxLength100,
                                          errorText: TranslationKeys
                                              .validateMaxLength
                                              .trParams({
                                            'maxLength': TlLengthFiled
                                                .maxLength100
                                                .toString()
                                          })),
                                    ]),
                            ),
                            AppSizedBox.square16,
                            _dividerWithText(),
                            AppSizedBox.square16,
                            CustomTextFormField(
                              controller: _bloc.phoneController,
                              focusNode: _bloc.phoneFocusNode,
                              hintText:
                                  TranslationKeys.placeholderPhoneNumber.tr,
                              validator: _bloc.isDisableEmail
                                  ? null
                                  : FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: TranslationKeys
                                              .validateRequired.tr),
                                      FormBuilderValidators.match(
                                          AppRegex.phoneNumber.pattern,
                                          errorText: TranslationKeys
                                              .validatePhoneNumber.tr),
                                    ]),
                              enabled: _bloc.isDisablePhoneNumber,
                              formatter: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\+?\d*$'),
                                )
                              ],
                              keyboardType: TextInputType.phone,
                              prefixIcon: Assets.icons.bangladesh.image(),
                              suffixIcon:
                                  SvgPicture.asset(Assets.svg.markCheckPw),
                              fieldKey:
                                  _bloc.formFieldKeys[FormFieldName.phone]!,
                              name: _bloc.formFieldNames[FormFieldName.phone]!,
                            ),
                            AppSizedBox.square30,
                            AppButton(
                              title: TranslationKeys.signin.tr.toUpperCase(),
                              onPressed: _bloc.isEnableButtonSignin
                                  ? () => _bloc.handleSignupStep1(context)
                                  : null,
                            ),
                            AppSizedBox.square36,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SignUpWidgets.footerWithText(
                onPressed: () {},
                textPrefix: TranslationKeys.alreadyHaveAnAccount.tr,
                textSuffix: ' ${TranslationKeys.signin.tr}')
          ],
        ),
      );
    });
  }

  Widget _titleWidget() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Sign up with\n',
              style: getAppTextStyleByVariant(AppTextVariant.title).copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.greyStrong)),
          TextSpan(
              text: ' email and phone number',
              style: getAppTextStyleByVariant(AppTextVariant.title2).copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textDark)),
        ]));
  }

  Widget _dividerWithText() {
    Color dividerColor = AppColors.greyStrong.withOpacity(.14);
    double thickness = 1;
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: thickness,
            color: dividerColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextCustom(
            TranslationKeys.orText.tr.toUpperCase(),
            variant: AppTextVariant.button,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
