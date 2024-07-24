import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState.initial());

  startProcess() {
    emit(const ChatState.processing());
  }

  endLoading() {
    emit(const ChatState.endProcess());
  }

  void initState() {}
}
