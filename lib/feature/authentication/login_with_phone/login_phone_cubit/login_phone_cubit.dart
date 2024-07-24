import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/feature/authentication/login_with_phone/types/login_phone.type.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/model/main_auth_state.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_button/app_countdown_button.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';
import 'package:myapp/shared/widgets/loader.dart';
import 'package:provider/provider.dart';

part 'login_phone_state.dart';
part 'login_phone_cubit.freezed.dart';

enum FormFieldNames { phone }

class LoginPhoneCubit extends Cubit<LoginWithPhoneState> {
  LoginPhoneCubit() : super(const LoginWithPhoneState.initial());
  late MainAuthState mainAuthState;

  final GlobalKey<FormBuilderState> formKeyPhone =
      GlobalKey<FormBuilderState>();
  final AppCountdownButtonController cdController =
      AppCountdownButtonController();
  SigninPhoneSteps _signinSteps = SigninPhoneSteps.enterPhone;

  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final FocusNode _phoneFocusNode = FocusNode();
  FocusNode get phoneFocusNode => _phoneFocusNode;

  final TextEditingController _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;
  final FocusNode _otpFocusNode = FocusNode();
  FocusNode get otpFocusNode => _otpFocusNode;

  final Map<FormFieldNames, String> formFieldNames = {
    FormFieldNames.phone: 'phone',
  };
  late Map<FormFieldNames, GlobalKey<FormBuilderFieldState>> formFieldKeys =
      formFieldNames.map(
    (key, value) => MapEntry(key, GlobalKey<FormBuilderFieldState>()),
  );

  void initState(BuildContext context) {
    mainAuthState = context.read<MainAuthState>();
  }

  bool _isValidPhone = false;
  bool get isValidPhone => _isValidPhone;
  onChangedPhone(String? value) {
    _isValidPhone = false;
    if (value == null || value.isEmpty) return;
    _isValidPhone = AppRegex.phoneNumber.hasMatch(value);
    emit(LoginWithPhoneState.enablePhoneBtn(isValidPhone));
  }

  void handleRequestPhoneOtp(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_isValidPhone) {
      return;
    }
    goToNextStep(context);
  }

  void goToNextStep(BuildContext context) {
    SigninPhoneSteps? nextStep = _signinSteps.nextEnum;
    FocusScope.of(context).unfocus();
    if (nextStep != null) {
      _signinSteps = nextStep;
      _mapSignupStepToState(_signinSteps);
      emit(LoginWithPhoneState.pageView(nextStep));
    }
  }

  void goToPreviousStep(BuildContext context) {
    SigninPhoneSteps? prevStep = _signinSteps.prevEnum;
    FocusScope.of(context).unfocus();
    if (prevStep == null) {
      NavigateBackCommand().run();
      return;
    } else {
      _signinSteps = prevStep;
      _mapSignupStepToState(_signinSteps);
      emit(LoginWithPhoneState.pageView(prevStep));
    }
  }

  void _mapSignupStepToState(SigninPhoneSteps step) {
    switch (step) {
      case SigninPhoneSteps.enterPhone:
        cdController.stop();
        _phoneFocusNode.requestFocus();
        break;
      case SigninPhoneSteps.verifyOtp:
        _otpController.clear();
        _otpFocusNode.requestFocus();
        cdController.restart();
        break;
    }
  }

  Future<bool> resendCode(BuildContext context) async {
    bool? isOK = await showMessageDialog(context,
        title: TranslationKeys.notReceiveCode.tr,
        message: '',
        messageWidget: SignUpWidgets.authMessWithPhone(
            textPrefix: TranslationKeys.authMess.trParams({'param': ''}),
            textSuffix: phone),
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
                  return Navigator.of(context, rootNavigator: true).pop(true);
                }),
          ),
        ]);
    return isOK ?? false;
  }

  bool _isValidOtp = false;
  bool get isValidOtp => _isValidOtp;
  onFullFiledOtp(String? value) {
    _isValidOtp = false;
    if (value == null || value.isEmpty) return;
    _isValidOtp = _otpController.text.length == Constants.passcodeLength;
    emit(LoginWithPhoneState.enablePhoneBtn(_isValidOtp));
  }

  void submitSentOtp(BuildContext context) {
    if (_isValidOtp) {
      goToNextStep(context);
    }
  }

  startProcess() {
    emit(const LoginWithPhoneState.processing());
  }

  endLoading() {
    emit(const LoginWithPhoneState.endProcess());
  }

  SigninPhoneSteps get signinSteps => _signinSteps;
  String get phone => _phoneController.text;
}
