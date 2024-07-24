import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/feature/electrician/types/electrician.types.dart';
import 'package:myapp/gen/assets.gen.dart';

import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.types.dart';

part 'electrician_state.dart';
part 'electrician_cubit.freezed.dart';

class ElectricianCubit extends Cubit<ElectricianState> {
  ElectricianCubit() : super(const ElectricianState.initial());

  ListType _listType = ListType.listView;

  startProcess() {
    emit(const ElectricianState.processing());
  }

  endLoading() {
    emit(const ElectricianState.endProcess());
  }

  void initState(bool params) {
    MyLogger.d('params $params');
  }

  void handleSortby() {}
  void handleFilter() {}

  void onChangedTypeList(ListType input) {
    _listType = input;
    emit(ElectricianState.changedType(_listType));
  }

  void handleBackPressed() => NavigateBackCommand().run();

  List<Electrician> get handrymans => [
        Electrician(
            name: 'John smith',
            profileAvatar: Assets.fakeImage.homeImage.path,
            rating: 3.6,
            unrateColor: AppColors.white,
            bgColor: AppColors.primaryColor),
        Electrician(
            name: 'John smith',
            profileAvatar: Assets.fakeImage.homeImage2.path,
            rating: 3.6,
            unrateColor: AppColors.white,
            bgColor: AppColors.neutral1),
        Electrician(
            name: 'John smith',
            profileAvatar: Assets.fakeImage.homeImage2.path,
            rating: 3.6,
            unrateColor: AppColors.white,
            bgColor: AppColors.primaryColor),
      ];

  List<AppDropdownItem> listCategory = [
    AppDropdownItem(key: '0', label: 'label'),
    AppDropdownItem(key: '1', label: 'label'),
    AppDropdownItem(key: '2', label: 'label'),
  ];

  ListType get listType => _listType;
  bool get isListView => _listType == ListType.listView;
}
