// Util methods to keep the clock hand angle calculations away from the UI code
import 'dart:math' as math;

const double radiansPerHour = 2 * math.pi / 12;
const double radiansPerMinute = 2 * math.pi / 60;
const double radiansPerSecond = 2 * math.pi / 60;

double hourAngleRadians(int hours, int minutes) =>
    hours * radiansPerHour + (minutes / 60) * radiansPerHour;

double minuteAngleRadians(int minutes, int seconds) =>
    minutes * radiansPerMinute + (seconds / 60) * radiansPerMinute;

double secondAngleRadians(double seconds) => seconds * radiansPerSecond;
