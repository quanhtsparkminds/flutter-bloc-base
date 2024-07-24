import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/widgets/app_checkbox/combobox.type.dart';

import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class AppCombobox extends StatefulWidget {
  final List<AppComboxItem> items;
  final Function(int) isActiveFunction;
  final Function(AppComboxItem) onPressFunction;
  final Widget? suffixWidget;
  const AppCombobox({
    super.key,
    required this.items,
    required this.isActiveFunction,
    required this.onPressFunction,
    this.suffixWidget,
  });

  @override
  State<AppCombobox> createState() => _AppComboboxState();
}

class _AppComboboxState extends State<AppCombobox> {
  AppComboxItem activeGroup = AppComboxItem(
      subLabel: 'qweqwe',
      label: '',
      widgetKey: const Key('temp'),
      amount: '12312312');

  onPresseedActive(AppComboxItem item) {
    widget.onPressFunction(item);
    activeGroup = item;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.items.asMap().entries.map((e) {
        bool isActive = activeGroup.widgetKey == e.value.widgetKey;
        return _appRadioButton(
          context,
          isActive: isActive,
          onPressed: () {
            onPresseedActive(e.value);
          },
          item: e.value,
          suffixWidget: widget.suffixWidget,
        );
      }).toList(),
    );
  }

  Widget _appRadioButton(
    BuildContext context, {
    required bool isActive,
    required AppComboxItem item,
    Function()? onPressed,
    Widget? suffixWidget,
  }) {
    Color activeColor = isActive ? AppColors.white : AppColors.greyStrong;
    Color activeSubColor = isActive ? AppColors.white : AppColors.subDarkColor;

    return GestureDetector(
      key: item.widgetKey,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.x16, vertical: AppSpacing.x20),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.x10),
        decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.x6)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: AppSpacing.x20,
              width: AppSpacing.x20,
              padding: const EdgeInsets.all(AppSpacing.x4),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.textDark,
                      width: isActive ? 1.5 : 1,
                      strokeAlign: BorderSide.strokeAlignOutside),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.x20)),
              child: isActive ? SvgPicture.asset(Assets.svg.checkMark) : null,
            ),
            AppSizedBox.square10,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextCustom(
                  item.label,
                  variant: AppTextVariant.button,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: activeColor, fontWeight: FontWeight.w700),
                ),
                AppSizedBox.square4,
                TextCustom(
                  item.subLabel,
                  variant: AppTextVariant.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: activeColor, fontWeight: FontWeight.w400),
                ),
              ],
            )),
            AppSizedBox.square10,
            suffixWidget ??
                TextCustom(
                  Formart.formatCurrency(item.amount),
                  variant: AppTextVariant.button,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: activeSubColor, fontWeight: FontWeight.w500),
                )
          ],
        ),
      ),
    );
  }
}
