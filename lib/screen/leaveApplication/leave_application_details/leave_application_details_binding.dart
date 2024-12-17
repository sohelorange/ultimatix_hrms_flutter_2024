import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leave_application_details/leave_application_details_controller.dart';

class LeaveApplicationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveApplicationDetailsController());
  }
}