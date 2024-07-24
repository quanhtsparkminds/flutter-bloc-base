import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/feature/bottom_tabbar/types/rating_bar.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_image/app_images.dart';
import 'package:myapp/shared/widgets/app_image/image.type.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/row_item.dart';

class ElectricianListWidget extends StatelessWidget {
  final Electrician item;
  final Function(Electrician item)? onPressed;
  final Function(Electrician item)? onPressedHeart;
  const ElectricianListWidget(
      {super.key, required this.item, this.onPressed, this.onPressedHeart});

  @override
  Widget build(BuildContext context) {
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
      onItemTap: onPressed != null ? () => onPressed!(item) : null,
      titleStyle: getAppTextStyleByVariant(AppTextVariant.button)
          .copyWith(fontWeight: FontWeight.w700),
      height: Screens.resizeHeightUtil(context, AppSpacing.x80),
      title: item.name,
      subTitle: 'Cleaner',
      ratingWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RatingBarIndicator(
            rating: item.rating,
            itemSize: 15,
            unratedColor: AppColors.textDark,
            itemBuilder: (context, index) {
              return Icon(Icons.star, color: AppColors.warning);
            },
          ),
          AppSizedBox.square2,
          TextCustom('320',
              variant: AppTextVariant.subtitle,
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
            onTap: onPressedHeart != null ? () => onPressedHeart!(item) : null,
            child: SvgPicture.asset(
              Assets.svg.metroFavoriteOutline,
              width: 20,
            ),
          ),
          TextCustom('${Formart.formatCurrency(item.pricePerHours)}/hr',
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
