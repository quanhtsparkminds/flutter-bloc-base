part of 'signup_cubit.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.initial() = _SignupState;

  const factory SignupState.pageView(SignupStep step) = _SignupSteps;

  const factory SignupState.selectCountry(CountryResidence item) =
      _SelectedCountryState;

  const factory SignupState.disbleFieldsPhone(bool input) =
      _DisbleFieldsPhoneState;

  const factory SignupState.disbleFieldsEmail(bool input) =
      _DisbleFieldsEmailState;

  const factory SignupState.processing() = ProcessingState;

  const factory SignupState.endProcess() = EndProcessingState;

  const factory SignupState.neutral() = NeutralState;

  const factory SignupState.innerPw(bool input) = _InnerPwState;

  const factory SignupState.innerConfirmPw(bool input) = _InnerConfimPwState;
}
