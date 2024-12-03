import 'package:flutter/material.dart';

class CommonCircularProgressPainter extends CustomPainter {
  final int percentage;
  final Color backgroundColor;
  final List<Color> gradientColors;

  CommonCircularProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: gradientColors,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2))
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double sweepAngle = 360 * (percentage / 100);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      bgPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -90 * (3.14 / 180),
      sweepAngle * (3.14 / 180),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
