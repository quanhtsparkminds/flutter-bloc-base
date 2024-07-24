part of 'popular_handyman_cubit.dart';

@freezed
class PopularHandymanState with _$PopularHandymanState {
  const factory PopularHandymanState.initial() = _PopularHandymanState;

  const factory PopularHandymanState.processing() = ProcessingState;

  const factory PopularHandymanState.endProcess() = EndProcessingState;

  const factory PopularHandymanState.neutral() = NeutralState;
}
