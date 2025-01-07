import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/manager_approval_controller.dart';

class ManagerApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManagerApprovalController());
  }
}
