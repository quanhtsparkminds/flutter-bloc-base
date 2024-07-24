import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/feature/forgot_password/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';

class NewPasswordView extends StatelessWidget {
  final ForgotPasswordCubit bloc;
  const NewPasswordView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            BodyWrappedWithChild(
              child: FormBuilder(
                key: bloc.formKeyNewPw,
                child: Column(
                  children: [
                    AppSizedBox.square36,
                    CustomTextFormField(
                      controller: bloc.pwController,
                      hintText: TranslationKeys.pwText.tr,
                      fieldKey: bloc.formFieldKeys[FormFieldNames.newPassword]!,
                      focusNode: bloc.pwFocusNode,
                      name: bloc.formFieldNames[FormFieldNames.newPassword]!,
                      onChange: bloc.onChangedNewPw,
                      obscureText: bloc.innerObscurePw,
                      isObscureIcon: bloc.innerObscurePw,
                      onSuffixIconPressed: () =>
                          bloc.innerObsureIcon(FormFieldNames.newPassword),
                      suffixIcon: Icon(
                        bloc.innerObscurePw
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 24,
                        color: Colors.grey.withOpacity(.9),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.match(AppRegex.password.pattern,
                            errorText:
                                TranslationKeys.validatePasswordOnLogin.tr),
                      ]),
                    ),
                    AppSizedBox.square10,
                    CustomTextFormField(
                      controller: bloc.confirmPwController,
                      hintText: TranslationKeys.pwConfirmText.tr,
                      fieldKey:
                          bloc.formFieldKeys[FormFieldNames.confirmNewPw]!,
                      focusNode: bloc.confirmPwFocusNode,
                      name: bloc.formFieldNames[FormFieldNames.confirmNewPw]!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChange: bloc.onChangedConfirmNewPw,
                      obscureText: bloc.innerObscureConfirmPw,
                      isObscureIcon: bloc.innerObscureConfirmPw,
                      onSuffixIconPressed: () =>
                          bloc.innerObsureIcon(FormFieldNames.confirmNewPw),
                      suffixIcon: Icon(
                        bloc.innerObscureConfirmPw
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 24,
                        color: Colors.grey.withOpacity(.9),
                      ),
                      validator: FormBuilderValidators.compose([
                        (value) {
                          return value ==
                                  bloc.formFieldKeys[FormFieldNames.newPassword]
                                      ?.currentState?.value
                              ? null
                              : TranslationKeys.validateConfirmPassword.tr;
                        }
                      ]),
                    ),
                    AppSizedBox.square20,
                    AppButton(
                      title: 'Save Now !',
                      onPressed: bloc.isEnableButtonSaveNewPw
                          ? () => bloc.submitChangedNewPasswords(context)
                          : null,
                    ),
                    AppSizedBox.square36,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
