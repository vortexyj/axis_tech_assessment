import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import '../../cubits/currency_details/currency_details_cubit.dart';

class CurrencyDetailsScreenView extends BaseView<CurrencyDetailsCubit,CurrencyDetailsState> {
  static const String id = '/CurrencyDetailsScreenView';
   CurrencyDetailsScreenView({super.key});
  @override
  PreferredSizeWidget? appBar(BuildContext context) => AppBar(title: Text('CurrencyDetails Screen'));
  @override
  Widget body(BuildContext context) {
   return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: const Center(child: Text('Default UI for CurrencyDetailsScreenView'))
    );
  }
}