import 'package:flutter/material.dart';

class AppComboxItem {
  final String subLabel;
  final String label;
  final String amount;
  final Key widgetKey;

  AppComboxItem({
    required this.amount,
    required this.subLabel,
    required this.label,
    required this.widgetKey,
  });
}
