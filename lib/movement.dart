import 'dart:async';

import 'package:analog_clock/arc_painter.dart';
import 'package:analog_clock/hand_painter.dart';
import 'package:analog_clock/math_utils.dart';
import 'package:flutter/material.dart';

/// Just like in regular clock, the movement is keeping track of the time
/// and making the clock hands move
class Movement extends StatefulWidget {
  static const BoxShadow shadow = BoxShadow(
    blurRadius: 0.2,
    color: Colors.black38,
  );

  /// radius of movement as a whole (think of it as of a clipping rect for the longest hand)
  final double radius;

  /// as a fraction of radius, e.g 0.5 will make the hour hand twice shorter than whole movement radius
  final double hourHandLength;

  /// a stroke width for the hour hand
  final double hourHandWidth;

  /// as a fraction of radius, e.g 0.5 will make the minute hand twice shorter than whole movement radius
  final double minuteHandLength;

  /// a stroke width for the minute hand
  final double minuteHandWidth;

  /// as a fraction of radius, e.g 0.5 will make the second hand twice shorter than whole movement radius
  final double secondHandLength;

  /// a stroke width for the second hand
  final double secondHandWidth;

  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color handOutlineColor;

  const Movement(
    this.radius, {
    Key key,
    this.hourHandLength = 0.55,
    this.hourHandWidth = 11,
    this.hourHandColor = Colors.black,
    this.minuteHandLength = 0.9,
    this.minuteHandWidth = 8,
    this.minuteHandColor = Colors.black,
    this.secondHandLength = 1,
    this.secondHandWidth = 3,
    this.secondHandColor = Colors.black,
    this.handOutlineColor = Colors.transparent,
  }) : super(key: key);

  @override
  _MovementState createState() => _MovementState();
}

class _MovementState extends State<Movement> {
  var _now = DateTime.now();
  Timer _timer;
  @override
  Widget build(BuildContext context) {
    final Widget secondHand = TweenAnimationBuilder(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 450),
      tween: Tween(begin: 0.0, end: _now.second.toDouble()),
      builder: (context, seconds, child) => CustomPaint(
        painter: ArcPainter(secondAngleRadians(seconds),
            radius: widget.secondHandLength * widget.radius,
            color: widget.secondHandColor,
            strokeWidth: widget.secondHandWidth),
      ),
    );

    final Widget hourHand = _buildRotatedHand(
        widget.radius * widget.hourHandLength,
        widget.hourHandWidth,
        hourAngleRadians(_now.hour, _now.minute),
        widget.hourHandColor,
        widget.handOutlineColor);

    final Widget minuteHand = _buildRotatedHand(
      widget.radius * widget.minuteHandLength,
      widget.minuteHandWidth,
      minuteAngleRadians(_now.minute, _now.second),
      widget.minuteHandColor,
      widget.handOutlineColor,
    );

    return Stack(
      children: <Widget>[
        hourHand,
        minuteHand,
        secondHand,
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  /// The hand consists of 2 shapes: the circle in the pivot point and the rounded rect as a hand itself
  /// Custom painter is drawing this complex shape along with all the decorations (gradients, shadows, etc.)
  /// And the transform widgets are responsible of rotating the resulting image around the correct pivot point to a provided [angleRadians]
  Widget _buildRotatedHand(
    double length,
    double width,
    double angleRadians,
    Color handColor,
    Color outlineColor,
  ) =>
      Transform.translate(
        offset: Offset(-width / 2, -length + width / 2),
        child: Transform.rotate(
          child: Container(
            height: length,
            width: width,
            child: CustomPaint(
              // magic numbers (2*width/3) here just define the width of the hadn related to the diameter of the circle (hand's pivot point decoration)
              painter: HandPainter(
                2 * width / 3,
                color: handColor,
                outlineColor: outlineColor,
              ),
            ),
          ),
          angle: angleRadians,
          // define the offset of the rotation origin in relation to the center point of the rotated object (as defined by default alignment: Alignment.center)
          origin: Offset(0, length / 2 - width / 2),
        ),
      );

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }
}
