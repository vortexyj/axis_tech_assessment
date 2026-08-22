library local_storage;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../local_storage.dart';

abstract class LocalStorage {
  Future<void> setValue({
    required ValueTypes value,
    required String key,
    bool isSecureStorage = false,
  });

  Future<void> localStorageInit();

  Future<ValueTypes> getValue({
    required String key,
    bool isSecureStorage = false,
  });

  Set<String> getStorageKeys();

  Future<bool> containsKey({
    required String key,
    bool isSecureStorage = false,
  });

  void removeKey({
    required String key,
    bool isSecureStorage = false,
  });

  void flushStorage();
}

class LocalStorageImp implements LocalStorage {
  final SharedPreferences pref;
  final FlutterSecureStorage secureStorage;

  LocalStorageImp({
    required this.pref,
    required this.secureStorage,
  });

  @override
  Future<void> localStorageInit() async {}

  @override
  Future<bool> containsKey({
    required String key,
    bool isSecureStorage = false,
  }) async {
    if (!isSecureStorage) {
      return pref.containsKey(key);
    } else {
      return await secureStorage.containsKey(key: key);
    }
  }

  @override
  Future<void> removeKey({
    required String key,
    bool isSecureStorage = false,
  }) async {
    if (!isSecureStorage) {
      pref.remove(key);
    } else {
      await secureStorage.delete(key: key);
    }
  }

  @override
  Future<void> setValue({
    required ValueTypes value,
    required String key,
    bool isSecureStorage = false,
  }) async {
    switch (value.runtimeType) {
      case IntType:
        if (!isSecureStorage) {
          pref.setInt(key, value.value);
        } else {
          await secureStorage.write(key: key, value: value.value);
        }
        break;
      case StringType:
        if (!isSecureStorage) {
          pref.setString(key, value.value);
        } else {
          await secureStorage.write(key: key, value: value.value);
        }

        break;
      case StringListType:
        if (!isSecureStorage) {
          pref.setStringList(key, value.value);
        } else {
          await secureStorage.write(key: key, value: value.value);
        }

        break;
      case BoolType:
        if (!isSecureStorage) {
          pref.setBool(key, value.value);
        } else {
          await secureStorage.write(key: key, value: value.value);
        }

        break;
      case DoubleType:
        if (!isSecureStorage) {
          pref.setDouble(key, value.value);
        } else {
          await secureStorage.write(key: key, value: value.value);
        }

        break;
      default:
        throw Exception("data type is not implemented");
    }
  }

  @override
  Future<ValueTypes> getValue({
    required String key,
    bool isSecureStorage = false,
  }) async {
    dynamic value =
        !isSecureStorage ? pref.get(key) : await secureStorage.read(key: key);
    switch (value.runtimeType) {
      case int:
        return IntType(value);
      case String:
        return StringType(value);
      case List<String>:
        return StringListType(value);
      case bool:
        return BoolType(value);
      case double:
        return DoubleType(value);
      default:
        throw Exception("unExcepted value");
    }
  }

  @override
  Set<String> getStorageKeys() {
    return pref.getKeys();
  }

  @override
  void flushStorage() {
    removeKey(key: StorageKeys.userSecr, isSecureStorage: true);
    removeKey(key: StorageKeys.terms, isSecureStorage: true);
    removeKey(key: StorageKeys.usingBiometrics);
    removeKey(key: StorageKeys.isFirstOnboarding);
    removeKey(key: StorageKeys.userPhoneNumber, isSecureStorage: true);
  }
}
