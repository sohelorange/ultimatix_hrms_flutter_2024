import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_controller.dart';

class LeaveApplicationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LeaveApplicationDetailsController()); // Initialize the controller immediately
    //Get.lazyPut(() => LeaveApplicationDetailsController());
  }
}
