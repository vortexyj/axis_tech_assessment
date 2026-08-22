import 'package:core/core.dart';
import 'package:currency_details/currency_details_screen_router.dart';
import 'package:exchange/exchange_screen_router.dart';
import 'package:flutter/material.dart';
import '../../cubits/splash/splash_cubit.dart';

class SplashScreenView extends BaseView<SplashCubit, SplashState> {
  static const String id = '/SplashScreenView';
  SplashScreenView({super.key});
  @override
  void onSuccess(BuildContext context, SplashState state) {
    Navigator.pushNamed(context, ExchangeScreens.exchangeScreen);
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back to the currency exchange project',
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Icon(Icons.currency_exchange, color: Colors.white, size: 50.r),
            SizedBox(height: 16.h),
            Text(
              'By Youssef Jehad',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
