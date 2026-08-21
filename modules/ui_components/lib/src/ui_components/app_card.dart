import 'package:core/packages/screen_util/screen_util.dart';
import 'package:core/packages/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

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
  final EdgeInsetsGeometry? padding;
  final bool hasEndWidget;
  final bool hasStartWidget;
  final bool hasSubtitle;
  final Color? backgroundColor;
  final double? shadowOpacity;
  final Color? borderColor;
  final bool hasTextUnderLine;
  final bool hasShadow;
  final bool hasBorder;
  final bool bottomBorder;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;
  final double startWidgetSize;

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
      this.borderColor,
      this.hasShadow = true,
      this.hasBorder = true,
      this.bottomBorder = false,
      this.margin,
      this.isLoading = false,
      this.startWidgetSize = 38});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Container(
            margin:
                margin ?? EdgeInsetsDirectional.symmetric(vertical: 10.spMin),
            decoration: BoxDecoration(
              boxShadow: hasShadow
                  ? [
                      BoxShadow(
                        color:
                            Colors.grey.withValues(alpha: shadowOpacity ?? 0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(1, 1),
                      ),
                    ]
                  : null,
              borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
              border: bottomBorder
                  ? Border(
                      bottom: BorderSide(
                          color: borderColor ?? AppColors.dividerColor),
                    )
                  : hasBorder
                      ? Border.all(color: borderColor ?? Colors.white)
                      : null,
              color: backgroundColor ?? Colors.white,
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child:
                  isLoading ? _buildSkeleton(context) : _buildContent(context),
            ),
          );
        });
  }

  Widget _buildContent(BuildContext context) {
    return Row(
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
                      color:
                          titleColor ?? Theme.of(context).colorScheme.primary,
                      decoration: hasTextUnderLine
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor:
                          titleColor ?? Theme.of(context).colorScheme.primary,
                      fontSize: titleFontSize ?? 15.sp,
                      fontWeight: FontWeight.bold)),
              hasSubtitle
                  ? Text(
                      subTitle ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Row(
        children: [
          if (hasStartWidget)
            _skeletonBox(
              width: startWidgetSize,
              height: startWidgetSize,
              radius: 11,
            ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _skeletonBox(width: 88, height: 12),
                if (hasSubtitle) ...[
                  SizedBox(height: 6.h),
                  _skeletonBox(width: 44, height: 10),
                ],
              ],
            ),
          ),
          if (hasEndWidget)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _skeletonBox(width: 74, height: 12),
                SizedBox(height: 6.h),
                _skeletonBox(width: 64, height: 10),
              ],
            ),
        ],
      ),
    );
  }

  Widget _skeletonBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
