import 'package:shared_preferences/shared_preferences.dart';
import 'i_local_storage.dart';

class SharedPrefsStorage implements ILocalStorage {
  final SharedPreferences prefs;

  SharedPrefsStorage(this.prefs);

  @override
  Future<List<String>?> getStringList(String key) async {
    return prefs.getStringList(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }
}