import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/feature/bottom_tabbar/home_cubit/home_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/go_router/routes.types.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/electrician_page_configuration.dart';

part 'recent_activity_state.dart';
part 'recent_activity_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class RecentActivityCubit extends Cubit<RecentActivityState> {
  RecentActivityCubit() : super(const RecentActivityState.initial());

  startProcess() {
    emit(const RecentActivityState.processing());
  }

  endLoading() {
    emit(const RecentActivityState.endProcess());
  }

  void onPressedCategory(Categories item) {
    PageConfiguration? page;
    switch (item.categoryType) {
      case CategoryType.electrician:
        page = ElectricianPageConfiguration();
        break;
      default:
    }
    if (page == null) return;
    NavigateToCommand().pushToNamed(AppRoutes.electrician.name);
  }

  onPressedSeeAll(ItemInHome type) {
    AppRoutes? routes;
    switch (type) {
      case ItemInHome.category:
        routes = AppRoutes.category;
        break;
      case ItemInHome.popularHandryman:
        routes = AppRoutes.popularHandyman;
        break;
      default:
    }
    if (routes == null) return;
    NavigateToCommand().pushToNamed(routes.name);
  }

  List<Categories> get listCategories => [
        Categories(
          assets: Assets.images.categoryBuildings.image(color: AppColors.white),
          title: 'Roofing',
          bgColor: AppColors.secondaryColor3,
          categoryType: CategoryType.roofing,
        ),
        Categories(
          assets:
              Assets.images.categoryElectrician.image(color: AppColors.white),
          title: 'Electrician',
          bgColor: AppColors.primaryColor,
          categoryType: CategoryType.electrician,
        ),
        Categories(
          assets:
              Assets.images.categoryCleaningV2.image(color: AppColors.white),
          title: 'Cleaning',
          bgColor: AppColors.ligthSalmon,
          categoryType: CategoryType.cleaning,
        ),
        Categories(
          assets: Assets.images.categoryFitings.image(color: AppColors.white),
          title: 'Fittings',
          bgColor: AppColors.ligthSalmon,
          categoryType: CategoryType.fitting,
        ),
      ];
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
  void initState() {}
}
