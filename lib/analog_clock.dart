// Copyright 2020 secretwpn. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:analog_clock/clock_theme.dart';
import 'package:analog_clock/dial_painter.dart';
import 'package:analog_clock/movement.dart';
import 'package:flutter/material.dart';

/// Visually the clock contains the dial graphics on the bottom
/// and the movement (clock hands) on the top.
/// It supports light and dark themes
class AnalogClock extends StatelessWidget {
  static final _lightTheme = ClockTheme(
    backgroundGradientStartColor: const Color(0xFFDDDDDD),
    backgroundGradientEndColor: const Color(0xFFCCCCCC),
    grooveColor: const Color(0xFF000000),
    hourHandColor: const Color(0xFFF4F4F4),
    minuteHandColor: const Color(0xFFF4F4F4),
    secondHandColor: Colors.white60,
    handOutlineColor: Colors.black54,
  );
  static final _darkTheme = ClockTheme(
    backgroundGradientStartColor: const Color(0xFF222222),
    backgroundGradientEndColor: const Color(0xFF222222),
    grooveColor: const Color(0xFFFFFFFF),
    hourHandColor: const Color(0xFF444444),
    minuteHandColor: const Color(0xFF444444),
    secondHandColor: const Color(0x11FFFFFF),
    handOutlineColor: Colors.white60,
  );

  const AnalogClock();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            theme.backgroundGradientStartColor,
            theme.backgroundGradientEndColor,
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => _buildClock(
          constraints.smallest,
          theme,
        ),
      ),
    );
  }

  _buildClock(Size size, ClockTheme theme) => Stack(
        children: <Widget>[
          CustomPaint(
            painter: DialPainter(
              size.height / 2.8,
              center: Offset(2 * (size.width / 3), size.height / 2),
              grooveColor: theme.grooveColor,
            ),
          ),
          Positioned(
            top: size.height / 2,
            left: size.width / 3 * 2,
            child: Movement(
              size.height / 2.8,
              secondHandColor: theme.secondHandColor,
              minuteHandColor: theme.minuteHandColor,
              hourHandColor: theme.hourHandColor,
              handOutlineColor: theme.handOutlineColor,
            ),
          ),
        ],
      );
}
