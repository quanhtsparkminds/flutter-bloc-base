part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _SettingsState;

  const factory SettingsState.processing() = ProcessingState;

  const factory SettingsState.endProcess() = EndProcessingState;

  const factory SettingsState.neutral() = NeutralState;
}
