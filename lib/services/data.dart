import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  SharedPreferences storage;
  bool inited = false;

  DataService({SharedPreferences instance}) {
    if (instance != null) {
      storage = instance;
      inited = true;
    } else {
      _initStorage();
    }
  }

  _initStorage() async {
    storage = await SharedPreferences.getInstance();
    inited = true;
  }

  Future<bool> setString(String key, String value) {
    return storage.setString(key, value);
  }

  String getString(String key) {
    return storage.getString(key);
  }

  Future<bool> remove(String key) {
    return storage.remove(key);
  }
}
