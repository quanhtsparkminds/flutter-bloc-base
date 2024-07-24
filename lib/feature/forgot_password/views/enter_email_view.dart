import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/forgot_password/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';

class EnterEmailView extends StatelessWidget {
  final ForgotPasswordCubit bloc;
  const EnterEmailView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
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
                        TranslationKeys.forgotPasswordContent1.tr,
                        variant: AppTextVariant.button,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyStrong),
                      ),
                      AppSizedBox.square24,
                      FormBuilder(
                        child: CustomTextFormField(
                          controller: bloc.emailController,
                          hintText: TranslationKeys.placeholderEmail.tr,
                          fieldKey: bloc.formFieldKeys[FormFieldNames.email]!,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: bloc.emailFocusNode,
                          name: bloc.formFieldNames[FormFieldNames.email]!,
                          onChange: bloc.onFullFiledEmail,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: TranslationKeys.validateRequired.tr),
                            FormBuilderValidators.match(
                                AppRegex.emailRegex.pattern,
                                errorText: TranslationKeys.validateEmail.tr),
                            FormBuilderValidators.maxLength(
                                TlLengthFiled.maxLength100,
                                errorText: TranslationKeys.validateMaxLength
                                    .trParams({
                                  'maxLength':
                                      TlLengthFiled.maxLength100.toString()
                                })),
                          ]),
                        ),
                      ),
                      AppSizedBox.square30,
                      AppButton(
                        title: TranslationKeys.sendTitle.tr,
                        onPressed: bloc.isValidEmailAddress
                            ? () => bloc.handleRequestOtp(context)
                            : null,
                      ),
                      AppSizedBox.square16,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
