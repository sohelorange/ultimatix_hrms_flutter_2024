import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_controller.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveController());
  }
}
