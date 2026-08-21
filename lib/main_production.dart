import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'di/injection_container.dart';
import 'main_app/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  AppFlavor.instance.flavor = Flavor.production;
  runApp(const MainApp());
}
