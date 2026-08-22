import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../text_styles.dart';

/// A pill-shaped action button. Defaults to the primary (solid, dark) style;
/// pass [backgroundColor] / [textColor] for the secondary (light) style.
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
    final Color resolvedBackground = isEnabled
        ? (backgroundColor ?? AppColors.mainColor)
        : AppColors.hintGrey.withValues(alpha: 0.3);
    final Color resolvedTextColor =
        isEnabled ? (textColor ?? Colors.white) : Colors.white;

    return SizedBox(
      width: width,
      height: height ?? 44.h,
      child: Material(
        color: resolvedBackground,
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            if (isEnabled) {
              onClickFunction(context);
            } else {
              onDisabledFunction?.call();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: (style ?? TextStyles.button).copyWith(
                  color: resolvedTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
