import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/add_leave/add_leave_controller.dart';

class AddLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddLeaveController());
  }
}
