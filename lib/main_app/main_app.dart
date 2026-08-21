import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
part 'app.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.home});
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return _App();
    //  MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => di.di<PreferencesBloc>(),
    //     ),
    //     BlocProvider(
    //       create: (context) => di.di<UserCubit>(),
    //     ),
    //   ],
    //   child: EasyLocalization(
    //       supportedLocales: const [AppConst.arLocale, AppConst.enLocale],
    //       path: AppConst.localizationPath,
    //       fallbackLocale: AppConst.enLocale,
    //       saveLocale: true,
    //       startLocale: AppConst.enLocale,
    //       child: _App(),
    //   ),
    // );
  }
}
