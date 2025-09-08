import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajamae_super_admin/features/login/data/models/login_model.dart';

import '../utils/lang.dart';

class Caching {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static put({required String key, required dynamic value}) async {
    if (value is int) return await prefs?.setInt(key, value);
    if (value is bool) return await prefs?.setBool(key, value);
    if (value is double) return await prefs?.setDouble(key, value);
    if (value is String) return await prefs?.setString(key, value);
  }

  static get({required String key}) {
    return prefs?.get(key);
  }

  static removeData({required String key}) {
    return prefs?.remove(key);
  }

  static Future<void> clearAllData() async {
    await prefs?.clear();
  }

  static UserModel? getUser() {
    String? userPref = prefs?.getString("user_data");
    if (userPref == null) {
      return null;
    }
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    return UserModel.fromJson(userMap);
  }

  static Future<void> setUser(UserModel model) async {
    await prefs?.setString("user_data", jsonEncode(model.toJson()));
  }

  static Future<void> removeUser() async {
    await prefs?.remove("user_data");
  }

  ///languages
  static String getAppLang() {
    String? lang = prefs?.getString("language");
    if (lang != null && lang.isNotEmpty) {
      switch (lang) {
        case 'ar':
          return LanguageType.arabic.getValue;
        case 'en':
          return LanguageType.english.getValue;
      }
      return "";
    } else {
      return LanguageType.arabic.getValue;
    }
  }

  static Future<void> changeAppLang() async {
    String currentLang = getAppLang();
    if (currentLang == LanguageType.arabic.getValue) {
      await prefs?.setString("language", LanguageType.english.getValue);
    } else {
      await prefs?.setString("language", LanguageType.arabic.getValue);
    }
  }

  static Future<Locale> getLocal() async {
    String currentLang = getAppLang();
    if (currentLang == LanguageType.arabic.getValue) {
      return arabicLocal;
    } else {
      return englishLocal;
    }
  }
}
