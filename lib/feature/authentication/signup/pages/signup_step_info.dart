import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/constants/widget_key.dart';
import 'package:myapp/feature/authentication/signup/signup_cubit/signup_cubit.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_checkbox/app_check_box.dart';
import 'package:myapp/shared/widgets/app_image/app_images.dart';
import 'package:myapp/shared/widgets/app_image/image.type.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';
import 'package:myapp/shared/widgets/padding.dart';

class SignupInfoView extends StatelessWidget {
  final SignupCubit bloc;
  const SignupInfoView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return Container(
        padding: getScreensPadding(context).copyWith(top: AppSpacing.x20),
        child: BodyWrappedWithChild(
          child: Column(
            children: [
              AppSizedBox.square16,
              Expanded(
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: bloc.formKeyInfo,
                    initialValue: {
                      bloc.formFieldNames[FormFieldName.emailInfo]!: '',
                      bloc.formFieldNames[FormFieldName.phoneInfo]!: '',
                    },
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => bloc.imagePicker(context),
                          child: bloc.documentFile.path.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(AppSpacing.x30)
                                      .copyWith(bottom: AppSpacing.x36),
                                  height: AppSpacing.x100,
                                  width: AppSpacing.x100,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgImage.withOpacity(.6),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(AppSpacing.x60)),
                                  ),
                                  child: AppImageView(
                                    imagePath: bloc.documentFile.path.isEmpty
                                        ? Assets.images.awesomeCamera.path
                                        : bloc.documentFile.path,
                                    key: WidgetKey.bottomTabBarHeaderAvatar.key,
                                    width: AppSpacing.x36,
                                    height: AppSpacing.x30,
                                    imageType: ImageType.png,
                                  ),
                                )
                              : AppImageView(
                                  imagePath: bloc.documentFile.path,
                                  key: WidgetKey.bottomTabBarHeaderAvatar.key,
                                  height: AppSpacing.x100,
                                  width: AppSpacing.x100,
                                  imageType: ImageType.file,
                                  border: Border.all(
                                      width: 0, color: AppColors.transparent),
                                  radius: const BorderRadius.all(
                                      Radius.circular(AppSpacing.x50)),
                                ),
                        ),
                        AppSizedBox.square20,
                        CustomTextFormField(
                          controller: bloc.fullNameController,
                          hintText: TranslationKeys.fullName.tr,
                          fieldKey: bloc.formFieldKeys[FormFieldName.fullname]!,
                          focusNode: bloc.fullNameFocusNode,
                          name: bloc.formFieldNames[FormFieldName.fullname]!,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: TranslationKeys.validateRequired.tr),
                            FormBuilderValidators.maxLength(
                                TlLengthFiled.maxLength50,
                                errorText: TranslationKeys.validateMaxLength
                                    .trParams({
                                  'maxLength':
                                      TlLengthFiled.maxLength50.toString()
                                })),
                          ]),
                        ),
                        AppSizedBox.square10,
                        CustomTextFormField(
                          hintText: TranslationKeys.lablePhone.tr,
                          fieldKey:
                              bloc.formFieldKeys[FormFieldName.phoneInfo]!,
                          keyboardType: TextInputType.phone,
                          controller: bloc.phoneController,
                          enabled: !bloc.isDisablePhoneNumber,
                          formatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\+?\d*$'))
                          ],
                          name: bloc.formFieldNames[FormFieldName.phoneInfo]!,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: TranslationKeys.validateRequired.tr),
                            FormBuilderValidators.match(
                                AppRegex.phoneNumber.pattern,
                                errorText:
                                    TranslationKeys.validatePhoneNumber.tr),
                          ]),
                        ),
                        AppSizedBox.square10,
                        CustomTextFormField(
                          hintText: TranslationKeys.emailText.tr,
                          fieldKey:
                              bloc.formFieldKeys[FormFieldName.emailInfo]!,
                          keyboardType: TextInputType.emailAddress,
                          name: bloc.formFieldNames[FormFieldName.emailInfo]!,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: TranslationKeys.validateRequired.tr),
                            FormBuilderValidators.match(
                                AppRegex.emailRegex.pattern,
                                errorText: TranslationKeys.validateEmail.tr),
                          ]),
                          controller: bloc.emailController,
                          enabled: !bloc.isDisableEmail,
                        ),
                        AppSizedBox.square10,
                        CustomTextFormField(
                          controller: bloc.pwController,
                          hintText: TranslationKeys.pwText.tr,
                          fieldKey: bloc.formFieldKeys[FormFieldName.password]!,
                          focusNode: bloc.pwFocusNode,
                          name: bloc.formFieldNames[FormFieldName.password]!,
                          obscureText: bloc.innerObscurePw,
                          isObscureIcon: bloc.innerObscurePw,
                          onSuffixIconPressed: () =>
                              bloc.innerObsureIcon(FormFieldName.password),
                          suffixIcon: Icon(
                            bloc.innerObscurePw
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                            color: Colors.grey.withOpacity(.9),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: TranslationKeys.validateRequired.tr),
                            FormBuilderValidators.match(
                                AppRegex.password.pattern,
                                errorText:
                                    TranslationKeys.validatePasswordOnLogin.tr),
                          ]),
                        ),
                        AppSizedBox.square10,
                        CustomTextFormField(
                          controller: bloc.confirmPwController,
                          hintText: TranslationKeys.pwConfirmText.tr,
                          fieldKey: bloc
                              .formFieldKeys[FormFieldName.confirmPassword]!,
                          focusNode: bloc.confirmPwFocusNode,
                          name: bloc
                              .formFieldNames[FormFieldName.confirmPassword]!,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: bloc.innerObscureConfirmPw,
                          isObscureIcon: bloc.innerObscureConfirmPw,
                          onSuffixIconPressed: () => bloc
                              .innerObsureIcon(FormFieldName.confirmPassword),
                          suffixIcon: Icon(
                            bloc.innerObscureConfirmPw
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                            color: Colors.grey.withOpacity(.9),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: TranslationKeys.validateRequired.tr),
                            (value) {
                              return value ==
                                      bloc.formFieldKeys[FormFieldName.password]
                                          ?.currentState?.value
                                  ? null
                                  : TranslationKeys.validateConfirmPassword.tr;
                            }
                          ]),
                        ),
                        AppSizedBox.square60,
                        CustomAppCheckbox(
                            name: 'checkbox',
                            size: AppSpacing.x18,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppSizedBox.square4,
                            suffixWidget: TextCustom(
                              TranslationKeys.agreeSingupInfoText.tr,
                              variant: AppTextVariant.button,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textDarkCustom),
                            ),
                            onChanged: (p0) =>
                                bloc.onSelectCheckBox(p0 ?? false),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction),
                        AppSizedBox.square20,
                        AppButton(
                          title: TranslationKeys.signup.tr,
                          onPressed: bloc.isEnableButtonSignupInfo
                              ? () => bloc.handleFunctionSubmitOtp(context)
                              : null,
                        ),
                        AppSizedBox.square24,
                        SignUpWidgets.footerWithText(
                            onPressed: () {},
                            textPrefix: TranslationKeys.alreadyHaveAnAccount.tr,
                            textSuffix: ' ${TranslationKeys.signin.tr} !'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
