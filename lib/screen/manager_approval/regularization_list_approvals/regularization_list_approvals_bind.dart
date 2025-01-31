import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/regularization_list_approvals/regularization_list_approvals_controller.dart';

class RegularizationListApprovalsBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegularizationListApprovalsController());
  }
}
