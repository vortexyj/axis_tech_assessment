import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDI {
  LocalStorageDI(this.di);

  final GetIt di;

  Future<void> call() async {
    final prefs = await SharedPreferences.getInstance();
    const secure = FlutterSecureStorage();
    di.registerSingleton<SharedPreferences>(prefs);
    di.registerSingleton<FlutterSecureStorage>(secure);
    di.registerSingleton<LocalStorage>(
      LocalStorageImp(pref: prefs, secureStorage: secure),
    );
  }
}
