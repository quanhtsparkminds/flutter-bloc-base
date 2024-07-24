part of 'setup_localauth_cubit.dart';

@freezed
class SetupLocalAuthState with _$SetupLocalAuthState {
  const factory SetupLocalAuthState.initial() = _SetupLocalAuthState;

  const factory SetupLocalAuthState.processing() = ProcessingState;

  const factory SetupLocalAuthState.endProcess() = EndProcessingState;

  const factory SetupLocalAuthState.neutral() = NeutralState;

  const factory SetupLocalAuthState.enableButton(bool input) =
      _EnableValidFieldsState;
}
