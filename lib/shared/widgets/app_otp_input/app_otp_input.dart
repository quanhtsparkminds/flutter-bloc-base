import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:pinput/pinput.dart';

class AppOtpInput<T> extends StatefulWidget {
  final TextEditingController controller;
  final String? value;
  final FocusNode? focusNode;
  final bool isUnfocusWhenFullFilled;
  final int passcodeLength;
  final Widget? cursor;
  final bool? isShowCursor;
  final PinTheme? defaultPinTheme;
  final PinTheme? focusedPinTheme;
  final PinTheme? submittedPinTheme;
  final PinputAutovalidateMode? pinInputAutovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final dynamic Function(String otp)? onFullfilled;
  final dynamic Function(String otp)? onChanged;
  final String? Function(String?)? validator;
  final bool isDarkMode;
  final bool autofocus;

  const AppOtpInput(
      {super.key,
      required this.controller,
      this.value,
      this.cursor,
      this.focusNode,
      this.onFullfilled,
      this.isUnfocusWhenFullFilled = true,
      this.isDarkMode = true,
      this.passcodeLength = Constants.passcodeLength,
      this.inputFormatters,
      this.validator,
      this.isShowCursor,
      this.defaultPinTheme,
      this.focusedPinTheme,
      this.submittedPinTheme,
      this.pinInputAutovalidateMode,
      this.autofocus = true,
      this.onChanged});

  @override
  State<AppOtpInput> createState() => _AppOtpInputState();
}

class _AppOtpInputState extends State<AppOtpInput> {
  String get passcodetext => widget.controller.text.isNotEmpty
      ? widget.controller.text
      : widget.value ?? '';
  String pass = '';
  void _onChanged(String value) {
    if (!mounted) return;
    if (value.length == widget.passcodeLength &&
        widget.isUnfocusWhenFullFilled) {
      widget.focusNode?.unfocus();
      if (widget.onFullfilled is Function) {
        widget.onFullfilled!(value);
      }
    }
    pass = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    print('inpincode -- $pass');
    return Stack(
      children: [
        Pinput(
          defaultPinTheme: widget.defaultPinTheme ?? _defaultPinTheme(),
          focusedPinTheme: widget.focusedPinTheme ?? _focusedPinTheme(),
          submittedPinTheme: widget.submittedPinTheme ?? _submittedPinTheme(),
          pinputAutovalidateMode: widget.pinInputAutovalidateMode ??
              PinputAutovalidateMode.onSubmit,
          showCursor: true,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // Allow only digits (0-9)
          ],
          autofocus: widget.autofocus,
          errorTextStyle: getAppTextStyleByVariant(AppTextVariant.text1).apply(
              color: AppColors.error,
              fontWeightDelta: 500,
              overflow: TextOverflow.ellipsis),
          cursor: widget.cursor ??
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 40,
                    height: 2,
                    color: focusedBorderColor,
                  ),
                ],
              ),
          length: widget.passcodeLength,
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: TextInputType.number,
          validator: widget.validator,
          onCompleted: _onChanged,
          onChanged: widget.onChanged,
          separatorBuilder: (index) => const SizedBox(width: 8),
        ),
        if (passcodetext.split('').isNotEmpty)
          Positioned(
            bottom: 0,
            child: Container(
              width: 40,
              height: 10,
              color: AppColors.black,
            ),
          ),
      ],
    );
  }

  PinTheme _defaultPinTheme() {
    return PinTheme(
      width: AppSpacing.x65,
      height: AppSpacing.x65,
      textStyle: TextStyle(
          fontSize: AppSpacing.x18,
          color: AppColors.black,
          height: AppSpacing.x22 / AppSpacing.x18,
          fontWeight: FontWeight.w400),
      decoration: BoxDecoration(
        color: AppColors.grey3Light,
        borderRadius: BorderRadius.circular(AppSpacing.x10),
      ),
    );
  }

  PinTheme _focusedPinTheme() => _defaultPinTheme().copyDecorationWith(
        color: AppColors.grey3Light,
      );

  PinTheme _submittedPinTheme() => _defaultPinTheme().copyWith(
        decoration: _defaultPinTheme().decoration!.copyWith(
              color: AppColors.grey3Light,
            ),
      );
}
