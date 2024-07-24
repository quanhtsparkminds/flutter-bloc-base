part of 'introduction_cubit.dart';

@freezed
class IntroductionState with _$IntroductionState {
  const factory IntroductionState.initial() = _IntroductionState;

  const factory IntroductionState.setPage(int pageState) = PageState;
}
