import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Hand painter paints a complex shape (in our case a rounded rect with a circle at one end) with shadow
/// Theoretically this should be doable with stack of containers with proper boxdecorations,
/// but in reality such arrangement did not work with shadows correctly, so here we go with a slightly more complex way
class HandPainter extends CustomPainter {
  final double radius;
  final Color color;
  final Color outlineColor;

  HandPainter(
    this.radius, {
    this.color = Colors.white,
    this.outlineColor = Colors.black,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    var rectPath = Path();
    var circlePath = Path();
    rectPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(size.width / 2),
      ),
    );
    circlePath.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height - size.width / 2),
        radius: radius,
      ),
    );
    // we need to use combined path in order to draw the outline highlights properly
    // around the path as whole, not around all the individual parts of it
    var path = Path.combine(PathOperation.union, rectPath, circlePath);

    canvas.drawShadow(path, Colors.black87, 1, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(
      path,
      paint
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.1,
    );
  }

  @override
  bool shouldRepaint(HandPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.outlineColor != outlineColor ||
      oldDelegate.radius != radius;
}
