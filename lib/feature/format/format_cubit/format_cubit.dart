import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'format_state.dart';
part 'format_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class FormatCubit extends Cubit<FormatState> {
  FormatCubit() : super(const FormatState.initial());

  startProcess() {
    emit(const FormatState.processing());
  }

  endLoading() {
    emit(const FormatState.endProcess());
  }

  void initState() {}
}
