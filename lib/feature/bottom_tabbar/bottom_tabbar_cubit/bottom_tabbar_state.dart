part of 'bottom_tabbar_cubit.dart';

@freezed
class BottomTabbarState with _$BottomTabbarState {
  const factory BottomTabbarState.initial() = _BottomTabbarState;

  const factory BottomTabbarState.processing() = ProcessingState;

  const factory BottomTabbarState.endProcess() = EndProcessingState;

  const factory BottomTabbarState.neutral() = NeutralState;

  const factory BottomTabbarState.bottomSelected(int index) =
      _BottomTabbarSelectedState;
}
