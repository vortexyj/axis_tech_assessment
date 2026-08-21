import 'package:core/packages/easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/src/enums.dart';
import '../../ui_components.dart';

class BaseViewWidgets {
  BaseViewWidgets();

  Future<dynamic> showErrorDialog(
    BuildContext context, {
    String? image,
    String? title,
    String? statusCode,
    String? subTitle,
    String? buttonTitle,
    bool? isDismissible,
    void Function(BuildContext context)? onClickFunction,
  }) {
    return BottomSheetView.showBottomSheet(
      context: context,
      isDismissible: isDismissible ?? true,
      builder: (bottomSheetContext) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: SafeArea(
            bottom: true,
            child: ErrorWidgetView(
              image: image ?? '',
              title: title ?? 'something_went_wrong'.tr(),
              subTitle: subTitle ?? 'oops'.tr(),
              buttonTitle: buttonTitle ?? 'retry'.tr(),
              onClickFunction: onClickFunction ??
                  (_) {
                    Navigator.pop(context);
                  },
            ),
          ),
        );
      },
    );
  }

  showBottomSheetDialog(
    BuildContext context, {
    bool? isDismissible,
    String? iconPath,
    DialogType? dialogType,
    String? title,
    String? mainButtonText,
    Color? mainButtonColor,
    Color? mainButtonTextColor,
    String? secondButtonText,
    Color? secondaryButtonColor,
    Color? secondaryButtonTextColor,
    void Function(BuildContext context)? onMainActionFunction,
    void Function(BuildContext context)? onSecondaryActionFunction,
  }) {
    BottomSheetView.showBottomSheet(
      context: context,
      isDismissible: isDismissible ?? true,
      builder: (bottomSheetContext) {
        return BottomSheetView(
          isDismissible: isDismissible ?? true,
          iconPath: iconPath ?? '',

          /// add image
          dialogType: dialogType ?? DialogType.errorDialog,
          title: title ?? 'Are you sure?',
          mainButtonText: mainButtonText ?? 'cancel'.tr(),
          mainButtonTextColor: mainButtonTextColor ?? AppColors.backgroundColor,
          mainButtonColor: mainButtonColor ?? AppColors.mainColor,
          secondButtonText: secondButtonText ?? 'OK'.tr(),
          secondaryButtonTextColor:
              secondaryButtonTextColor ?? AppColors.cardColors,
          secondaryButtonColor: secondaryButtonColor ?? AppColors.errorColor,
          onSecondaryActionFunction: onSecondaryActionFunction ?? (ctx) {},
          onMainActionFunction: onMainActionFunction ?? (ctx) {},
        );
      },
    );
  }
}
