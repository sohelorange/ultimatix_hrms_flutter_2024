import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/leave_manager_approval/leave_manager_approval_controller.dart';

class LeaveManagerApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveManagerApprovalController());
  }
}
