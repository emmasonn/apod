import 'package:shared_preferences/shared_preferences.dart';

abstract class Persistence {
  String? getKey(String key);
  void setKey(String key, dynamic value);
}

class SharedPreferencePersistence implements Persistence {
  SharedPreferencePersistence(this._sharedPrefs);
  final SharedPreferences _sharedPrefs;

  @override
  String? getKey(String key) => _sharedPrefs.getString(key);

  @override
  void setKey(String key, value) => _sharedPrefs.setString(key, value);
}
