part of 'login_email_cubit.dart';

@freezed
class LoginWithEmailState with _$LoginWithEmailState {
  const factory LoginWithEmailState.initial() = _LoginWithEmailState;

  const factory LoginWithEmailState.enableButton(bool input) =
      _EnableButtonState;

  const factory LoginWithEmailState.processing() = ProcessingState;

  const factory LoginWithEmailState.endProcess() = EndProcessingState;

  const factory LoginWithEmailState.neutral() = NeutralState;
}
