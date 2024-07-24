part of 'format_cubit.dart';

@freezed
class FormatState with _$FormatState {
  const factory FormatState.initial() = _FormatState;

  const factory FormatState.processing() = ProcessingState;

  const factory FormatState.endProcess() = EndProcessingState;

  const factory FormatState.neutral() = NeutralState;
}
