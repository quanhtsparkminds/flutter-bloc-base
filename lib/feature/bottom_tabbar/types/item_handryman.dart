import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_image/app_images.dart';
import 'package:myapp/shared/widgets/app_image/image.type.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class HandrymanWidget extends StatelessWidget {
  final Electrician item;
  final Function(Electrician item) onItemTap;
  final Function(Electrician item) onPressedHeart;
  const HandrymanWidget(
      {super.key,
      required this.item,
      required this.onItemTap,
      required this.onPressedHeart});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onItemTap(item),
      padding: EdgeInsets.zero,
      color: AppColors.white,
      disabledColor: AppColors.white,
      pressedOpacity: 0.9,
      borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.x20)),
      child: SizedBox(
        width: Screens.resizeHeightUtil(context, 130),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.x10, horizontal: AppSpacing.x10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => onPressedHeart(item),
                          child: SvgPicture.asset(
                            Assets.svg.metroFavoriteOutline,
                            width: 16,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom('${item.rating}',
                                variant: AppTextVariant.button,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyStrong,
                                )),
                            AppSizedBox.square4,
                            SvgPicture.asset(
                              Assets.svg.awesomeStar,
                              width: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Screens.resizeHeightUtil(context, 120),
                  decoration: BoxDecoration(
                    color: item.bgColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSpacing.x20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppSizedBox.square10,
                      TextCustom(
                        item.name,
                        variant: AppTextVariant.button,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            fontFamily: FontFamily.fontBoldRoboto),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextCustom(
                          '${Formart.formatCurrency(item.pricePerHours)}/hr',
                          variant: AppTextVariant.button,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              fontFamily: FontFamily.fontBoldRoboto)),
                      AppSizedBox.square10,
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AppImageView(
                      imagePath: item.profileAvatar,
                      width: 100,
                      height: 100,
                      imageType: ImageType.png,
                      border:
                          Border.all(width: 0, color: AppColors.transparent),
                      radius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                  ),
                  AppSizedBox.square40,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
