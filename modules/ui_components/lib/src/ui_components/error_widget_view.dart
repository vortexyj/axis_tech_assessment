import 'package:core/core.dart';
import 'package:core/packages/easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';

class ErrorWidgetView extends StatelessWidget {
  const ErrorWidgetView({
    super.key,
    required this.image,
    required this.title,
    required this.buttonTitle,
    this.subTitle,
    required this.onClickFunction,
  });

  final String image;
  final String? title;
  final String? subTitle;
  final String buttonTitle;
  final void Function(BuildContext) onClickFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // AssetImageView(
          //   path: image,
          // ),
          const SizedBox(
            height: AppValues.padding_24,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title ?? AppValues.errorButtonText.tr(),
              style: TextStyles.bold.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: AppValues.padding_16,
          ),
          Text(
            subTitle ?? '',
            style: TextStyles.light.copyWith(color: AppColors.subTextColor),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: ButtonView(
              //       onClickFunction: onClickFunction,
              //       title: buttonTitle,
              //       style: TextStyles.bold
              //           .copyWith(color: AppColors.backgroundColor),
              //       backgroundColor: AppColors.mainColor,
              //     )),
              const SizedBox(
                height: AppValues.padding_10,
              )
            ],
          )
        ],
      ),
    );
  }
}
