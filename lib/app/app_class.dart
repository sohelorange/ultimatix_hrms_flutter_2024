import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Top level app class
class AppClass {
  static final AppClass _singleton = AppClass._internal();

  factory AppClass() {
    return _singleton;
  }

  AppClass._internal();

  RxBool isShowLoading = false.obs;

  RxString version = ''.obs;

  /// Show-hide top level loading
  void showLoading(bool value) {
    isShowLoading.value = value;
  }

  /// Remove splash screen once other UI is become visible
  // void removeSplash() {
  //   FlutterNativeSplash.remove();
  // }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;

    debugPrint('object : $version');
    debugPrint('version :: $version');
  }
}
