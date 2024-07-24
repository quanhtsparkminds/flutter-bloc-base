import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/constants/widget_key.dart';
import 'package:myapp/feature/authentication/login_with_email/login_email_cubit/login_email_cubit.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_checkbox/app_check_box.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';
import 'package:myapp/shared/widgets/padding.dart';

class LoginWithEmailView extends StatefulWidget {
  const LoginWithEmailView({super.key});

  @override
  State<LoginWithEmailView> createState() => _LoginWithEmailViewState();
}

class _LoginWithEmailViewState extends State<LoginWithEmailView> {
  late LoginEmailCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEmailCubit, LoginWithEmailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(
            context,
            title: 'Sign in',
            leadingType: LeadingType.back,
            action: [const Offstage()],
            leadingPress: () => NavigateBackCommand().run(),
          ),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSizedBox.square60,
                        TextCustom(
                          'Welcome Back!',
                          variant: AppTextVariant.title,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        TextCustom(
                          'Sign in to continue',
                          variant: AppTextVariant.text,
                          style: TextStyle(color: AppColors.greyStrong),
                        ),
                        AppSizedBox.square20,
                        BodyWrappedWithChild(
                            child: FormBuilder(
                          key: _bloc.formKeyLogin,
                          child: Column(
                            children: [
                              AppSizedBox.square20,
                              TextCustom(
                                'Account Created!',
                                variant: AppTextVariant.title,
                                style: TextStyle(color: AppColors.greyStrong),
                              ),
                              AppSizedBox.square20,
                              AppSizedBox.square24,
                              CustomTextFormField(
                                controller: _bloc.emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                hintText: TranslationKeys.placeholderEmail.tr,
                                fieldKey:
                                    _bloc.formFieldKeys[FormFieldNames.email]!,
                                name:
                                    _bloc.formFieldNames[FormFieldNames.email]!,
                                prefixIcon: SvgPicture.asset(
                                  Assets.svg.mailBox,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.primaryColor, BlendMode.srcIn),
                                ),
                                onChange: _bloc.onFullFiledUsername,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText:
                                          TranslationKeys.validateRequired.tr),
                                  FormBuilderValidators.match(
                                      AppRegex.emailRegex.pattern,
                                      errorText:
                                          TranslationKeys.validateEmail.tr),
                                  FormBuilderValidators.maxLength(
                                      TlLengthFiled.maxLength100,
                                      errorText: TranslationKeys
                                          .validateMaxLength
                                          .trParams({
                                        'maxLength': TlLengthFiled.maxLength100
                                            .toString()
                                      })),
                                ]),
                              ),
                              AppSizedBox.square24,
                              CustomTextFormField(
                                controller: _bloc.passwordController,
                                keyboardType: TextInputType.text,
                                hintText:
                                    TranslationKeys.placeholderPassword.tr,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText:
                                          TranslationKeys.validateRequired.tr),
                                  FormBuilderValidators.match(
                                      AppRegex.password.pattern,
                                      errorText: TranslationKeys
                                          .validatePasswordOnSignUp.tr),
                                ]),
                                onChange: _bloc.onFullFiledPassword,
                                fieldKey: _bloc
                                    .formFieldKeys[FormFieldNames.password]!,
                                name: _bloc
                                    .formFieldNames[FormFieldNames.password]!,
                                prefixIcon: SvgPicture.asset(Assets.svg.looked),
                                obscureText: true,
                                isObscureIcon: true,
                              ),
                              AppSizedBox.square24,
                              SizedBox(
                                height: AppSpacing.x50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomAppCheckbox(
                                          name: 'checkbox',
                                          size: AppSpacing.x18,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: AppSizedBox.square4,
                                          suffixWidget: TextCustom(
                                            'Remember me',
                                            variant: AppTextVariant.button,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textDarkCustom),
                                          ),
                                          onChanged: (p0) => _bloc
                                              .onSelectCheckBox(p0 ?? false),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction),
                                    ),
                                    InkWell(
                                      onTap: _bloc.handleForgotPassword,
                                      key: WidgetKey
                                          .loginForgotPasswordButton.key,
                                      child: TextCustom(
                                          TranslationKeys.forgotPassText.tr,
                                          variant: AppTextVariant.button,
                                          style: TextStyle(
                                            color: AppColors.persianBlue,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              AppSizedBox.square30,
                              AppButton(
                                title: 'Sign in',
                                onPressed: _bloc.enableSigninButton
                                    ? () => _bloc.loginWithEmail(context)
                                    : null,
                              ),
                              AppSizedBox.square36,
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                SignUpWidgets.footerWithText(
                    textPrefix: 'Already have not an account? ',
                    textSuffix: 'Sign up !')
              ],
            ),
          ),
        );
      },
    );
  }
}
