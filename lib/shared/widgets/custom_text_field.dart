import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_style.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final BorderRadiusGeometry? borderRadius;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;
  final int? maxLine;
  final int? minLine;
  final bool enabled;
  final bool? turnOffValidate;
  final TextInputType? keyboardType;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Function(String)? onChange;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final String? textError;
  final List<TextInputFormatter>? formatter;

  final bool? isFormText;
  final InputDecoration? inputDecoration;
  final bool? isObscureIcon;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final OutlineInputBorder? border;

  const CustomTextField(
      {Key? key,
      this.formatter,
      this.autofocus,
      this.borderRadius,
      this.labelText,
      this.onChange,
      this.validator,
      this.onTap,
      this.backgroundColor,
      required this.controller,
      this.hintText,
      this.enabled = true,
      this.turnOffValidate = true,
      this.onSubmitted,
      this.obscureText,
      this.maxLine,
      this.minLine,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.padding,
      this.helperText,
      this.textError,
      this.isFormText,
      this.inputDecoration,
      this.isObscureIcon,
      this.fillColor,
      this.textInputAction,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? errorText;

    if (textError != null && textError!.isNotEmpty) {
      errorText = textError;
    } else {
      if ((controller.text.isEmpty) && turnOffValidate == false) {
        errorText = textError ?? '';
      }
    }
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        children: [
          TextField(
            inputFormatters: (formatter != null) ? formatter : null,
            controller: controller,
            enabled: enabled,
            autofocus: autofocus ?? false,
            obscureText: obscureText ?? false,
            style: TextStyles.defaultReg.copyWith(color: Colors.black),
            keyboardType: keyboardType ?? TextInputType.text,
            maxLines: maxLine ?? 1,
            minLines: minLine ?? 1,
            onChanged: (value) {
              onChange?.call(value);
            },
            onSubmitted: onSubmitted,
            onTap: () {
              onTap?.call();
            },
            decoration: inputDecoration
                    ?.applyDefaults(Theme.of(context).inputDecorationTheme) ??
                InputDecoration(
                  helperText: helperText,
                  hintText: hintText,
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: border,
                  errorStyle: const TextStyle(color: Colors.red),
                  prefixIcon: prefixIcon != null
                      ? IconButton(
                          onPressed: () {},
                          icon: prefixIcon!,
                        )
                      : null,
                  suffixIcon: suffixIcon != null
                      ? IconButton(
                          onPressed: () {},
                          icon: suffixIcon!,
                        )
                      : null,
                  isDense: true,
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: TextStyles.defaultReg,
                  hintStyle: TextStyles.defaultReg,
                  fillColor: fillColor ??
                      ((enabled)
                          ? AppColors.grey3Light
                          : AppColors.grey3Light.withOpacity(.9)),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ).applyDefaults(Theme.of(context).inputDecorationTheme),
          ),
          Visibility(
            visible: errorText != null && errorText.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  errorText != null && errorText.isNotEmpty
                      ? Text(errorText, style: TextStyles.defaultError)
                      : const SizedBox(
                          height: 20,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
