import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_theme.dart';

import '../utility/preference_utils.dart';


class AppThemeController extends ChangeNotifier {
  /*ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;

  bool get isDarkTheme => _currentTheme.brightness == Brightness.dark;

  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeData.light()
        ? ThemeData.dark()
        : ThemeData.light();
    notifyListeners();
  }*/

  //TODO : Without pref store
  /*ThemeData _currentTheme = ThemeClass.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  bool get isDarkTheme => _currentTheme == ThemeClass.darkTheme;

  void toggleTheme() {
    _currentTheme = (_currentTheme == ThemeClass.lightTheme)
        ? ThemeClass.darkTheme
        : ThemeClass.lightTheme;
    notifyListeners();
  }*/

  //TODO : With pref store
  ThemeData? _currentTheme;

  AppThemeController() {
    _loadTheme();
  }

  ThemeData get currentTheme => _currentTheme ?? AppTheme.lightTheme;

  bool get isDarkTheme => _currentTheme == AppTheme.darkTheme;

  void toggleTheme() {
    _currentTheme = (_currentTheme == AppTheme.lightTheme)
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;
    _saveTheme();
    notifyListeners();
  }

  void setLightTheme() {
    _currentTheme = AppTheme.lightTheme;
    _saveTheme();
    notifyListeners();
  }

  // Load theme from shared preferences using PreferenceUtils
  Future<void> _loadTheme() async {
    bool isDarkTheme = PreferenceUtils.getIsTheme();
    _currentTheme = isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }

  // Save theme to shared preferences using PreferenceUtils
  Future<void> _saveTheme() async {
    await PreferenceUtils.setIsTheme(isDarkTheme);
  }
}
