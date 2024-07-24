part of 'login_phone_cubit.dart';

@freezed
class LoginWithPhoneState with _$LoginWithPhoneState {
  const factory LoginWithPhoneState.initial() = _LoginWithPhoneState;

  const factory LoginWithPhoneState.pageView(SigninPhoneSteps step) =
      _SinginPhoneSteps;

  const factory LoginWithPhoneState.enablePhoneBtn(bool input) =
      _EnableValidPhoneState;

  const factory LoginWithPhoneState.processing() = ProcessingState;

  const factory LoginWithPhoneState.endProcess() = EndProcessingState;

  const factory LoginWithPhoneState.neutral() = NeutralState;
}
