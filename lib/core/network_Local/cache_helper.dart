import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences?.get(key);
  }

  static Future<void> savePlacemark(String key, Placemark placemark) async {
    final String placemarkJson = jsonEncode(placemark.toJson());
    await sharedPreferences!.setString(key, placemarkJson);
  }

  static Future<bool?> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences?.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is List) {
      final List<String> stringList =
      value.map((item) => item.toString()).toList();
      return await sharedPreferences!.setStringList(key, stringList);
    }
    if (value is List) {
      final List<String> stringList =
      value.map((item) => item.toString()).toList();
      return await sharedPreferences!.setStringList(key, stringList);
    }
    if (value is Placemark) {
      final String placemarkJson = jsonEncode(Placemark().toJson());
      return sharedPreferences!.setString(key, placemarkJson);
    }

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool?> removeData({
    required String key,
  }) async {
    return await sharedPreferences?.remove(key);
  }
}
