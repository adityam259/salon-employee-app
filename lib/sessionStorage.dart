import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void storeSessionData(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getSessionData(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
