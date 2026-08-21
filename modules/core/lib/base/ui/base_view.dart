import 'package:core/base/bloc/base_bloc.dart';
import 'package:core/packages/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui_components/ui_components.dart';

import '../../core.dart';

abstract class BaseView<T extends BaseCubit<S>, S extends BaseState>
    extends StatelessWidget {
  final bool isSheetView;
  final Color? screenBackGround;
  final bool? hasLoading;
  BaseView({
    super.key,
    this.isSheetView = false,
    this.screenBackGround,
    this.hasLoading = true,
  });

  Widget body(BuildContext context);

  final di = GetIt.instance;

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (context) => di<T>()..initState(),
      child: BlocConsumer<T, S>(
        listenWhen: (previous, current) {
          return previous.pageState != current.pageState;
        },
        listener: (context, state) {
          _handleStateChanges(context, state);
        },
        buildWhen: (previous, current) =>
            previous.pageState != current.pageState,
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(context),
            backgroundColor: screenBackGround ?? AppColors.backgroundColor,
            body: body(context),
          );
        },
      ),
    );
  }

  // static bool isErrorDialogShown = false;

  // onErrorDialog(
  //   BuildContext context, {
  //   String? image,
  //   String? title,
  //   String? subTitle,
  //   String? buttonTitle,
  //   bool? isDismissible,
  //   String? statusCode,
  //   void Function(BuildContext context)? onClickFunction,
  // }) async {
  //   if (isErrorDialogShown) return;
  //   isErrorDialogShown = true;
  //   try {
  //     BaseViewWidgets baseViewWidgets = BaseViewWidgets();
  //     await baseViewWidgets.showErrorDialog(
  //       context,
  //       image: image,
  //       statusCode: statusCode,
  //       title: title?.tr(),
  //       subTitle: subTitle?.tr(),
  //       buttonTitle: buttonTitle,
  //       isDismissible: isDismissible,
  //       onClickFunction: onClickFunction,
  //     );
  //   } finally {
  //     isErrorDialogShown = false;
  //   }
  // }

  // onErrorSheet(
  //   BuildContext context, {
  //   bool? isDismissible,
  //   String? iconPath,
  //   DialogType? dialogType,
  //   String? title,
  //   String? mainButtonText,
  //   Color? mainButtonColor,
  //   Color? mainButtonTextColor,
  //   String? secondButtonText,
  //   Color? secondaryButtonColor,
  //   Color? secondaryButtonTextColor,
  //   void Function(BuildContext context)? onMainActionFunction,
  //   void Function(BuildContext context)? onSecondaryActionFunction,
  // }) {
  //   BaseViewWidgets baseViewWidgets = BaseViewWidgets();
  //   baseViewWidgets.showBottomSheetDialog(
  //     context,
  //     isDismissible: isDismissible,
  //     iconPath: iconPath,
  //     dialogType: dialogType,
  //     title: title?.tr(),
  //     mainButtonText: mainButtonText,
  //     mainButtonColor: mainButtonColor,
  //     mainButtonTextColor: mainButtonTextColor,
  //     secondButtonText: secondButtonText,
  //     secondaryButtonColor: secondaryButtonColor,
  //     secondaryButtonTextColor: secondaryButtonTextColor,
  //     onMainActionFunction: onMainActionFunction,
  //     onSecondaryActionFunction: onSecondaryActionFunction,
  //   );
  // }

  /// Optional callback triggered when [PageState] changes to [success].
  void onSuccess(BuildContext context, S state) {}

  /// Optional callback triggered when [PageState] changes to [init].
  void onInitState(BuildContext context, S state) {}

  void _handleStateChanges(BuildContext context, S state) {
    switch (state.pageState) {
      case PageState.success:
        onSuccess(context, state);
        break;
      case PageState.errorWithDialog:
        // onErrorDialog(context,
        //     subTitle: state.failure?.message,
        //     image: state.failure?.imagePath,
        //     statusCode: state.failure?.code);
        break;

      case PageState.errorWithSheet:
        if (ModalRoute.of(context)?.isCurrent == true) {
          // onErrorSheet(context);
        }
        break;

      // No action needed for these states in the listener
      case PageState.init:
        onInitState(context, state);
        break;
      case PageState.loading:
      case PageState.failure:
      case PageState.shimmerLoading:
      case PageState.empty:
      case PageState.fetchComplete:
      case PageState.idle:
        break;
    }
  }
}
