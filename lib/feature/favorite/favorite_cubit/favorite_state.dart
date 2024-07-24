part of 'favorite_cubit.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initial() = _FavoriteState;

  const factory FavoriteState.processing() = ProcessingState;

  const factory FavoriteState.endProcess() = EndProcessingState;

  const factory FavoriteState.neutral() = NeutralState;
}
