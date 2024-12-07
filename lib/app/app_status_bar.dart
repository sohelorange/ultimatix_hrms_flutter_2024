import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStatusBar {
  /// Sets the status bar color and brightness.
  static void setStatusBarStyle({
    Color statusBarColor = Colors.transparent,
    Brightness statusBarIconBrightness = Brightness.dark,
    Brightness statusBarBrightness = Brightness.light, // For iOS
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      statusBarBrightness: statusBarBrightness,
    ));
  }
}
