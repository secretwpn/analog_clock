import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialPainter extends CustomPainter {
  final double radius;
  final Offset center;
  final Color grooveColor;

  DialPainter(
    this.radius, {
    this.center = Offset.zero,
    this.grooveColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    // sweep gradient helps to imitate light playing on the grooves
    final groovePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.25
      ..shader = SweepGradient(
        colors: <Color>[
          grooveColor.withAlpha(30),
          grooveColor.withAlpha(50),
          grooveColor.withAlpha(40),
          grooveColor.withAlpha(90),
          grooveColor.withAlpha(30),
          grooveColor.withAlpha(110),
          grooveColor.withAlpha(30),
          grooveColor.withAlpha(50),
          grooveColor.withAlpha(30),
        ],
      ).createShader(rect);

    // draw grooves. step size is optimized for the screen resolution of the target device after some visual testing
    const grooveStep = 4;
    for (var i = radius / 3; i < radius; i += grooveStep) {
      canvas.drawCircle(center, i, groovePaint);
    }
  }

  @override
  bool shouldRepaint(DialPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.center != center ||
        oldDelegate.grooveColor != grooveColor;
  }
}
