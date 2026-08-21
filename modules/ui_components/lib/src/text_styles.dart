import 'package:core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  TextStyles._();
  static TextStyle body = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 16.0.sp,
  );
  static TextStyle bold = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 14.0.sp,
  );

  static TextStyle semiBold = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 14.0.sp,
  );
  static TextStyle medium = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 14.0.sp,
  );
  static TextStyle extraBold = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w900,
    fontSize: 14.0.sp,
  );
  static TextStyle light = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w300,
    fontSize: 14.0.sp,
  );

  /// Screen-level heading, e.g. "Exchange Rates".
  static TextStyle headline = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w800,
    fontSize: 26.0.sp,
  );

  /// Large emphasized value, e.g. a currency detail's big rate figure.
  static TextStyle displayValue = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w800,
    fontSize: 30.0.sp,
  );

  /// Row / list item title, e.g. currency name.
  static TextStyle rowTitle = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 15.0.sp,
  );

  /// Row / list item primary value, e.g. the rate.
  static TextStyle rowValue = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 15.0.sp,
  );

  /// Secondary caption text, e.g. currency code or a timestamp.
  static TextStyle caption = TextStyle(
    color: AppColors.subTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 12.5.sp,
  );

  /// Small uppercase section label, e.g. "LAST 7 DAYS".
  static TextStyle sectionLabel = TextStyle(
    color: AppColors.subTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 12.0.sp,
    letterSpacing: 0.6,
  );

  /// Rate change text (color is applied separately via the rate's direction).
  static TextStyle changeText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0.sp,
  );

  /// Body copy for error / empty state descriptions.
  static TextStyle bodySmall = TextStyle(
    color: AppColors.subTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 13.5.sp,
  );

  /// Button label text.
  static TextStyle button = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0.sp,
  );
}
