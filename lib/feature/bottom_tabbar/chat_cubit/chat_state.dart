part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _ChatState;

  const factory ChatState.processing() = ProcessingState;

  const factory ChatState.endProcess() = EndProcessingState;

  const factory ChatState.neutral() = NeutralState;
}
