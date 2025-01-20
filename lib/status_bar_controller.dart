import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StatusBarController extends GetxController {
  void setStatusBarColor({required Color color, Brightness? iconBrightness}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: iconBrightness ?? Brightness.light, // For Android
      statusBarBrightness: iconBrightness ?? Brightness.dark, // For iOS
    ));
  }
}
