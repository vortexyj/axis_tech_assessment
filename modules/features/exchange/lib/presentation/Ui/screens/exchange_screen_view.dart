import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../cubits/exchange/exchange_cubit.dart';

class ExchangeScreenView extends BaseView<ExchangeCubit, ExchangeState> {
  static const String id = '/ExchangeScreenView';
  ExchangeScreenView({super.key});
  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      AppBar(title: Text('Exchange Screen'));
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Default UI for ExchangeScreenView')),
    );
  }
}
