import 'package:flutter/material.dart';

import '../../src/app_colors.dart';
import 'package:dsquares_mobile_design_system/dsquares_mobile_design_system.dart';

class AppButtonView extends StatelessWidget {
  const AppButtonView({
    super.key,
    this.backgroundColor,
    this.textColor,
    required this.title,
    required this.onClickFunction,
    this.width,
    this.height,
    this.style,
    this.isEnabled = true,
    this.onDisabledFunction,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final String title;
  final void Function(BuildContext) onClickFunction;
  final void Function()? onDisabledFunction;
  final double? width, height;
  final bool isEnabled;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget.withTitle(
      height: height,
      width: width,
      textColor: textColor,
      isEnabled: isEnabled,
      title: title,
      onClickFunction: onClickFunction,
      onDisabledFunction: onDisabledFunction,
      backgroundColor: AppColors.mainColor,
      disabledBackgroundColor: AppColors.hintGrey.withValues(alpha: 0.3),
      style: style,
    );
  }
}
