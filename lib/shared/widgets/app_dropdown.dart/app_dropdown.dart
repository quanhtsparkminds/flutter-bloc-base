import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.types.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/dropdown_button.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/dropdown_model.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class AppdropdownButton<T> extends StatefulWidget {
  const AppdropdownButton({
    super.key,
    this.parentScrollController,
    required this.onChange,
    required this.items,
    this.dropdownButtonStyle,
    this.icon,
    this.hideIcon = false,
    this.enabled = true,
    required this.hintText,
    this.isHighLightColor = true,
    this.thumbVisibility = true,
    this.itemStyle,
    this.itemVariant = AppTextVariant.button,
    this.hintTextStyle,
    this.bgColorDropDown,
    this.leadingIcon = false,
    this.isShowFlagCountry = false,
    this.flag = '',
    this.dropdownStyle = const DropdownStyle2(),
    this.colorItem,
    this.colorActiveItem,
    this.border,
    this.initialValue,
  });

  final ScrollController? parentScrollController;

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(DropDownModel) onChange;

  /// list of DropdownItems
  final List<AppDropdownItem> items;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle2? dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Widget? icon;
  final bool hideIcon;

  final Color? colorItem;

  final Color? bgColorDropDown;

  // highligh color item
  final bool isHighLightColor;

  // value display
  final Color? colorActiveItem;
  final TextStyle? itemStyle;
  final AppTextVariant itemVariant;

  // hint text
  final String hintText;
  final TextStyle? hintTextStyle;

  // enable select
  final bool enabled;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;
  final DropdownStyle2 dropdownStyle;

  final bool thumbVisibility;

  final bool isShowFlagCountry;
  final String flag;

  final Border? border;

  final String? initialValue;

  @override
  State<AppdropdownButton> createState() => _AppdropdownButtonState();
}

class _AppdropdownButtonState extends State<AppdropdownButton> {
  Color get colorIcon =>
      (selectedValue.isEmpty) ? AppColors.primaryColor : AppColors.primaryColor;
  bool get emptyValueSelect => selectedValue.isNotEmpty;

  String selectedValue = '';

  onChanged(DropDownModel output) {
    widget.onChange(output);
    selectedValue = output.nameSelected;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = IconButton(
      onPressed: null,
      icon: SvgPicture.asset(
        Assets.svg.dropdown,
        colorFilter: ColorFilter.mode(colorIcon, BlendMode.srcIn),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown2<AppDropdownItem>(
          onChange: onChanged,
          key: widget.key,
          scrollController: widget.parentScrollController,
          dropdownButtonStyle: DropdownButtonStyle2(
            height: widget.dropdownButtonStyle?.height ?? 50,
            width:
                widget.dropdownButtonStyle?.width ?? Screens.getWidth(context),
            elevation: 1,
            backgroundColor:
                widget.dropdownButtonStyle?.backgroundColor ?? Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 0)
                .copyWith(left: AppSpacing.x16),
            border: widget.border ??
                Border.all(
                    color: AppColors.white, width: emptyValueSelect ? 2 : 0),
            borderRadius: widget.dropdownButtonStyle?.borderRadius,
            primaryColor: AppColors.white,
          ),
          dropdownStyle: widget.dropdownStyle,
          leadingIcon: widget.leadingIcon,
          hideIcon: widget.hideIcon,
          icon: widget.icon ?? icon,
          thumbVisibility: widget.thumbVisibility,
          items: widget.items
              .asMap()
              .entries
              .map(
                (item) => DropdownItem2<AppDropdownItem>(
                  value: item.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.x16, horizontal: AppSpacing.x20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColors.textDark.withOpacity(.1),
                                width: 1.0))),
                    child: TextCustom(
                      item.value.label,
                      variant: AppTextVariant.text1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          color: widget.colorItem ?? AppColors.textDark),
                    ),
                  ),
                ),
              )
              .toList(),
          child: Expanded(
            child: selectedValue.isEmpty
                ? Row(
                    children: [
                      Visibility(
                        visible: widget.isShowFlagCountry,
                        child: widget.flag != ''
                            ? SvgPicture.asset(
                                widget.flag,
                                width: AppSpacing.x24,
                              )
                            : Container(),
                      ),
                      Visibility(
                          visible: widget.isShowFlagCountry,
                          child: AppSizedBox.square8),
                      TextCustom(
                        widget.hintText,
                        variant: AppTextVariant.text1,
                        style: widget.hintTextStyle ??
                            TextStyle(color: AppColors.textDark),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Visibility(
                        visible: widget.isShowFlagCountry,
                        child: widget.flag != ''
                            ? SvgPicture.asset(
                                widget.flag,
                                width: AppSpacing.x24,
                              )
                            : Container(),
                      ),
                      Visibility(
                          visible: widget.isShowFlagCountry,
                          child: AppSizedBox.square8),
                      TextCustom(
                        selectedValue,
                        variant: widget.itemVariant,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: widget.itemStyle ??
                            TextStyle(
                                fontWeight: FontWeight.w500,
                                color: widget.colorActiveItem ??
                                    AppColors.textDark),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
