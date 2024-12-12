import 'dart:convert';

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

  static String getDeviceID() {
    return _prefsInstance?.getString(Constants.deviceIDPref) ?? '';
  }

  static Future<bool> setDeviceID(String deviceIDPref) {
    ArgumentError.checkNotNull(deviceIDPref, Constants.deviceIDPref);
    return _prefsInstance!.setString(Constants.deviceIDPref, deviceIDPref);
  }


  static String getServerConnection() {
    return _prefsInstance?.getString(Constants.serverConnectionPref) ?? '';
  }

  static Future<bool> setServerConnection(String serverConnectionPref) {
    ArgumentError.checkNotNull(serverConnectionPref, Constants.serverConnectionPref);
    return _prefsInstance!.setString(Constants.serverConnectionPref, serverConnectionPref);
  }

  static String getLoginUserID() {
    return _prefsInstance?.getString(Constants.loginUserIDPref) ?? '';
  }

  static Future<bool> setLoginUserID(String loginUserIDPref) {
    ArgumentError.checkNotNull(loginUserIDPref, Constants.loginUserIDPref);
    return _prefsInstance!
        .setString(Constants.loginUserIDPref, loginUserIDPref);
  }

  static String getLoginUserPassword() {
    return _prefsInstance?.getString(Constants.loginUserPasswordPref) ?? '';
  }

  static Future<bool> setLoginUserPassword(String loginUserPasswordPref) {
    ArgumentError.checkNotNull(
        loginUserPasswordPref, Constants.loginUserPasswordPref);
    return _prefsInstance!
        .setString(Constants.loginUserPasswordPref, loginUserPasswordPref);
  }

  static bool getIsRemember() {
    return _prefsInstance?.getBool(Constants.isRememberPref) ?? false;
  }

  static Future<bool> setIsRemember(bool isRememberPref) {
    ArgumentError.checkNotNull(isRememberPref, Constants.isRememberPref);
    return _prefsInstance!.setBool(Constants.isRememberPref, isRememberPref);
  }

  static Map<String, dynamic> getLoginDetails() {
    final loginDetailsString =
        _prefsInstance?.getString(Constants.loginDataPref) ?? '';
    if (loginDetailsString.isEmpty) {
      return {};
    } else {
      return json.decode(loginDetailsString);
    }
  }

  static Future<bool> setLoginDetails(Map<String, dynamic> loginDetails) async {
    final loginDetailsString = json.encode(loginDetails);
    return await _prefsInstance!
        .setString(Constants.loginDataPref, loginDetailsString);
  }

  static List<dynamic> getDetails() {
    final detailsString =
        _prefsInstance?.getString(Constants.loginDataPref) ?? '[]';
    return json.decode(detailsString);
  }

  static Future<bool> setDetails(List<dynamic> details) async {
    final detailsString = json.encode(details);
    return await _prefsInstance!
        .setString(Constants.loginDataPref, detailsString);
  }
}
