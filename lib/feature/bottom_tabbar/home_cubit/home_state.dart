part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeState;

  const factory HomeState.processing() = ProcessingState;

  const factory HomeState.endProcess() = EndProcessingState;

  const factory HomeState.neutral() = NeutralState;
}
