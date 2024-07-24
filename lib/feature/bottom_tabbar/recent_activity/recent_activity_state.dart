part of 'recent_activity_cubit.dart';

@freezed
class RecentActivityState with _$RecentActivityState {
  const factory RecentActivityState.initial() = _RecentActivityState;

  const factory RecentActivityState.processing() = ProcessingState;

  const factory RecentActivityState.endProcess() = EndProcessingState;

  const factory RecentActivityState.neutral() = NeutralState;
}
