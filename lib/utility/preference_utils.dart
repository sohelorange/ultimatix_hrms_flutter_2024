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
    return _prefsInstance?.getString(Constants.authTokenPref) ?? '';
  }

  static Future<bool> setAuthToken(String authToken) {
    ArgumentError.checkNotNull(authToken, Constants.authTokenPref);
    return _prefsInstance!.setString(Constants.authTokenPref, authToken);
  }

  static String getAppUrl() {
    return _prefsInstance?.getString(Constants.appUrlPref) ?? '';
  }

  static Future<bool> setAppUrl(String appUrl) {
    ArgumentError.checkNotNull(appUrl, Constants.appUrlPref);
    return _prefsInstance!.setString(Constants.appUrlPref, appUrl);
  }
}
