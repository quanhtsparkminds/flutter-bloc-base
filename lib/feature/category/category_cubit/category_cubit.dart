import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/go_router/routes.types.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState.initial());

  startProcess() {
    emit(const CategoryState.processing());
  }

  endLoading() {
    emit(const CategoryState.endProcess());
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
        Categories(
          assets: Assets.images.categoryPlumbing.image(color: AppColors.white),
          title: 'Roofing',
          bgColor: AppColors.skyBlue,
          categoryType: CategoryType.roofing,
        ),
        Categories(
          assets: Assets.images.categoryPaiting.image(color: AppColors.white),
          title: 'Painting',
          bgColor: AppColors.primaryColor,
          categoryType: CategoryType.paiting,
        ),
        Categories(
          assets: Assets.images.categoryBuildings.image(color: AppColors.white),
          title: 'Maid',
          bgColor: AppColors.sunsetRed,
          categoryType: CategoryType.maid,
        ),
        Categories(
          assets:
              Assets.images.categoryElectrician.image(color: AppColors.white),
          title: 'House Repair',
          bgColor: AppColors.limeeGreen,
          categoryType: CategoryType.house,
        ),
        Categories(
          assets: Assets.images.categoryLaundry.image(color: AppColors.white),
          title: 'Laundry',
          bgColor: AppColors.electricPurple,
          categoryType: CategoryType.laundry,
        ),
      ];
  void initState() {}

  void onPressedDetails(Categories item) {
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
}
