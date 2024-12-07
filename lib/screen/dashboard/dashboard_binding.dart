import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    //Get.put(DashboardController()); // Initialize the controller immediately
  }
}