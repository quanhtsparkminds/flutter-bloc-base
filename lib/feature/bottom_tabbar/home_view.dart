import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/bottom_tabbar/home_cubit/home_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/widgets/drawer_widget.dart';
import 'package:myapp/feature/bottom_tabbar/widgets/home_widget.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/custom_text_field.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/shared/widgets/padding.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: _bloc.scraffoldKey,
            drawer: MenuDrawer(
              onPressedFavorite: () => _bloc.handleFavoritePage(context),
            ),
            appBar: appBarCustom(
              appBarColor: AppColors.transparent,
              context,
              leadingPress: _bloc.handleOpenDrawer,
              action: [
                HomeDetailsWidget.notificationWidget(onPressed: () => null),
              ],
            ),
            backgroundColor: AppColors.secondaryColor,
            body: Padding(
              padding: getScreensPadding(context)
                  .copyWith(top: AppSpacing.x0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextCustom(
                    TranslationKeys.providerUbetter.tr,
                    variant: AppTextVariant.h2,
                  ),
                  AppSizedBox.square4,
                  TextCustom(
                    TranslationKeys.cleanHouse.tr,
                    variant: AppTextVariant.h2,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  AppSizedBox.square24,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _bloc.searchController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: TranslationKeys.placeholderSearchHere.tr,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.transparent, width: 1.5),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.x8),
                            ),
                            fillColor: AppColors.white,
                            prefixIcon: SvgPicture.asset(
                              Assets.svg.seachOutline,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                          AppSizedBox.square30,
                          HomeDetailsWidget.rownInLine(
                              prefixText: TranslationKeys.category.tr,
                              suffixedText: TranslationKeys.seeAll.tr,
                              onPressed: () =>
                                  _bloc.onPressedSeeAll(ItemInHome.category)),
                          AppSizedBox.square20,
                          HomeDetailsWidget.listViewWidget(context,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: _bloc.listCategories.length,
                                separatorBuilder: (context, index) =>
                                    AppSizedBox.square10,
                                itemBuilder: (context, index) {
                                  return ItemCategory(
                                    item: _bloc.listCategories[index],
                                    onPressed: (item) =>
                                        _bloc.onPressedCategory(item, context),
                                  );
                                },
                              ),
                              size: 120),
                          AppSizedBox.square30,
                          HomeDetailsWidget.rownInLine(
                              prefixText: TranslationKeys.recommended.tr,
                              suffixedText: TranslationKeys.seeAll.tr,
                              onPressed: () => _bloc
                                  .onPressedSeeAll(ItemInHome.recommended)),
                          AppSizedBox.square10,
                          HomeDetailsWidget.listViewWidget(context,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: _bloc.recommended.length,
                                separatorBuilder: (context, index) =>
                                    AppSizedBox.square10,
                                itemBuilder: (context, index) {
                                  return ElectricianGridWidget(
                                    item: _bloc.recommended[index],
                                    onPressed: (Electrician item) {},
                                    onPressedHeart: (Electrician item) {},
                                    positioned: Posisition(
                                        top: 0, right: 10, bottom: 0),
                                  );
                                },
                              ),
                              size: 250),
                          AppSizedBox.square30,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
