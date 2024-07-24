import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/go_router/routes.types.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

enum FormFieldNames { search }

enum ItemInHome { category, recommended, popularHandryman }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.initial());
  final GlobalKey<ScaffoldState> scraffoldKey = GlobalKey(); // Create a key

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final GlobalKey<FormBuilderState> formKeyLogin =
      GlobalKey<FormBuilderState>();

  final Map<FormFieldNames, String> formFieldNames = {
    FormFieldNames.search: 'search',
  };
  late Map<FormFieldNames, GlobalKey<FormBuilderFieldState>> formFieldKeys =
      formFieldNames.map(
    (key, value) => MapEntry(key, GlobalKey<FormBuilderFieldState>()),
  );

  startProcess() {
    emit(const HomeState.processing());
  }

  endLoading() {
    emit(const HomeState.endProcess());
  }

  void initState() {}

  handleFavoritePage(BuildContext context) {
    Navigator.pop(context);
    NavigateToCommand().pushToNamed(AppRoutes.favorite.name);
  }

  handleOpenDrawer() => scraffoldKey.currentState?.openDrawer();

  List<Categories> get listCategories => [
        Categories(
          assets: Assets.images.categoryBuildings
              .image(color: AppColors.secondaryColor3),
          title: 'Roofing',
          bgColor: AppColors.secondaryColor3.withOpacity(.1),
          categoryType: CategoryType.roofing,
        ),
        Categories(
          assets: Assets.images.categoryElectrician
              .image(color: AppColors.primaryColor),
          title: 'Electrician',
          bgColor: AppColors.primaryColor.withOpacity(.1),
          categoryType: CategoryType.electrician,
        ),
        Categories(
          assets: Assets.images.categoryCleaningV2
              .image(color: AppColors.ligthSalmon),
          title: 'Cleaning',
          bgColor: AppColors.ligthSalmon.withOpacity(.1),
          categoryType: CategoryType.cleaning,
        ),
        Categories(
          assets:
              Assets.images.categoryFitings.image(color: AppColors.ligthSalmon),
          title: 'Fittings',
          bgColor: AppColors.ligthSalmon.withOpacity(.1),
          categoryType: CategoryType.fitting,
        ),
      ];

  void onPressedCategory(Categories item, BuildContext buildContext) {
    AppRoutes? page;
    switch (item.categoryType) {
      case CategoryType.electrician:
        page = AppRoutes.electrician;
        break;
      default:
    }
    if (page == null) return;
    NavigateToCommand().pushToNamed(page.name);
  }

  onPressedSeeAll(ItemInHome type) {
    AppRoutes? routes;
    switch (type) {
      case ItemInHome.category:
        routes = AppRoutes.category;
        break;
      case ItemInHome.recommended:
        routes = null;
        break;
      default:
    }
    if (routes == null) return;
    NavigateToCommand().pushToNamed(routes.name);
  }

  List<Electrician> get recommended => [
        Electrician(
            name: 'John smith',
            profileAvatar: Assets.fakeImage.homeImage.path,
            rating: 3.6,
            unrateColor: AppColors.white,
            yearExp: '10',
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
