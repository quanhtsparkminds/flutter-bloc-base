import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/gen/assets.gen.dart';

part 'favorite_state.dart';
part 'favorite_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState.initial());

  startProcess() {
    emit(const FavoriteState.processing());
  }

  endLoading() {
    emit(const FavoriteState.endProcess());
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
}
