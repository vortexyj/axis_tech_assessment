import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Primary / brand — near-black ink used for primary actions & headlines.
  static Color mainColor = "#0B0F19".toColor();
  static Color lightMainColor = "#F1F2F4".toColor();
  static Color darkMainColor = "#05070C".toColor();

  /// Text
  static Color textColor = "#0B0F19".toColor();
  static Color subTextColor = "#8B8F98".toColor();
  static Color mutedTextColor = "#6B7280".toColor();
  static Color hintGrey = "#9AA0AC".toColor();

  /// Surfaces
  static Color backgroundColor = "#FFFFFF".toColor();
  static Color screenBackgroundColor = "#F1F2F5".toColor();
  static Color lightGrey = "#F1F2F4".toColor();
  static Color cardColors = "#F1F2F4".toColor();
  static Color borderColor = "#E4E5EA".toColor();
  static Color dividerColor = "#F1F2F4".toColor();

  /// Shimmer / skeleton loading
  static Color shimmerBaseColor = "#ECEDF0".toColor();
  static Color shimmerHighlightColor = "#E1E2E7".toColor();

  /// Semantic status — rate direction, banners, feedback
  static Color successColor = "#16A34A".toColor();
  static Color errorColor = "#DC2626".toColor();
  static Color errorLightColor = "#FBEAEA".toColor();
  static Color neutralColor = "#9AA0AC".toColor();
  static Color warningColor = "#92661A".toColor();
  static Color warningBackgroundColor = "#FDF3E7".toColor();
  static Color warningBorderColor = "#F5DFB8".toColor();

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
