part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _ForgotPasswordState;

  const factory ForgotPasswordState.pageView(ForgotPasswordSteps step) =
      _ForgotPasswordStateSteps;

  const factory ForgotPasswordState.enableValidFields(bool input) =
      _EnableValidFieldsState;
  const factory ForgotPasswordState.innerPw(bool input) = _InnerPwState;

  const factory ForgotPasswordState.innerConfirmPw(bool input) =
      _InnerConfimPwState;

  const factory ForgotPasswordState.processing() = ProcessingState;

  const factory ForgotPasswordState.endProcess() = EndProcessingState;

  const factory ForgotPasswordState.neutral() = NeutralState;
}
