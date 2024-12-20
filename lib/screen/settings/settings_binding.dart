import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}