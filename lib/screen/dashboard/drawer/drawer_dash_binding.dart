import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/drawer/drawer_dash_controller.dart';

class DrawerDashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrawerDashController());
  }
}