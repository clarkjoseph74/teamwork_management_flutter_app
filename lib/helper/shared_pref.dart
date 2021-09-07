import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;
  static initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveStringInSHaredPref(
      {required String key, required String value}) async {
    prefs.setString(key, value);
  }

  static getStringFromSHaredPref({required String key}) async {
    var result = prefs.getString(key);
    return result;
  }

  static shaerdClear() async {
    prefs.remove('logined');
  }
}
