import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/live_tracking/live_tracking_controller.dart';

import 'location_perm_controller.dart';

class LocationPermBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationPermController());
  }
}