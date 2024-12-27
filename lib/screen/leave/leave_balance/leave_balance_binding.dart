import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_balance/leave_balance_controller.dart';

class LeaveBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveBalanceController());
  }
}
