import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/bottom_tabbar/booking_cubit/booking_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  late BookingCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(context,
              title: 'Home Repair',
              action: [const Offstage()],
              leadingPress: () {},
              leadingType: LeadingType.none),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context)
                .copyWith(top: AppSpacing.x0, bottom: 0),
            child: Column(
              children: [
                SizedBox(
                  height: Screens.resizeHeightUtil(context, 120),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _bloc.listCategories.length,
                    separatorBuilder: (context, index) => AppSizedBox.square10,
                    itemBuilder: (context, index) {
                      return ItemCategory(item: _bloc.listCategories[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
