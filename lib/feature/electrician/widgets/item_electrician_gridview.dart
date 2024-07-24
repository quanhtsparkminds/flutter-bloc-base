import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/bottom_tabbar/types/rating_bar.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class Electrician {
  final double rating;
  final Color bgColor;
  final Color? unrateColor;
  final int itemCountRating;
  final EdgeInsets? itemPadding;
  final String? yearExp;
  final double? pricePerHours;
  final String profileAvatar;
  final String name;

  Electrician({
    required this.rating,
    required this.bgColor,
    required this.profileAvatar,
    required this.name,
    this.unrateColor,
    this.itemCountRating = 5,
    this.itemPadding,
    this.pricePerHours,
    this.yearExp,
  });
}

class Posisition {
  double? top;
  double? bottom;
  double? right;
  double? left;
  Posisition({this.bottom, this.top, this.left, this.right});
}

class ElectricianGridWidget extends StatelessWidget {
  final Electrician item;
  final Function(Electrician item) onPressed;
  final Function(Electrician item) onPressedHeart;
  final Posisition? positioned;
  const ElectricianGridWidget(
      {super.key,
      required this.item,
      required this.onPressed,
      required this.onPressedHeart,
      this.positioned});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(item),
      child: Container(
        decoration: BoxDecoration(
          color: item.bgColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppSpacing.x10),
            bottomRight: Radius.circular(AppSpacing.x10),
          ),
        ),
        width: Screens.resizeHeightUtil(context, 150),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Image.asset(item.profileAvatar, fit: BoxFit.cover)),
                Expanded(
                  child: Column(
                    children: [
                      AppSizedBox.square16,
                      TextCustom(
                        item.name,
                        variant: AppTextVariant.button,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            fontFamily: FontFamily.fontBoldRoboto),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSizedBox.square8,
                      TextCustom(
                        TranslationKeys.yearExprience.trParams({
                          'year': '${item.yearExp ?? 0}',
                          'many':
                              double.parse(item.yearExp ?? '0') > 1 ? 's' : ''
                        }),
                        variant: AppTextVariant.subtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSizedBox.square8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RatingBarIndicator(
                            rating: 3.5,
                            itemSize: 15,
                            unratedColor:
                                item.unrateColor ?? AppColors.textDark,
                            itemCount: item.itemCountRating,
                            itemPadding: item.itemPadding ?? EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Icon(Icons.star, color: AppColors.warning);
                            },
                          ),
                          AppSizedBox.square4,
                          TextCustom(
                            '${item.rating}',
                            variant: AppTextVariant.menu,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.fontBoldRoboto,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      AppSizedBox.square8,
                      TextCustom(
                          '${Formart.formatCurrency(item.pricePerHours)}/hr',
                          variant: AppTextVariant.button,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              fontFamily: FontFamily.fontBoldRoboto)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: positioned?.bottom,
              top: positioned?.top,
              right: positioned?.right,
              left: positioned?.left,
              child: InkWell(
                onTap: () => onPressedHeart(item),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.x6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: SvgPicture.asset(Assets.svg.metroFavoriteFill)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
