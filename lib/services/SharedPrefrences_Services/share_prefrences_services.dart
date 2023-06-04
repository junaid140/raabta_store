

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices{

  Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> list = prefs.getStringList(key) ?? [];
    List<String> stringList = List<String>.from(list);
    return stringList;
  }

  Future<void> setStringList(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }
}