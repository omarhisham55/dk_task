import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController {
  final SharedPreferences sharedPrefs;

  SharedPrefsController({required this.sharedPrefs});

  Future<bool> delete(String key) async {
    return await sharedPrefs.remove(key);
  }

  Object? get(String key) {
    return sharedPrefs.get(key);
  }

  Future<bool> save(String key, var value) {
    return switch (value) {
      String() => sharedPrefs.setString(key, value),
      bool() => sharedPrefs.setBool(key, value),
      int() => sharedPrefs.setInt(key, value),
      double() => sharedPrefs.setDouble(key, value),
      Object() => Future.value(false),
      null => Future.value(false),
    };
  }
}
