import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_controller.dart';

class StatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveStatusController());
  }
}
