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
}
