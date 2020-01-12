import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Paints an arc between [startAngle] and [startAngle] + [sweepAngle]
/// Unlike [Canvas.drawArc] method it starts by default (when [startAngle] is not provided) not from 3 o'clock but from 12
class ArcPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;

  ArcPainter(
    this.sweepAngle, {
    this.startAngle = -math.pi / 2,
    this.color = Colors.black,
    this.radius = 100,
    this.strokeWidth = 2.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..color = color;

    final rect = Rect.fromCircle(
      center: Offset.zero,
      radius: radius,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ArcPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.startAngle != startAngle ||
      oldDelegate.sweepAngle != sweepAngle ||
      oldDelegate.strokeWidth != strokeWidth;
}
