import 'dart:math' as math;

import 'package:analog_clock/math_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // We are comparing double values so let's not hope for the exact match
  const double _tolerance = 0.000001;

  // Hour hand rotation tests
  test('Hour hand should point east for 3 o\'clock', () {
    final hourAngle = hourAngleRadians(3, 0);
    expect(hourAngle, closeTo(0.5 * math.pi, _tolerance));
  });

  test('Hour hand should point south for 6 o\'clock', () {
    final hourAngle = hourAngleRadians(6, 0);
    expect(hourAngle, closeTo(math.pi, _tolerance));
  });

  test('Hour hand should point west for 9 o\'clock', () {
    final hourAngle = hourAngleRadians(9, 0);
    expect(hourAngle, closeTo(1.5 * math.pi, _tolerance));
  });

  test('Hour hand should point north for 12 o\'clock', () {
    final hourAngle = hourAngleRadians(12, 0);
    expect(hourAngle, closeTo(2 * math.pi, _tolerance));
  });

  test('Hour hand should point north-east for 1:30', () {
    final hourAngle = hourAngleRadians(1, 30);
    expect(hourAngle, closeTo(0.25 * math.pi, _tolerance));
  });

  test('Hour hand should point the same way for 13:30 as for 1:30', () {
    final hourAngleAm = hourAngleRadians(1, 30);
    final hourAnglePm = hourAngleRadians(13, 30);
    // We subtract the full circle (2 * math.pi) from PM value to get the AM
    // since while radian values are different, the actual direction is the same
    expect(hourAnglePm - 2 * math.pi, closeTo(hourAngleAm, _tolerance));
  });

  // Minute hand rotation tests
  test('Minute hand should point east for 15 minutes', () {
    final minuteAngle = minuteAngleRadians(15, 0);
    expect(minuteAngle, closeTo(0.5 * math.pi, _tolerance));
  });

  test('Minute hand should point north-east for 7 minutes 30 seconds', () {
    final minuteAngle = minuteAngleRadians(7, 30);
    expect(minuteAngle, closeTo(0.25 * math.pi, _tolerance));
  });

  test('Minute hand should point south for 30 minutes', () {
    final minuteAngle = minuteAngleRadians(30, 0);
    expect(minuteAngle, closeTo(math.pi, _tolerance));
  });

  test('Minute hand should point west for 45 minutes', () {
    final minuteAngle = minuteAngleRadians(45, 0);
    expect(minuteAngle, closeTo(1.5 * math.pi, _tolerance));
  });

  test('Minute hand should point north for 60 minutes', () {
    final minuteAngle = minuteAngleRadians(60, 0);
    expect(minuteAngle, closeTo(2 * math.pi, _tolerance));
  });

  // Second hand rotation tests
  test('Second hand should point east for 15 seconds', () {
    final secondAngle = secondAngleRadians(15);
    expect(secondAngle, closeTo(0.5 * math.pi, _tolerance));
  });

  test('Second hand should point south for 30 seconds', () {
    final secondAngle = secondAngleRadians(30);
    expect(secondAngle, closeTo(math.pi, _tolerance));
  });

  test('Second hand should point west for 45 seconds', () {
    final secondAngle = secondAngleRadians(45);
    expect(secondAngle, closeTo(1.5 * math.pi, _tolerance));
  });

  test('Second hand should point north for 60 seconds', () {
    final secondAngle = secondAngleRadians(60);
    expect(secondAngle, closeTo(2 * math.pi, _tolerance));
  });
}
