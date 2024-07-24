part of 'electrician_cubit.dart';

@freezed
class ElectricianState with _$ElectricianState {
  const factory ElectricianState.initial() = _ElectricianState;

  const factory ElectricianState.processing() = ProcessingState;

  const factory ElectricianState.endProcess() = EndProcessingState;

  const factory ElectricianState.neutral() = NeutralState;

  const factory ElectricianState.changedType(ListType input) =
      _ChangeTypeListState;
}
