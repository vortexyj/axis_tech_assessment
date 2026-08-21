part of 'main_app.dart';

class _App extends StatefulWidget {
  const _App();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  Key _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        key: _key,
        title: AppFlavor.instance.title,
        debugShowCheckedModeBanner: false,
        home: SplashScreenView(),
      ),
    );
  }

  void restart() {
    setState(() => _key = UniqueKey());
  }
}
