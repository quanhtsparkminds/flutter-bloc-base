import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/constants/widget_key.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/app_image/app_images.dart';
import 'package:myapp/shared/widgets/app_image/image.type.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class MenuDrawer extends StatelessWidget {
  final Function? onPressedFavorite;
  const MenuDrawer({super.key, this.onPressedFavorite});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImageView(
                    imagePath: Assets.fakeImage.homeImage2.path,
                    key: WidgetKey.bottomTabBarHeaderAvatar.key,
                    width: AppSpacing.x60,
                    height: AppSpacing.x60,
                    imageType: ImageType.png,
                    border: Border.all(width: 0, color: AppColors.transparent),
                    radius: const BorderRadius.all(
                      Radius.circular(AppSpacing.x60),
                    )),
                AppSizedBox.square10,
                TextCustom(
                  'Alexander A',
                  variant: AppTextVariant.button,
                  style: TextStyle(color: AppColors.greyStrong),
                ),
                AppSizedBox.square10,
                TextCustom(
                  'provider@gmail.com',
                  variant: AppTextVariant.button,
                  style: TextStyle(color: AppColors.greyStrong),
                )
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              Assets.svg.metroFavoriteOutline,
              width: 20,
            ),
            minLeadingWidth: 0,
            title: const Text(' Favorite '),
            onTap: () => onPressedFavorite?.call(),
          ),
        ],
      ),
    );
  }
}
