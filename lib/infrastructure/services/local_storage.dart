import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStore {
  LocalStore._();

//------------------ - Theme - ---------------//
  static setTheme(bool isLight) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    store.setBool("theme", isLight);
  }

  static Future<bool> getTheme() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    return store.getBool("theme") ?? false;
  }


  //------------------ - DocID - ---------------//
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

  //------------------ - OnBoarding - ---------------//
  static setOnBoarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("OnBoarding", false);
  }

  static getOnBoarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("OnBoarding") ?? true;
  }


  //------------------ - ALLClear - ---------------//
  static storeClear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
