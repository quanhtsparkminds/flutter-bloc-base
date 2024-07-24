import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/bottom_tabbar/home_cubit/home_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_category.dart';
import 'package:myapp/feature/bottom_tabbar/recent_activity/recent_activity_cubit.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/feature/bottom_tabbar/types/item_handryman.dart';
import 'package:myapp/feature/bottom_tabbar/types/rating_bar.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_image/app_images.dart';
import 'package:myapp/shared/widgets/app_image/image.type.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';
import 'package:myapp/shared/widgets/row_item.dart';

class RecentActivityView extends StatefulWidget {
  const RecentActivityView({super.key});

  @override
  State<RecentActivityView> createState() => _RecentActivityViewState();
}

class _RecentActivityViewState extends State<RecentActivityView> {
  late RecentActivityCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentActivityCubit, RecentActivityState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(context,
              title: TranslationKeys.myActivity.tr,
              action: [const Offstage()],
              leadingPress: () {},
              leadingType: LeadingType.none),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context)
                .copyWith(top: AppSpacing.x0, bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppSizedBox.square10,
                        _rownInLine(
                            prefixText: TranslationKeys.category.tr,
                            suffixedText: TranslationKeys.viewAllPlus.tr,
                            onPressed: () =>
                                _bloc.onPressedSeeAll(ItemInHome.category)),
                        SizedBox(
                          height: Screens.resizeHeightUtil(context, 120),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _bloc.listCategories.length,
                            separatorBuilder: (context, index) =>
                                AppSizedBox.square10,
                            itemBuilder: (context, index) {
                              return ItemCategory(
                                item: _bloc.listCategories[index],
                                onPressed: (item) =>
                                    _bloc.onPressedCategory(item),
                              );
                            },
                          ),
                        ),
                        _rownInLine(
                            prefixText: TranslationKeys.popularHandyman.tr,
                            suffixedText: TranslationKeys.viewAllPlus.tr,
                            onPressed: () => _bloc
                                .onPressedSeeAll(ItemInHome.popularHandryman)),
                        SizedBox(
                          height: Screens.resizeHeightUtil(context, 200),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _bloc.handrymans.length,
                            separatorBuilder: (context, index) =>
                                AppSizedBox.square10,
                            itemBuilder: (context, index) {
                              return HandrymanWidget(
                                item: _bloc.handrymans[index],
                                onItemTap: (Electrician item) {},
                                onPressedHeart: (Electrician item) {},
                              );
                            },
                          ),
                        ),
                        _rownInLine(
                            prefixText: TranslationKeys.recentHiring.tr,
                            suffixedText: ''),
                        Column(
                          children: _bloc.handrymans
                              .map((element) => Container(
                                  margin: const EdgeInsets.only(
                                      bottom: AppSpacing.x10),
                                  child: _recentHiring(item: element)))
                              .toList(),
                        ),
                        AppSizedBox.square30,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _rownInLine(
      {required String prefixText,
      required String suffixedText,
      Function? onPressed}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.x20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustom(
            prefixText,
            variant: AppTextVariant.button,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.fontBoldRoboto,
                color: AppColors.greyStrong),
          ),
          CupertinoButton(
            onPressed: onPressed != null ? () => onPressed() : null,
            padding: EdgeInsets.zero,
            child: TextCustom(
              suffixedText,
              variant: AppTextVariant.text1,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.fontBoldRoboto,
                  color: AppColors.lavenderMist),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentHiring({required Electrician item}) {
    return rowItemInRow(
      context,
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.x14, horizontal: AppSpacing.x16),
      leading: Center(
        child: AppImageView(
          imagePath: item.profileAvatar,
          width: AppSpacing.x80,
          height: AppSpacing.x80,
          imageType: ImageType.png,
          border: Border.all(width: 0, color: AppColors.transparent),
          radius: const BorderRadius.all(
            Radius.circular(AppSpacing.x80),
          ),
        ),
      ),
      onItemTap: () => {},
      titleStyle: getAppTextStyleByVariant(AppTextVariant.button)
          .copyWith(fontWeight: FontWeight.w700),
      height: Screens.resizeHeightUtil(context, AppSpacing.x80),
      title: item.name,
      subTitle: 'Cleaner',
      ratingWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RatingBarIndicator(
            rating: 3.5,
            itemSize: 20,
            unratedColor: AppColors.textDark,
            itemBuilder: (context, index) {
              return Icon(Icons.star, color: AppColors.warning);
            },
          ),
          AppSizedBox.square2,
          TextCustom('320',
              variant: AppTextVariant.button,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.grey5Light,
              ))
        ],
      ),
      acction: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => {},
            child: SvgPicture.asset(
              Assets.svg.metroFavoriteOutline,
              width: 20,
            ),
          ),
          TextCustom('${Formart.formatCurrency(20)}/hr',
              variant: AppTextVariant.button,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.greyStrong,
                  fontFamily: FontFamily.fontBoldRoboto)),
        ],
      ),
    );
  }
}
