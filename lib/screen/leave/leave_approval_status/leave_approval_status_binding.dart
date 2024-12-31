import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_approval_status/leave_approval_status_controller.dart';

class LeaveApprovalStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveApprovalStatusController());
  }
}
