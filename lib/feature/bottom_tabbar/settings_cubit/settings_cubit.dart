import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState.initial());

  startProcess() {
    emit(const SettingsState.processing());
  }

  endLoading() {
    emit(const SettingsState.endProcess());
  }

  void initState() {}
}
