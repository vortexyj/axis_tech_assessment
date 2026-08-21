import 'package:core/utils/values/app_values.dart';
import 'package:flutter/material.dart';

class MainPadding extends StatelessWidget {
  final Widget child;

  const MainPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: AppValues.padding_24,
          top: AppValues.paddingTop_16,
          end: AppValues.padding_24,
          bottom: AppValues.padding_33),
      child: child,
    );
  }
}
