import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.types.dart';

part 'popular_handyman_state.dart';
part 'popular_handyman_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class PopularHandymanCubit extends Cubit<PopularHandymanState> {
  PopularHandymanCubit() : super(const PopularHandymanState.initial());

  startProcess() {
    emit(const PopularHandymanState.processing());
  }

  endLoading() {
    emit(const PopularHandymanState.endProcess());
  }

  void initState() {}
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
}
