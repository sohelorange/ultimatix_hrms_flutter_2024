import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizeApprovals/regularization_approval_controller.dart';

class RegularizationApprovalBind extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> RegularizeApprovalController());
  }
}