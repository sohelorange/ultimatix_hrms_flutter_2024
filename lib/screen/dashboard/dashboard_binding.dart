import 'package:get/get.dart';

import 'dash_board_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashController());
    //Get.put(DashboardController()); // Initialize the controller immediately
  }
}