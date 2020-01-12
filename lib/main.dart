import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';

import 'analog_clock.dart';

void main() {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  // We don't use the model in the clock face,
  // but it is not clear from the contest rules if we can drop the whole ClockCustomizer
  // so let it stay as in examples
  runApp(ClockCustomizer((ClockModel model) => AnalogClock()));
}
