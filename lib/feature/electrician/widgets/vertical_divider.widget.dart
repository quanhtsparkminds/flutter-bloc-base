import 'package:flutter/material.dart';
import 'package:myapp/commands/core/app_color.dart';

class VerticalDividerWidget extends StatelessWidget {
  final double thickness;
  final double height;
  final Color? color;

  const VerticalDividerWidget(
      {super.key, this.thickness = 0.1, this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: thickness,
      height: height,
      child: CustomPaint(
        painter: _VerticalDividerPainter(color ?? AppColors.shadeOfGray),
      ),
    );
  }
}

class _VerticalDividerPainter extends CustomPainter {
  final Color color;

  _VerticalDividerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
