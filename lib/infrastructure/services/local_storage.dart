import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStore {
  LocalStore._();

  static setDocId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", id);
  }

  static Future<String?> getDocId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("id");
  }

  static removeDocId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("id");
  }

  static setOnBoarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("OnBoarding", true);
  }

  static getOnBoarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("OnBoarding");
  }

  static storeClear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
