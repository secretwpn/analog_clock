import 'package:flutter/material.dart';

class ClockTheme {
  final backgroundGradientStartColor;
  final backgroundGradientEndColor;
  final hourHandColor;
  final minuteHandColor;
  final secondHandColor;
  final handOutlineColor;
  final grooveColor;

  ClockTheme({
    this.backgroundGradientStartColor = Colors.yellowAccent,
    this.backgroundGradientEndColor = Colors.yellow,
    this.hourHandColor = Colors.grey,
    this.minuteHandColor = Colors.grey,
    this.secondHandColor = Colors.redAccent,
    this.handOutlineColor = Colors.white,
    this.grooveColor = Colors.black,
  });
}
