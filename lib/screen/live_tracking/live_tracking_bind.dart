import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/live_tracking/live_tracking_controller.dart';

class LiveTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveTrackingController());
  }
}
