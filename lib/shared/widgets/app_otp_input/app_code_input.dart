import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

class AppCodeInput<T> extends StatefulWidget {
  final TextEditingController? controller;
  final String? value;
  final FocusNode? focusNode;
  final bool isUnfocusWhenFullFilled;
  final int passcodeLength;
  final dynamic Function(String otp)? onFullfilled;
  final String? Function(String?)? validator;

  const AppCodeInput(
      {super.key,
      this.controller,
      this.value,
      this.focusNode,
      this.onFullfilled,
      this.isUnfocusWhenFullFilled = true,
      this.passcodeLength = Constants.passcodeLength,
      this.validator});

  @override
  State<AppCodeInput> createState() => _AppCodeInputState();
}

class _AppCodeInputState extends State<AppCodeInput> {
  double codeItemSize = AppSpacing.x16;
  double codeItemSpacing = AppSpacing.x24;
  double codeBoxSize = AppSpacing.x65;
  double dividerWidth = AppSpacing.x24;

  String get passcodetext =>
      widget.controller != null ? widget.controller!.text : widget.value ?? '';
  double get codeContainerWidth => Screens.getWidth(context);

  void _onChanged(String value) {
    if (widget.onFullfilled is Function) {
      widget.onFullfilled!(passcodetext);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: codeContainerWidth,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:
                List.generate(widget.passcodeLength, (index) => index).map((e) {
              return buildCodeBox(
                  context, passcodetext.padRight(widget.passcodeLength)[e]);
            }).toList(),
          ),
        ),
        if (widget.controller != null)
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                  width: codeContainerWidth,
                  child: TextFormField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    autofocus: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only digits (0-9)
                    ],
                    validator: widget.validator,
                    onChanged: _onChanged,
                    maxLength: widget.passcodeLength,
                    keyboardType: TextInputType.number,
                  )),
            ),
          ),
      ],
    );
  }

  Widget buildCodeBox(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.x10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.grey3Light,
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSpacing.x10))),
            height: AppSpacing.x65,
            width: AppSpacing.x65,
            alignment: Alignment.center,
            child: value.isNotEmpty
                ? AnimatedSize(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                    child: TextCustom(
                      value,
                      variant: AppTextVariant.text,
                      style: TextStyle(
                          fontSize: value.trim().isEmpty
                              ? 0
                              : const TextStyle().fontSize,
                          color: AppColors.borderLine,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : null,
          ),
          Positioned(
              right: (codeBoxSize - dividerWidth) / 2,
              bottom: (codeBoxSize - dividerWidth) / 2,
              top: (codeBoxSize - dividerWidth) / 2,
              left: (codeBoxSize - dividerWidth) / 2,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 100),
                scale: value.trim().isEmpty ? 1 : 0,
                child: Align(
                  alignment: Alignment.center,
                  child: TextCustom(
                    '',
                    variant: AppTextVariant.input,
                    style: TextStyle(
                      color: AppColors.textDark.withOpacity(0.5),
                    ),
                  ),
                ),
              )),
          if (value.trim().isNotEmpty)
            Positioned(
              bottom: 0,
              child: Container(
                height: 2,
                width: 45,
                color: AppColors.borderLine,
              ),
            ),
        ],
      ),
    );
  }
}
