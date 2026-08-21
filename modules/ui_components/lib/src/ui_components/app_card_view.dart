import 'package:core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

import '../../ui_components.dart';

class AppCardView extends StatelessWidget {
  const AppCardView({
    super.key,
    this.child,
    this.horizontalPadding,
  });

  final Widget? child;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16.sp),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(1, 1),
              // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15.0.sp),
          color: AppColors.backgroundColor),
      child: child,
    );
  }
}
