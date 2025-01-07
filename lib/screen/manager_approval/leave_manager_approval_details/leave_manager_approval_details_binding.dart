import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/leave_manager_approval_details/leave_manager_approval_details_controller.dart';

class LeaveManagerApprovalDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveManagerApprovalDetailsController());
  }
}
