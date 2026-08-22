import 'package:core/core.dart';
import 'package:core/packages/easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';

/// Generic centered state view for error / empty / "couldn't load" screens —
/// icon, title, subtitle and a single action button.
class ErrorWidgetView extends StatelessWidget {
  const ErrorWidgetView({
    super.key,
    this.icon = Icons.error_outline,
    required this.title,
    required this.buttonTitle,
    this.subTitle,
    required this.onClickFunction,
    this.buttonBackgroundColor,
    this.buttonTextColor,
  });

  final IconData icon;
  final String? title;
  final String? subTitle;
  final String buttonTitle;
  final void Function(BuildContext) onClickFunction;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.padding_40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 46,
              color: AppColors.hintGrey,
            ),
            const SizedBox(height: AppValues.padding_16),
            Text(
              title ?? AppValues.errorButtonText.tr(),
              style: TextStyles.bold.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            if (subTitle != null && subTitle!.isNotEmpty) ...[
              const SizedBox(height: AppValues.padding_8),
              Text(
                subTitle!,
                style: TextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppValues.padding_24),
            AppButtonView(
              backgroundColor: buttonBackgroundColor,
              textColor: buttonTextColor,
              title: buttonTitle,
              onClickFunction: onClickFunction,
            ),
          ],
        ),
      ),
    );
  }
}
