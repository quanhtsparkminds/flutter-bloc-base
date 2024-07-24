import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/feature/authentication/signup/types/signup.type.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/services/helper_service.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/utils/universal_file/validate_file.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_button/app_countdown_button.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.types.dart';
import 'package:myapp/shared/widgets/app_language/country.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';

part 'signup_state.dart';
part 'signup_cubit.freezed.dart';

enum FormFieldName {
  phone,
  email,
  search,
  fullname,
  password,
  confirmPassword,
  emailInfo,
  phoneInfo,
}

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState.initial());

  SignupStep _signupStep = SignupStep.enterUsername;
  bool get isFirstStep =>
      _signupStep == SignupStep.enterUsername ||
      _signupStep == SignupStep.signupSuccess;
  bool get isLastStep => _signupStep == SignupStep.signupSuccess;

  SignupStep get signupStep => _signupStep;
  final AppCountdownButtonController cdController =
      AppCountdownButtonController();

  CountryResidence _country = CountryResidence.unknown;
  CountryResidence get countrySelect => _country;
  final List<CountryResidence> _countries = CountryResidence.values
      .where((element) => element != CountryResidence.unknown)
      .toList();
  List<CountryResidence> get listCountries => _countries;

  List<AppDropdownItem> listCity = [];
  List<AppDropdownItem> listAreas = [];

  File _documentFile = File('');
  File get documentFile => _documentFile;

  final GlobalKey<FormBuilderState> formKeyLogin =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> formKeyInfo = GlobalKey<FormBuilderState>();

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final FocusNode _emailFocusNode = FocusNode();
  FocusNode get emailFocusNode => _emailFocusNode;

  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final FocusNode _phoneFocusNode = FocusNode();
  FocusNode get phoneFocusNode => _phoneFocusNode;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  final FocusNode _searchFocusNode = FocusNode();
  FocusNode get searchFocusNode => _searchFocusNode;

  final TextEditingController _fullNameController = TextEditingController();
  TextEditingController get fullNameController => _fullNameController;
  final FocusNode _fullNameFocusNode = FocusNode();
  FocusNode get fullNameFocusNode => _fullNameFocusNode;

  final TextEditingController _pwController = TextEditingController();
  TextEditingController get pwController => _pwController;
  final FocusNode _pwFocusNode = FocusNode();
  FocusNode get pwFocusNode => _pwFocusNode;

  final TextEditingController _confirmPwController = TextEditingController();
  TextEditingController get confirmPwController => _confirmPwController;
  final FocusNode _confirmPwFocusNode = FocusNode();
  FocusNode get confirmPwFocusNode => _confirmPwFocusNode;

  final TextEditingController _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;
  final FocusNode _otpFocusNode = FocusNode();
  FocusNode get otpFocusNode => _otpFocusNode;

  bool _innerObscurePw = true;
  bool get innerObscurePw => _innerObscurePw;

  bool _innerObscureConfirmPw = true;
  bool get innerObscureConfirmPw => _innerObscureConfirmPw;

  void innerObsureIcon(FormFieldName nameField) {
    switch (nameField) {
      case FormFieldName.password:
        _innerObscurePw = !_innerObscurePw;
        emit(SignupState.innerPw(_innerObscurePw));
        break;
      case FormFieldName.confirmPassword:
        _innerObscureConfirmPw = !_innerObscureConfirmPw;
        emit(SignupState.innerConfirmPw(innerObscureConfirmPw));
        break;
      default:
    }
  }

  final Map<FormFieldName, String> formFieldNames = {
    FormFieldName.phone: 'phone',
    FormFieldName.email: 'email',
    FormFieldName.emailInfo: 'emailInfo',
    FormFieldName.phoneInfo: 'phoneInfo',
    FormFieldName.fullname: 'fullname',
    FormFieldName.search: 'search',
    FormFieldName.password: 'password',
    FormFieldName.confirmPassword: 'confirmPassword',
  };
  late Map<FormFieldName, GlobalKey<FormBuilderFieldState>> formFieldKeys =
      formFieldNames.map(
    (key, value) => MapEntry(key, GlobalKey<FormBuilderFieldState>()),
  );

  void initState() {}

  void handleSignupStep1(BuildContext context) {
    final isValid = formKeyLogin.currentState?.saveAndValidate() ?? false;
    FocusScope.of(context).unfocus();
    if (!isValid || !isEnableButtonSignin) {
      return;
    }
    goToNextStep(context);
  }

  bool get isEnableButtonSignin {
    bool isValidEmail = AppRegex.emailRegex.hasMatch(emailController.text) &&
        isMaxLength(emailController.text, TlLengthFiled.maxLength100);
    bool isValidPhone = AppRegex.phoneNumber.hasMatch(phoneController.text);
    return (isValidEmail || isValidPhone);
  }

  void handleSelectCountry(CountryResidence item) {
    _country = item;
    emit(SignupState.selectCountry(_country));
  }

  void goToNextStep(BuildContext context) {
    SignupStep? nextStep = _signupStep.nextEnum;
    FocusScope.of(context).unfocus();
    if (nextStep != null) {
      _signupStep = nextStep;
      _mapSignupStepToState(signupStep);
      emit(SignupState.pageView(nextStep));
    }
  }

  void goToPreviousStep(BuildContext context) {
    SignupStep? prevStep = _signupStep.prevEnum;
    FocusScope.of(context).unfocus();
    if (prevStep == null) {
      NavigateBackCommand().run();
      return;
    } else {
      _signupStep = prevStep;
      _mapSignupStepToState(signupStep);
      emit(SignupState.pageView(prevStep));
    }
  }

  void _mapSignupStepToState(SignupStep step) {
    switch (step) {
      case SignupStep.enterUsername:
        break;
      case SignupStep.chooseCountry:
      case SignupStep.chooseLocation:
        break;
      case SignupStep.enterInfo:
        _innerObscurePw = true;
        _innerObscureConfirmPw = true;
        cdController.stop();
        break;
      case SignupStep.verifyOtpPhone:
        cdController.restart();
        break;
      case SignupStep.signupSuccess:
        break;
    }
  }

  Future<void> imagePicker(BuildContext context) async {
    try {
      final ImagePicker imagePicker = HelperService.picker;
      XFile? xFile;
      xFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;
      if (lookupMimeType(xFile.path) == 'image/heic' ||
          lookupMimeType(xFile.path) == 'image/heif') {
        await HeicToJpg.convert(xFile.path).then((value) {
          xFile = XFile(value!);
        });
      }
      final fileSize = getFilesSizeInMB(input: xFile!, decimals: 5);
      if (fileSize < Constants.fileRegiterSize) {
        if (formatMimeTypeFile(xFile!.path)) {
          _documentFile = File(xFile!.path);
        } else {
          return;
        }
      } else {
        if (!context.mounted) {
          return;
        }
        showMessageDialog(context,
            title: TranslationKeys.selectFileFailed.tr,
            message: TranslationKeys.invalidFileUpload.trParams({'mb': '5'}),
            buttons: [
              Expanded(
                child: AppButton(
                    title: TranslationKeys.cancel.tr,
                    style: ButtonStyles.buttonPopupStyle,
                    variant: AppButtonVariant.primaryAmber,
                    onPressed: () {
                      return Navigator.of(context, rootNavigator: true)
                          .pop(false);
                    }),
              ),
              AppSizedBox.square10,
              Expanded(
                child: AppButton(
                    title: 'Ok',
                    style: ButtonStyles.buttonPopupStyle,
                    onPressed: () {
                      return Navigator.of(context, rootNavigator: true)
                          .pop(true);
                    }),
              ),
            ]);

        return;
      }
    } on PlatformException {
      if (!context.mounted) {
        return;
      }
      await HelperService.catchPermisionImage(context);
    }
  }

  // Signup infor
  bool _isAgreePolicySingup = false;
  bool get isAgreePolicySingup => _isAgreePolicySingup;

  onSelectCheckBox(bool output) {
    _isAgreePolicySingup = output;
  }

  bool get isEnableButtonSignupInfo {
    bool isValidFullName =
        isMaxLength(fullNameController.text, TlLengthFiled.maxLength50);
    bool isValidPw = AppRegex.password.hasMatch(_pwController.text) &&
        isMaxLength(_pwController.text, TlLengthFiled.maxLength24);
    bool isValidConfirmPw = _pwController.text == confirmPwController.text;
    return isValidFullName &&
        isValidPw &&
        isValidConfirmPw &&
        isAgreePolicySingup;
  }

  // VERIFY OTP

  bool get enableOtpBtn {
    return _otpController.text.length == Constants.passcodeLength;
  }

  void submitSentOtp(BuildContext context) {
    if (enableOtpBtn) {
      goToNextStep(context);
    }
  }

  Future<bool> resendCode(BuildContext context) async {
    bool? isOK = await showMessageDialog(context,
        title: TranslationKeys.notReceiveCode.tr,
        message: '',
        messageWidget: SignUpWidgets.authMessWithPhone(
            textPrefix: TranslationKeys.authMess.trParams({'param': ''}),
            textSuffix: username),
        buttons: [
          Expanded(
            child: AppButton(
                title: TranslationKeys.cancel.tr,
                style: ButtonStyles.buttonPopupStyle,
                variant: AppButtonVariant.primaryAmber,
                onPressed: () {
                  return Navigator.of(context, rootNavigator: true).pop(false);
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

  Future handleFunctionSubmitOtp(BuildContext context) async {
    final isValidForm = formKeyInfo.currentState?.saveAndValidate() ?? false;
    if (!isValidForm || !isEnableButtonSignupInfo) {
      return;
    }
    goToNextStep(context);
  }

  startProcess() {
    emit(const SignupState.processing());
  }

  endLoading() {
    emit(const SignupState.endProcess());
  }

  bool get isDisablePhoneNumber {
    bool isDisable = (emailController.text.isNotEmpty) ? false : true;
    emit(SignupState.disbleFieldsEmail(isDisable));
    return isDisable;
  }

  bool get isDisableEmail {
    bool isDisable = (phoneController.text.isNotEmpty) ? false : true;
    emit(SignupState.disbleFieldsPhone(isDisable));
    return isDisable;
  }

  String get username => phoneController.text.isEmpty
      ? emailController.text
      : phoneController.text;
}
