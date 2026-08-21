import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget? startWidget;
  final Widget? endWidget;
  final String? title;
  final String? subTitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final double? radius;
  final double? padding;
  final bool hasEndWidget;
  final bool hasStartWidget;
  final bool hasSubtitle;
  final Color? backgroundColor;
  final double? shadowOpacity;
  final Color? borderColor;
  final bool hasTextUnderLine;

  const AppCard(
      {super.key,
      required this.title,
      this.subTitle,
      this.titleFontSize,
      this.subTitleFontSize,
      this.startWidget,
      this.titleColor,
      this.subTitleColor,
      this.radius,
      this.hasEndWidget = false,
      this.hasSubtitle = true,
      this.backgroundColor,
      this.hasStartWidget = false,
      this.endWidget,
      this.padding,
      this.shadowOpacity,
      this.hasTextUnderLine = false,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 10.spMin),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(shadowOpacity ?? 0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(1, 1),
              // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
          border: Border.all(
            color: borderColor ?? Colors.white,
          ),
          color: backgroundColor ?? Colors.white),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: Row(
          children: [
            hasStartWidget ? startWidget! : const SizedBox(),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: titleColor ??
                              Theme.of(context).colorScheme.primary,
                          decoration: hasTextUnderLine
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: titleColor ??
                              Theme.of(context).colorScheme.primary,
                          fontSize: titleFontSize ?? 15.sp,
                          fontWeight: FontWeight.w600)),
                  hasSubtitle // Check if subtitle should be shown
                      ? Text(
                          subTitle ?? "",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: subTitleColor ??
                                      Theme.of(context).colorScheme.primary,
                                  fontSize: subTitleFontSize ?? 12.sp,
                                  fontWeight: FontWeight.w500),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            hasEndWidget
                ? endWidget!
                : const SizedBox(
                    width: 8,
                  ),
          ],
        ),
      ),
    );
  }
}
