import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/app_radio/app_radio_group.types.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

enum AppCheckedBox { radioGroup, radioCheckdBox }

class AppRadioGroup extends StatefulWidget {
  final List<AppRadioGroupItem> items;
  final Function(int) isActiveFunction;
  final Function(AppRadioGroupItem) onPressFunction;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final AppCheckedBox appType;
  const AppRadioGroup({
    super.key,
    required this.items,
    required this.isActiveFunction,
    required this.onPressFunction,
    this.suffixWidget,
    this.prefixWidget,
    this.appType = AppCheckedBox.radioGroup,
  });

  @override
  State<AppRadioGroup> createState() => _AppRadioGroupState();
}

class _AppRadioGroupState extends State<AppRadioGroup> {
  AppRadioGroupItem activeGroup =
      AppRadioGroupItem(key: '-1', label: '', widgetKey: const Key('temp'));

  onPresseedActive(AppRadioGroupItem item) {
    widget.onPressFunction(item);
    activeGroup = item;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.items.asMap().entries.map((e) {
        bool isActive = activeGroup.key == e.value.key;
        return _appRadioButton(
          context,
          isActive: isActive,
          onPressed: () {
            onPresseedActive(e.value);
          },
          title: widget.items[e.key].label,
          key: widget.items[e.key].widgetKey,
          prefixWidget: widget.prefixWidget,
          suffixWidget: widget.suffixWidget,
        );
      }).toList(),
    );
  }

  Widget _appRadioButton(
    BuildContext context, {
    required bool isActive,
    required String? title,
    Key? key,
    Function()? onPressed,
    Widget? suffixWidget,
    Widget? prefixWidget,
  }) =>
      GestureDetector(
        key: key,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x6)
              .copyWith(right: AppSpacing.x16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: isActive ? 1.5 : 1,
                  strokeAlign: BorderSide.strokeAlignOutside),
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.x25)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixWidget ??
                  ActionChip(
                    backgroundColor: AppColors.transparent,
                    padding: const EdgeInsets.all(1.0),
                    shape: CircleBorder(
                      side: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.0,
                      ),
                    ),
                    onPressed: onPressed,
                    pressElevation: 0,
                    label: CircleAvatar(
                      backgroundColor: isActive
                          ? AppColors.primaryColor
                          : AppColors.transparent,
                      radius: AppSpacing.x6,
                    ),
                    labelPadding: const EdgeInsets.all(AppSpacing.x3),
                  ),
              Expanded(
                  child: TextCustom(
                title ?? '',
                variant: AppTextVariant.button,
                style: TextStyle(
                    color: AppColors.borderLine, fontWeight: FontWeight.w500),
              )),
              isActive
                  ? suffixWidget ??
                      SvgPicture.asset(Assets.svg.disclosureIndicator)
                  : const Offstage()
            ],
          ),
        ),
      );
}
