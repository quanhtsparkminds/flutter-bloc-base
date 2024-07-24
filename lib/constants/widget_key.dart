import 'package:flutter/material.dart';

enum WidgetKey {
  showPopup,
  bottomTabBarHeaderAvatar,
  loginForgotPasswordButton,
  bottomTabBarByIndex,
  bottomTabBarItemIconDashboard,
  bottomTabBarItemIconPayment,
  bottomTabBarItemIconBooking,
  bottomTabBarItemIconChat,
  bottomTabBarItemIconSettings,
}

extension Extensions on WidgetKey {
  Key get key => Key(toString());
  Key keyWithSuffix(String suffix) => Key(toString() + suffix);
}
