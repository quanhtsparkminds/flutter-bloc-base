import 'package:flutter/material.dart';

BuildContext? scrollContext;

BuildContext priorityContext(BuildContext context) {
  if (scrollContext != null) {
    try {
      RenderBox box = scrollContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      double lastY = position.dy;

      RenderBox currentBox = context.findRenderObject() as RenderBox;
      Offset currentPosition = currentBox.localToGlobal(Offset.zero);
      double currentY = currentPosition.dy;

      if (lastY > currentY) {
        scrollContext = context;
      }
    } catch (e) {
      scrollContext = context;
    }
  } else {
    scrollContext = context;
  }
  return scrollContext!;
}
