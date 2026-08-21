import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/src/enums.dart';

class BottomSheetView extends StatelessWidget {
  final String? title, secondButtonText, mainButtonText, content;
  final Widget? contentWidget;
  final Widget? iconWidget;
  final Function(BuildContext)? onMainActionFunction, onSecondaryActionFunction;
  final DialogType dialogType;
  final bool isCloseIcon;
  final bool isDismissible;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? contentColor;
  final Color? mainButtonColor;
  final Color? secondaryButtonColor;
  final Color? mainButtonTextColor;
  final Color? secondaryButtonTextColor;
  final bool nobuttonWidth;

  const BottomSheetView({
    super.key,
    this.title,
    this.content,
    this.contentWidget,
    this.isCloseIcon = false,
    this.isDismissible = true,
    this.secondButtonText,
    this.onMainActionFunction,
    required this.dialogType,
    this.onSecondaryActionFunction,
    this.iconPath,
    this.iconWidget,
    this.mainButtonText,
    this.mainButtonColor,
    this.titleColor,
    this.secondaryButtonColor,
    this.mainButtonTextColor,
    this.secondaryButtonTextColor,
    this.backgroundColor,
    this.contentColor,
    this.nobuttonWidth = false,
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
    return Wrap(
      children: [
        Material(
          color: Colors.transparent,
          child: PopScope(
            canPop: isDismissible,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
              child: Container(
                color:
                    backgroundColor ?? Theme.of(context).colorScheme.onSurface,
                child: Stack(
                  children: [
                    if (isCloseIcon == true)
                      PositionedDirectional(
                        end: 15.sp,
                        top: 20.sp,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              // padding: EdgeInsets.all(10.sp),
                              alignment: AlignmentDirectional.topStart,
                              child: const Icon(CupertinoIcons.clear,
                                  color: Colors.black)),
                        ),
                      ),
                    // Column(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 20.sp),
                    //       child: const DividerWidget(),
                    //     ),
                    //     Column(
                    //       children: [
                    //         if (iconPath != null)
                    //           Container(
                    //             alignment: AlignmentDirectional.topCenter,
                    //             child: AssetImageView(
                    //               path: iconPath!,
                    //             ),
                    //           ),
                    //         if (iconWidget != null) iconWidget!,
                    //         Container(
                    //           padding: EdgeInsets.only(
                    //               right: 0.03.sw, left: 0.03.sw, bottom: 15.sp),
                    //           child: Column(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Column(
                    //                 children: [
                    //                   if (title != null)
                    //                     Padding(
                    //                       padding: EdgeInsets.only(
                    //                           right: 0.04.sw,
                    //                           left: 0.04.sw,
                    //                           top: 0.01.sh),
                    //                       child: Text(
                    //                         title!,
                    //                         textAlign: TextAlign.center,
                    //                         style: Theme.of(context)
                    //                             .textTheme
                    //                             .headlineLarge
                    //                             ?.copyWith(
                    //                               color: titleColor ??
                    //                                   Theme.of(context)
                    //                                       .colorScheme
                    //                                       .onPrimary,
                    //                               fontSize: 18.sp,
                    //                             ),
                    //                       ),
                    //                     ),
                    //                   if (content != null)
                    //                     Padding(
                    //                       padding: EdgeInsets.only(
                    //                           right: 0.04.sw,
                    //                           left: 0.04.sw,
                    //                           top: 0.01.sh),
                    //                       child: Text(content!,
                    //                           textAlign: TextAlign.center,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyMedium
                    //                               ?.copyWith(
                    //                                 color: contentColor ??
                    //                                     Theme.of(context)
                    //                                         .colorScheme
                    //                                         .onPrimary,
                    //                                 fontSize: 16.sp,
                    //                               )),
                    //                     ),
                    //                   if (contentWidget != null)
                    //                     Padding(
                    //                       padding: EdgeInsets.only(
                    //                         right: 0.04.sw,
                    //                         left: 0.04.sw,
                    //                       ),
                    //                       child: contentWidget,
                    //                     ),
                    //                   SizedBox(
                    //                     height: 0.02.sh,
                    //                   ),
                    //                 ],
                    //               ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     if (mainButtonText != null &&
                    //         onMainActionFunction != null)
                    //       ButtonView(
                    //           width: nobuttonWidth == true
                    //               ? null
                    //               : MediaQuery.of(context)
                    //                       .size
                    //                       .width *
                    //                   0.45,
                    //           backgroundColor: mainButtonColor ??
                    //               dialogType.getColor(context),
                    //           textColor: mainButtonTextColor,
                    //           title: mainButtonText!,
                    //           onClickFunction:
                    //               onMainActionFunction!),
                    //     if (secondButtonText != null &&
                    //         onSecondaryActionFunction != null)
                    //       const Expanded(child: SizedBox()),
                    //     if (secondButtonText != null &&
                    //         onSecondaryActionFunction != null)
                    //       ButtonView(
                    //         borderColor: Colors.transparent,
                    //         width: MediaQuery.of(context)
                    //                 .size
                    //                 .width *
                    //             0.45,
                    //         textColor: secondaryButtonTextColor ??
                    //             dialogType.getColor(context),
                    //         title: secondButtonText!,
                    //         onClickFunction:
                    //             onSecondaryActionFunction!,
                    //         backgroundColor:
                    //             secondaryButtonColor ??
                    //                 dialogType
                    //                     .getSecondColor(context),
                    //       ),
                    //   ],
                    // )
                  ],
                ),
              ),
              //             SafeArea(
              //               top: false,
              //               child: SizedBox(
              //                 height: 10.sp +
              //                     MediaQuery.of(context).viewInsets.bottom,
              //               ),
              //             )
              //           ],
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
