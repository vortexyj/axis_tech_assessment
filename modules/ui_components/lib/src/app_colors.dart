import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static Color textColor = "#323232".toColor();
  static Color subTextColor = "#767676".toColor();
  static Color hintGrey = "#a1a1a1".toColor();
  static Color lightGrey = "#F1F1F2".toColor();
  static Color backgroundColor = "#ffffff".toColor();
  static Color cardColors = "#F1F1F2".toColor();
  static Color successColor = "#09c380".toColor();
  static Color warningColor = "#e9ae27".toColor();
  static Color errorColor = "#BC2C2C".toColor();
  static Color errorLightColor = "#F8EAEA".toColor();
  static Color mainColor = "#007bc0".toColor();
  static Color lightMainColor = "#e6f2f9".toColor();
  static Color darkMainColor = "#25314C".toColor();
  static Color appBarColor = "#FFFFFF".toColor();
  static Color tabBarColor = "#FFFFFF".toColor();

  static Map<int, Color> generateColorScheme(Color startColor, int numSteps) {
    // Convert startColor to HSV
    final startHsv = HSVColor.fromColor(startColor);
    final startValue = startHsv.value;

    // Calculate step size for value component
    final stepSize = (1 - startValue) / (numSteps - 1);
    // final whiteValue = 1.0;

    // Generate intermediate colors
    final Map<int, Color> colors = {};
    for (int i = 0; i < numSteps; i++) {
      final value = startValue + i * stepSize * (1 - startValue);
      final intermediateColor =
          HSVColor.fromAHSV(1.0, startHsv.hue, startHsv.saturation, value)
              .toColor();
      colors[(i + 1) * 100] = intermediateColor;
    }
    return colors;
  }
}
