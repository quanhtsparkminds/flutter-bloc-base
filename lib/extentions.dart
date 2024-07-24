import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/shared/utils/screen_size.dart';

extension Extensions on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  toBoolean([bool strict = false]) {
    if (strict == true) {
      return this == '1' || this == 'true';
    }
    return this != '0' && this != 'false' && this != '';
  }

  toEmailMasked([int minFill = 4, String fillChar = '*']) {
    return replaceFirstMapped(RegExp('^(.)(.*?)([^@]?)(?=@[^@]+\$)'), (m) {
      var start = m.group(1);
      var middle = fillChar * max(minFill, m.group(2)!.length);
      var end = m.groupCount >= 3 ? m.group(3) : start;
      return '$start$middle$end';
    });
  }

  toCapitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

String toSecurityPhone(String phone) {
  if (phone.isNotEmpty) {
    String maskedString = '******${phone.substring(phone.length - 3)}';
    return maskedString;
  }
  return '';
}

Color addPercentageToColor(Color color, double percentage) {
  percentage = percentage.clamp(0, 100) / 100.0;

  int red = (color.red + (255 - color.red) * percentage).toInt();
  int green = (color.green + (255 - color.green) * percentage).toInt();
  int blue = (color.blue + (255 - color.blue) * percentage).toInt();

  red = red.clamp(0, 255);
  green = green.clamp(0, 255);
  blue = blue.clamp(0, 255);

  return Color.fromARGB(color.alpha, red, green, blue);
}

extension Xnum on num {
  double get resize => Screens.resizeFitDevice(Get.context!, toDouble());
}
