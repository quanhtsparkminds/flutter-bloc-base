import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/gen/assets.gen.dart';

part 'booking_state.dart';
part 'booking_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState.initial());

  startProcess() {
    emit(const BookingState.processing());
  }

  endLoading() {
    emit(const BookingState.endProcess());
  }

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

  void initState() {}
}
