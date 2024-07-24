import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/feature/favorite/favorite_cubit/favorite_cubit.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late FavoriteCubit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(
            context,
            title: 'Favorite',
            action: [const Offstage()],
            leadingPress: _bloc.handleBackPressed,
            leadingType: LeadingType.back,
          ),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context)
                .copyWith(bottom: 0, top: AppSpacing.x20),
            child: Column(
              children: [
                _gridViewBuilder(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _gridViewBuilder() {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.x16,
          mainAxisSpacing: AppSpacing.x16,
          childAspectRatio: 0.7,
        ),
        itemCount: _bloc.handrymans.length,
        itemBuilder: (context, index) {
          final item = _bloc.handrymans[index];
          return ElectricianGridWidget(
            item: item,
            onPressed: (Electrician item) {},
            onPressedHeart: (Electrician item) {},
            positioned: Posisition(top: 10, right: 10),
          );
        },
      ),
    );
  }
}
