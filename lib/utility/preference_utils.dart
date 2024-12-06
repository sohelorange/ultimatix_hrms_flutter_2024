import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance ??= await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  static Future<void> clearAllPreferences() async {
    await _prefsInstance?.clear();
  }

  static bool getIsTheme() {
    return _prefsInstance?.getBool(Constants.isThemePref) ?? false;
  }

  static Future<bool> setIsTheme(bool isTheme) {
    ArgumentError.checkNotNull(isTheme, Constants.isThemePref);
    return _prefsInstance!.setBool(Constants.isThemePref, isTheme);
  }

  static String getFCMId() {
    return _prefsInstance?.getString(Constants.fcmIdPref) ?? '';
  }

  static Future<bool> setFCMId(String fcmId) {
    ArgumentError.checkNotNull(fcmId, Constants.fcmIdPref);
    return _prefsInstance!.setString(Constants.fcmIdPref, fcmId);
  }

  static bool getIsLogin() {
    return _prefsInstance?.getBool(Constants.isLoginPref) ?? false;
  }

  static Future<bool> setIsLogin(bool isLogin) {
    ArgumentError.checkNotNull(isLogin, Constants.isLoginPref);
    return _prefsInstance!.setBool(Constants.isLoginPref, isLogin);
  }

  static String getAuthToken() {
    return /*_prefsInstance?.getString(Constants.authTokenPref) ?? */'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJMb2dpbl9JRCI6IjIxNzc0IiwiQ21wX0lEIjoiMTg3IiwiRW1wX0lEIjoiMjgxOTkiLCJEZXB0X0lEIjoiNTA1IiwiQWxwaGFfRW1wX0NvZGUiOiIwMDU4IiwiRW1wX0Z1bGxfTmFtZSI6IjAwNTggLSBNci4gQVAgQk0iLCJEZXB0X05hbWUiOiJTb2Z0d2FyZSIsIkRlc2lnTmFtZSI6Ik1BTkFHRVIiLCJEZXZpY2VUb2tlbiI6InN0cmluZyIsIm5iZiI6MTczMzM5NTY4NywiZXhwIjoxNzM1OTg3Njg3LCJpYXQiOjE3MzMzOTU2ODd9.C0XjeTwXI4gTati4mTdiPMtwZLR5I16hQo0VNKJr1is';
  }

  static Future<bool> setAuthToken(String authToken) {
    ArgumentError.checkNotNull(authToken, Constants.authTokenPref);
    return _prefsInstance!.setString(Constants.authTokenPref, authToken);
  }

  static String getAppUrl() {
    return _prefsInstance?.getString(Constants.appUrlPref) ?? 'http://192.168.1.200:8080/';
  }

  static Future<bool> setAppUrl(String appUrl) {
    ArgumentError.checkNotNull(appUrl, Constants.appUrlPref);
    return _prefsInstance!.setString(Constants.appUrlPref, appUrl);
  }
}
