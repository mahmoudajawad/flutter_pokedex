import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  SharedPreferences storage;

  initStorage() async {
    storage = await SharedPreferences.getInstance();
  }

  Future<bool> setString(key, value) {
    return storage.setString(key, value);
  }

  String getString(key) {
    return storage.getString(key);
  }

  Future<bool> remove(key) {
    return storage.remove(key);
  }
}
