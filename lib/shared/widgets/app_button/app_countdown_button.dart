import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/feature/authentication/signup/widgets/signup_widget.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/app_timer/count_down_timer_controller.dart';
import 'package:myapp/shared/widgets/base_state.dart';

class AppCountdownButtonController {
  VoidCallback? _restart;
  VoidCallback? _stop;

  void restart() {
    if (_restart != null) {
      _restart!();
    }
  }

  void stop() {
    if (_stop != null) {
      _stop!();
    }
  }
}

class AppCountdownButton extends StatefulWidget {
  final bool autoStart;
  final int seconds;
  final String? title;
  final Color? colorTimeDown;
  final Future<bool> Function()? onResend;
  final AppCountdownButtonController? controller;
  final Color? colorTitle;

  const AppCountdownButton(
      {super.key,
      this.autoStart = true,
      this.seconds = 180,
      this.title,
      this.colorTimeDown,
      this.onResend,
      this.controller,
      this.colorTitle});

  @override
  State<AppCountdownButton> createState() => _AppCountdownButtonState();
}

class _AppCountdownButtonState extends BaseState<AppCountdownButton>
    with SingleTickerProviderStateMixin {
  int countdownSeconds = 0;
  late CountDownController countdownTimerController;
  bool _isTimerRunning = false;

  void initTimerOperation() {
    countdownSeconds = widget.seconds;
    countdownTimerController = CountDownController(
      seconds: countdownSeconds,
      onTick: (seconds) {
        _isTimerRunning = true;
        countdownSeconds = seconds;
        if (seconds == 0) {
          _isTimerRunning = false;
        }
        setState(() {});
      },
      onFinished: () {
        _isTimerRunning = false;
        countdownTimerController.stop();
        setState(() {});
      },
    );

    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == AppLifecycleState.paused.toString()) {
        if (_isTimerRunning) {
          countdownTimerController.pause(countdownSeconds);
        }
      }
      if (msg == AppLifecycleState.resumed.toString()) {
        if (_isTimerRunning) {
          countdownTimerController.resume();
        }
      }
      return Future(() => null);
    });

    _isTimerRunning = true;
    if (widget.autoStart) {}
    countdownTimerController.start();
  }

  void stopTimer() {
    _isTimerRunning = false;
    countdownTimerController.stop();
  }

  void resetTimer() {
    stopTimer();
    initTimerOperation();
  }

  bool get isRunning => _isTimerRunning;
  bool get isCompleted => !_isTimerRunning;
  @override
  initState() {
    super.initState();
    initTimerOperation();

    widget.controller?._restart = resetTimer;
    widget.controller?._stop = stopTimer;
  }

  @override
  void dispose() {
    countdownTimerController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isResendAble =
        isCompleted && widget.onResend is Future<bool> Function();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.x16, vertical: AppSpacing.x16),
          child: SignUpWidgets.footerWithText(
              onPressed: isResendAble
                  ? () async {
                      if (await widget.onResend!()) {
                        resetTimer();
                      }
                    }
                  : null,
              textPrefix: TranslationKeys.didReceiveCode.tr,
              textSuffix: ' ${TranslationKeys.resendCode.tr}'),
        ),
        AnimatedSwitcher(
          duration: Constants.animationDuration,
          child: isRunning
              ? TextCustom(
                  countdownSeconds == 0
                      ? ''
                      : '${Duration(seconds: countdownSeconds.toInt()).toString().substring(2, 7)} Sec Left',
                  variant: AppTextVariant.button,
                  style: TextStyle(
                    color: widget.colorTimeDown ?? AppColors.borderLine,
                  ),
                )
              : null,
        )
      ],
    );
  }
}
