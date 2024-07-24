import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class CustomAppCheckbox extends StatelessWidget {
  final String name;
  final String? label;
  final AutovalidateMode autovalidateMode;
  final InputDecorationTheme inputDecorationTheme;
  final OptionsOrientation orientation;
  final double size;
  final bool enable;
  final Widget spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final bool? initialValue;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String? Function(bool?)? validator;
  final Function(bool?)? onChanged;

  const CustomAppCheckbox({
    super.key,
    required this.name,
    this.label,
    this.suffixWidget,
    this.spacing = const SizedBox(),
    this.prefixWidget,
    required this.autovalidateMode,
    this.inputDecorationTheme = const InputDecorationTheme(),
    this.orientation = OptionsOrientation.horizontal,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.size = AppSpacing.x24,
    this.enable = true,
    this.textDirection = TextDirection.ltr,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.validator,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    BoxBorder boxBorderLightMode(bool value) =>
        Border.all(color: AppColors.primaryColor.withOpacity(.5), width: 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(
            children: [
              TextCustom(
                label ?? '',
                variant: AppTextVariant.inputTitle,
              ),
              AppSizedBox.square8
            ],
          ),
        FormBuilderField<bool>(
          name: name,
          validator: validator,
          autovalidateMode: autovalidateMode,
          initialValue: initialValue,
          onChanged: onChanged,
          builder: (field) {
            Color checkBoxActiveColor =
                field.value == true ? AppColors.white : AppColors.transparent;
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                errorText: field.errorText,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ).applyDefaults(Theme.of(context).inputDecorationTheme),
              child: GestureDetector(
                onTap: enable
                    ? () {
                        field.didChange(field.value == true ? false : true);
                      }
                    : null,
                child: Row(
                  textDirection: textDirection,
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    prefixWidget ?? Container(),
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                          color: field.value == true
                              ? AppColors.primaryColor
                              : AppColors.white,
                          border: boxBorderLightMode(field.value ?? false),
                          borderRadius: BorderRadius.circular(AppSpacing.x4)),
                      child: Transform.scale(
                        scale: field.value == true
                            ? (size / Checkbox.width) - 0.4
                            : (size / Checkbox.width),
                        child: Checkbox(
                            value: field.value ?? false,
                            activeColor: AppColors.transparent,
                            checkColor: checkBoxActiveColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: enable
                                ? (bool? value) {
                                    field.didChange(value ?? false);
                                  }
                                : null,
                            side: BorderSide.none),
                      ),
                    ),
                    spacing,
                    Expanded(child: suffixWidget ?? Container())
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
