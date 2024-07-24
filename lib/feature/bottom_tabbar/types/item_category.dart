import 'package:flutter/cupertino.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

enum CategoryType {
  roofing,
  electrician,
  cleaning,
  fitting,
  plumnbing,
  paiting,
  maid,
  house,
  laundry,
}

class Categories {
  Widget assets;
  String title;
  Color bgColor;
  CategoryType categoryType;

  Categories(
      {required this.assets,
      required this.title,
      required this.bgColor,
      required this.categoryType});
}

class ItemCategory extends StatelessWidget {
  final Categories item;
  final Function(Categories item)? onPressed;
  const ItemCategory({super.key, required this.item, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed != null ? () => onPressed?.call(item) : null,
      borderRadius: const BorderRadius.all(
        Radius.circular(AppSpacing.x10),
      ),
      color: AppColors.white,
      disabledColor: AppColors.white,
      padding: const EdgeInsets.only(top: AppSpacing.x16),
      child: SizedBox(
        width: Screens.resizeWidthUtil(context, 100),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: item.bgColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSpacing.x60),
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.x10),
              height: Screens.resizeFitDevice(context, AppSpacing.x100),
              width: Screens.resizeFitDevice(context, AppSpacing.x100),
              child: item.assets,
            ),
            AppSizedBox.square10,
            TextCustom(
              item.title,
              variant: AppTextVariant.text1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
