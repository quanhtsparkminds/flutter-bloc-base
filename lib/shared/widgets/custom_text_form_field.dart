import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/gen/fonts.gen.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String name;
  final String? hintText;
  final bool obscureText;
  final BorderRadiusGeometry? borderRadius;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final int errorMaxLines;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final int? maxLine;
  final int? minLine;
  final String? suffixText;
  final String? initialValue;
  final bool enabled;
  final bool? turnOffValidate;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final FontFamily? fontCustom;
  final String? helperText;
  final Widget? suffixIcon;
  final Function()? onSuffixIconPressed;
  final Widget? prefixIcon;
  final Function()? onPrefixIconPressed;
  final Color? backgroundColor;
  final Function(String?)? onChange;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final bool? autofocus;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? textError;
  final List<TextInputFormatter>? formatter;

  final bool? isFormText;
  final InputDecoration? inputDecoration;
  final bool? isObscureIcon;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    Key? key,
    this.formatter,
    this.suffixText,
    this.autofocus,
    this.borderRadius,
    this.labelText,
    this.onChange,
    this.onSaved,
    this.validator,
    this.onTap,
    this.backgroundColor,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.turnOffValidate = true,
    this.errorMaxLines = 5,
    this.onSubmitted,
    this.obscureText = false,
    this.autovalidateMode,
    this.maxLine,
    this.minLine,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.padding,
    this.helperText,
    this.textError,
    this.initialValue,
    this.isFormText,
    this.fontCustom,
    this.inputDecoration,
    this.isObscureIcon = false,
    this.textStyle,
    this.onSuffixIconPressed,
    this.fieldKey,
    required this.name,
    this.onPrefixIconPressed,
    this.focusNode,
    this.fillColor,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final ValueNotifier<String?> text = ValueNotifier<String?>(null);
  bool innerObscureText = true;

  @override
  void initState() {
    super.initState();
    text.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle inputMergedStyle =
        getAppTextStyleByVariant(AppTextVariant.inputTitle)
            .merge(widget.textStyle)
            .copyWith(color: AppColors.textDark);
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.labelText != null,
            child: Column(
              children: [
                TextCustom(
                  widget.labelText ?? '',
                  variant: AppTextVariant.input,
                  style: TextStyles.defaultReg,
                ),
                const SizedBox(
                  height: AppSpacing.x8,
                )
              ],
            ),
          ),
          FormBuilderTextField(
            autovalidateMode:
                widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
            inputFormatters:
                (widget.formatter != null) ? widget.formatter : null,
            style: inputMergedStyle,
            key: widget.fieldKey,
            controller: widget.controller,
            initialValue: widget.initialValue,
            enabled: widget.isFormText ?? widget.enabled,
            autofocus: widget.autofocus ?? false,
            obscureText: (innerObscureText && (widget.obscureText)),
            keyboardType: widget.keyboardType ?? TextInputType.text,
            maxLines: widget.maxLine ?? 1,
            focusNode: widget.focusNode,
            minLines: widget.minLine ?? 1,
            textInputAction: widget.textInputAction,
            onSaved: widget.onSaved,
            onChanged: (value) {
              text.value = value;
              widget.onChange?.call(value);
              widget.onChange != null ? widget.onChange!(value) : null;
            },
            validator: widget.validator,
            onTap: () {
              widget.onTap?.call();
            },
            decoration: widget.inputDecoration
                    ?.applyDefaults(Theme.of(context).inputDecorationTheme) ??
                InputDecoration(
                  helperText: widget.helperText,
                  isDense: true,
                  border: InputBorder.none,
                  hintStyle: getAppTextStyleByVariant(AppTextVariant.text1)
                      .copyWith(
                          color: ((widget.enabled)
                              ? AppColors.textDark
                              : AppColors.textDark.withOpacity(.9)),
                          fontWeight: FontWeight.w400),
                  suffixText: widget.suffixText,
                  hintText: widget.hintText,
                  errorMaxLines: widget.errorMaxLines,
                  errorStyle: const TextStyle(color: Colors.red),
                  prefixIcon: widget.prefixIcon != null
                      ? IconButton(
                          onPressed: widget.onPrefixIconPressed,
                          icon: widget.prefixIcon!,
                        )
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? IconButton(
                          onPressed: widget.onSuffixIconPressed,
                          icon: widget.suffixIcon!,
                        )
                      : widget.isObscureIcon ?? false
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  innerObscureText = !innerObscureText;
                                });
                              },
                              splashColor: AppColors.transparent,
                              icon: Icon(
                                innerObscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 24,
                                color: Colors.grey.withOpacity(.8),
                              ),
                            )
                          : null,
                  fillColor: widget.fillColor ??
                      ((widget.enabled)
                          ? AppColors.grey3Light
                          : AppColors.grey3Light.withOpacity(.9)),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ).applyDefaults(Theme.of(context).inputDecorationTheme),
            name: widget.name,
          ),
        ],
      ),
    );
  }
}
