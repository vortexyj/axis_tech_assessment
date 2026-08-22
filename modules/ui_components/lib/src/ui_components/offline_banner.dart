import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../text_styles.dart';

/// Amber banner for showing cached data while offline — an overlay on the
/// loaded list, not a separate screen state. e.g. "Offline — showing cached
/// rates from 9:41 AM".
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key, this.cachedAt, this.message});

  /// When the cached data being shown was originally fetched.
  final DateTime? cachedAt;

  /// Overrides the default "Offline — showing cached rates from ..." text.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.padding_10 + 2,
        vertical: AppValues.padding_10,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningBackgroundColor,
        border: Border.all(color: AppColors.warningBorderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.wifi_off_rounded, size: 16, color: AppColors.warningColor),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              message ?? _defaultMessage,
              style: TextStyles.changeText.copyWith(
                color: AppColors.warningColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get _defaultMessage {
    if (cachedAt == null) return 'Offline — showing cached rates.';
    final formatted = DateFormat('h:mm a').format(cachedAt!);
    return 'Offline — showing cached rates from $formatted';
  }
}
