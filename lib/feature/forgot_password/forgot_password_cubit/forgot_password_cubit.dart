import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/feature/forgot_password/types/forgot_pw.type.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_button/app_countdown_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';
import 'package:myapp/shared/widgets/loader.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.freezed.dart';

enum FormFieldNames { email, otp, newPassword, confirmNewPw }

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState.initial());
  final GlobalKey<FormBuilderState> formKeyNewPw =
      GlobalKey<FormBuilderState>();
  final AppCountdownButtonController cdController =
      AppCountdownButtonController();
  ForgotPasswordSteps _forgotPwStep = ForgotPasswordSteps.enterEmail;
  ForgotPasswordSteps get forgotPwStep => _forgotPwStep;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final FocusNode _emailFocusNode = FocusNode();
  FocusNode get emailFocusNode => _emailFocusNode;

  final TextEditingController _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;
  final FocusNode _otpFocusNode = FocusNode();
  FocusNode get otpFocusNode => _otpFocusNode;

  final Map<FormFieldNames, String> formFieldNames = {
    FormFieldNames.email: 'email',
    FormFieldNames.otp: 'otp',
    FormFieldNames.newPassword: 'newPassword',
    FormFieldNames.confirmNewPw: 'confirmNewPw',
  };
  late Map<FormFieldNames, GlobalKey<FormBuilderFieldState>> formFieldKeys =
      formFieldNames.map(
    (key, value) => MapEntry(key, GlobalKey<FormBuilderFieldState>()),
  );

  void goToNextStep(BuildContext context) {
    ForgotPasswordSteps? nextStep = _forgotPwStep.nextEnum;
    FocusScope.of(context).unfocus();
    if (nextStep != null) {
      _forgotPwStep = nextStep;
      _mapSignupStepToState(_forgotPwStep);
      emit(ForgotPasswordState.pageView(nextStep));
    }
  }

  void goToPreviousStep(BuildContext context) {
    ForgotPasswordSteps? prevStep = _forgotPwStep.prevEnum;
    FocusScope.of(context).unfocus();
    if (prevStep == null) {
      NavigateBackCommand().run();
      return;
    } else {
      _forgotPwStep = prevStep;
      _mapSignupStepToState(_forgotPwStep);
      emit(ForgotPasswordState.pageView(prevStep));
    }
  }

  void _mapSignupStepToState(ForgotPasswordSteps step) {
    switch (step) {
      case ForgotPasswordSteps.enterEmail:
        cdController.stop();
        break;
      case ForgotPasswordSteps.verifyOtp:
        cdController.restart();
        _otpController.clear();
        _otpFocusNode.requestFocus();
        _isValidOtp = false;
        break;
      case ForgotPasswordSteps.enterNewPw:
        _innerObscurePw = true;
        _innerObscureConfirmPw = true;
        _pwController.clear();
        _confirmPwController.clear();
        break;
    }
  }

  final TextEditingController _pwController = TextEditingController();
  TextEditingController get pwController => _pwController;
  final FocusNode _pwFocusNode = FocusNode();
  FocusNode get pwFocusNode => _pwFocusNode;

  final TextEditingController _confirmPwController = TextEditingController();
  TextEditingController get confirmPwController => _confirmPwController;
  final FocusNode _confirmPwFocusNode = FocusNode();
  FocusNode get confirmPwFocusNode => _confirmPwFocusNode;

  bool _innerObscurePw = true;
  bool get innerObscurePw => _innerObscurePw;

  bool _innerObscureConfirmPw = true;
  bool get innerObscureConfirmPw => _innerObscureConfirmPw;

  void innerObsureIcon(FormFieldNames nameField) {
    switch (nameField) {
      case FormFieldNames.newPassword:
        _innerObscurePw = !_innerObscurePw;
        emit(ForgotPasswordState.innerPw(_innerObscurePw));
        break;
      case FormFieldNames.confirmNewPw:
        _innerObscureConfirmPw = !_innerObscureConfirmPw;
        emit(ForgotPasswordState.innerConfirmPw(innerObscureConfirmPw));
        break;
      default:
    }
  }

  Future<bool> resendCode(BuildContext context) async {
    bool? isOK = await showMessageDialog(context,
        title: TranslationKeys.notReceiveCode.tr,
        message: '',
        messageWidget: SignUpWidgets.authMessWithPhone(
            textPrefix: TranslationKeys.authMess.trParams({'param': ''}),
            textSuffix: email),
        buttons: [
          Expanded(
            child: AppButton(
                title: TranslationKeys.cancel.tr,
                style: ButtonStyles.buttonPopupStyle,
                variant: AppButtonVariant.primaryAmber,
                onPressed: () async {
                  await showLoader(context, asyncFunction: () async {
                    return Navigator.of(context, rootNavigator: true)
                        .pop(false);
                  });
                }),
          ),
          AppSizedBox.square10,
          Expanded(
            child: AppButton(
                title: TranslationKeys.call.tr,
                style: ButtonStyles.buttonPopupStyle,
                onPressed: () {
                  _isValidOtp = false;
                  _otpController.clear();
                  _otpFocusNode.requestFocus();
                  return Navigator.of(context, rootNavigator: true).pop(true);
                }),
          ),
        ]);
    return isOK ?? false;
  }

  Future<void> handleRequestOtp(BuildContext context) async {
    await showLoader(context, asyncFunction: () async {
      await Future.delayed(2.seconds);
      if (!context.mounted) return;
      showInfoDialog(
        context,
        dismissible: false,
        title: 'Password Reset Email Sent',
        message:
            'An email has been sent to\nyour mail box for resetting password',
        onPressedOk: () {
          Navigator.of(context, rootNavigator: true).pop();
          goToNextStep(context);
        },
      );
    });
  }

  bool _isValidEmailAddress = false;
  bool get isValidEmailAddress => _isValidEmailAddress;
  bool _isValidOtp = false;
  bool get isValidOtp => _isValidOtp;
  bool _isValidNewPw = false;
  bool _isValidConfirmNewPw = false;

  onFullFiledEmail(String? value) {
    _isValidEmailAddress = false;
    if (value == null || value.isEmpty) return;
    _isValidEmailAddress = AppRegex.emailRegex.hasMatch(emailController.text) &&
        isMaxLength(emailController.text, TlLengthFiled.maxLength100);
    emit(ForgotPasswordState.enableValidFields(_isValidEmailAddress));
  }

  onFullFiledOtp(String? value) {
    _isValidOtp = false;
    if (value == null || value.isEmpty) return;
    _isValidOtp = _otpController.text.length == Constants.passcodeLength;
    emit(ForgotPasswordState.enableValidFields(_isValidOtp));
  }

  onChangedNewPw(String? value) {
    _isValidNewPw = false;
    if (value == null || value.isEmpty) return;
    _isValidNewPw = AppRegex.password.hasMatch(_pwController.text) &&
        isMaxLength(_pwController.text, TlLengthFiled.maxLength24);
    emit(ForgotPasswordState.enableValidFields(_isValidNewPw));
    onChangedConfirmNewPw(confirmPwController.text);
  }

  onChangedConfirmNewPw(String? value) {
    _isValidConfirmNewPw = false;
    if (value == null || value.isEmpty) return;
    _isValidConfirmNewPw = _pwController.text == confirmPwController.text;
    emit(ForgotPasswordState.enableValidFields(_isValidConfirmNewPw));
  }

  bool get isEnableButtonSaveNewPw => _isValidConfirmNewPw && _isValidNewPw;

  void submitSentOtp(BuildContext context) {
    if (_isValidOtp) {
      goToNextStep(context);
    }
  }

  Future<void> submitChangedNewPasswords(BuildContext context) async {
    await showLoader(context, asyncFunction: () async {
      await Future.delayed(1.seconds);
      if (isEnableButtonSaveNewPw) {
        NavigateBackCommand().run();
      }
    });
  }

  startProcess() {
    emit(const ForgotPasswordState.processing());
  }

  endLoading() {
    emit(const ForgotPasswordState.endProcess());
  }

  void initState() {}

  String get email => _emailController.text;
}
