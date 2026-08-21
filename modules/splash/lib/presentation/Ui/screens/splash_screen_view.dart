import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../cubits/splash/splash_cubit.dart';

class SplashScreenView extends BaseView<SplashCubit, SplashState> {
  static const String id = '/SplashScreenView';
  SplashScreenView({super.key});
  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      AppBar(title: Text('Splash Screen'));
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Default UI for SplashScreenView')),
    );
  }
}
