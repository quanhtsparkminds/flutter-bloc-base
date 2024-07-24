import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/feature/category/category_cubit/category_cubit.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late CategoryCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Scaffold(
            appBar: appBarCustom(context,
                title: 'Category',
                action: [const Offstage()],
                leadingPress: () => NavigateBackCommand().run(),
                leadingType: LeadingType.back),
            backgroundColor: AppColors.secondaryColor,
            body: Padding(
              padding: getScreensPadding(context)
                  .copyWith(top: AppSpacing.x30, bottom: 0),
              child: CustomScrollView(
                slivers: [
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ItemCategory(
                          item: _bloc.listCategories[index],
                          onPressed: _bloc.onPressedDetails,
                        );
                      },
                      childCount: _bloc.listCategories.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Assets.fakeImage.ads.image(),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
