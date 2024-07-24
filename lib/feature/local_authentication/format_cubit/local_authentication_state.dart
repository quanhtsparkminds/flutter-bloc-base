part of 'local_authentication_cubit.dart';

@freezed
class LocalAuthenticationState with _$LocalAuthenticationState {
  const factory LocalAuthenticationState.initial() = _LocalAuthenticationState;

  const factory LocalAuthenticationState.processing() = ProcessingState;

  const factory LocalAuthenticationState.endProcess() = EndProcessingState;

  const factory LocalAuthenticationState.neutral() = NeutralState;

  const factory LocalAuthenticationState.enableVariable(bool input) =
      _EnableVariableState;
}
