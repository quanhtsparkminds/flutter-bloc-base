part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _CategoryState;

  const factory CategoryState.processing() = ProcessingState;

  const factory CategoryState.endProcess() = EndProcessingState;

  const factory CategoryState.neutral() = NeutralState;
}
