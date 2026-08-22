import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/src/enums.dart';
import '../../ui_components.dart';

/// A rounded-top modal sheet: optional icon, title, body copy / custom
/// content, and one or two pill action buttons.
class BottomSheetView extends StatelessWidget {
  final String? title, secondButtonText, mainButtonText, content;
  final Widget? contentWidget;
  final Widget? iconWidget;
  final Function(BuildContext)? onMainActionFunction, onSecondaryActionFunction;
  final DialogType? dialogType;
  final bool isCloseIcon;
  final bool isDismissible;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? contentColor;
  final Color? mainButtonColor;
  final Color? secondaryButtonColor;
  final Color? mainButtonTextColor;
  final Color? secondaryButtonTextColor;

  const BottomSheetView({
    super.key,
    this.title,
    this.content,
    this.contentWidget,
    this.isCloseIcon = false,
    this.isDismissible = true,
    this.secondButtonText,
    this.onMainActionFunction,
    this.dialogType,
    this.onSecondaryActionFunction,
    this.iconWidget,
    this.mainButtonText,
    this.mainButtonColor,
    this.titleColor,
    this.secondaryButtonColor,
    this.mainButtonTextColor,
    this.secondaryButtonTextColor,
    this.backgroundColor,
    this.contentColor,
  });

  static dynamic showBottomSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
  }) async {
    dynamic value = await showModalBottomSheet(
        isDismissible: isDismissible,
        isScrollControlled: true,
        enableDrag: isDismissible,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: builder);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final hasMainButton =
        mainButtonText != null && onMainActionFunction != null;
    final hasSecondaryButton =
        secondButtonText != null && onSecondaryActionFunction != null;

    return Material(
      color: Colors.transparent,
      child: PopScope(
        canPop: isDismissible,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          child: Container(
            width: double.infinity,
            color: backgroundColor ?? AppColors.backgroundColor,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppValues.padding_24,
                  AppValues.padding_10,
                  AppValues.padding_24,
                  AppValues.padding_20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.borderColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                    if (isCloseIcon)
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(CupertinoIcons.clear, size: 20),
                          ),
                        ),
                      ),
                    if (iconWidget != null) ...[
                      const SizedBox(height: AppValues.padding_16),
                      iconWidget!,
                    ],
                    if (title != null) ...[
                      const SizedBox(height: AppValues.padding_16),
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyles.bold.copyWith(
                            fontSize: 18,
                            color: titleColor ?? AppColors.textColor),
                      ),
                    ],
                    if (content != null) ...[
                      const SizedBox(height: AppValues.padding_8),
                      Text(
                        content!,
                        textAlign: TextAlign.center,
                        style: TextStyles.bodySmall.copyWith(
                            color: contentColor ?? AppColors.subTextColor),
                      ),
                    ],
                    if (contentWidget != null) ...[
                      const SizedBox(height: AppValues.padding_16),
                      contentWidget!,
                    ],
                    if (hasMainButton || hasSecondaryButton) ...[
                      const SizedBox(height: AppValues.padding_24),
                      Row(
                        children: [
                          if (hasSecondaryButton)
                            Expanded(
                              child: AppButtonView(
                                backgroundColor: secondaryButtonColor ??
                                    AppColors.lightMainColor,
                                textColor: secondaryButtonTextColor ??
                                    AppColors.textColor,
                                title: secondButtonText!,
                                onClickFunction: onSecondaryActionFunction!,
                              ),
                            ),
                          if (hasMainButton && hasSecondaryButton)
                            const SizedBox(width: AppValues.padding_10),
                          if (hasMainButton)
                            Expanded(
                              child: AppButtonView(
                                backgroundColor: mainButtonColor ??
                                    dialogType?.color ??
                                    AppColors.mainColor,
                                textColor: mainButtonTextColor ?? Colors.white,
                                title: mainButtonText!,
                                onClickFunction: onMainActionFunction!,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
