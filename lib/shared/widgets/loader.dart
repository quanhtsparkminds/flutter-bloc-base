import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';

class LoadingOverlay {
  static final LoadingOverlay _singleton = LoadingOverlay._internal();

  factory LoadingOverlay() {
    return _singleton;
  }

  LoadingOverlay._internal();

  OverlayEntry? _overlayEntry;

  void show(BuildContext context,
      {Color? loaderColor, Color? opacityColor, double opacity = 0.5}) {
    if (_overlayEntry != null) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: opacityColor ?? Colors.black,
            ),
          ),
          Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: loaderColor ?? AppColors.white.withOpacity(0.5),
                size: AppSpacing.x40),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

Future<T> showLoader<T>(
  BuildContext context, {
  required Future<T> Function() asyncFunction,
  Color? loaderColor,
  Color? opacityColor,
  double opacity = 0.5,
}) async {
  LoadingOverlay().show(context,
      loaderColor: loaderColor, opacityColor: opacityColor, opacity: opacity);
  try {
    return await asyncFunction();
  } finally {
    LoadingOverlay().hide();
  }
}
