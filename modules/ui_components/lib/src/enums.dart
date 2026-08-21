import 'package:flutter/material.dart';

import 'app_colors.dart';

enum DialogType { infoDialog, successDialog, warningDialog, errorDialog }

extension DialogTypeExtension on DialogType {
  Color get color {
    switch (this) {
      case DialogType.infoDialog:
        return AppColors.mainColor;
      case DialogType.successDialog:
        return AppColors.mainColor;
      case DialogType.warningDialog:
        return AppColors.warningColor;
      case DialogType.errorDialog:
        return AppColors.mainColor;
    }
  }

  Color get secondColor {
    switch (this) {
      case DialogType.infoDialog:
        return AppColors.backgroundColor;
      case DialogType.successDialog:
        return AppColors.backgroundColor;
      case DialogType.warningDialog:
        return AppColors.backgroundColor;
      case DialogType.errorDialog:
        return AppColors.backgroundColor;
    }
  }
}
