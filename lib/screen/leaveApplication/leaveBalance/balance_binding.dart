import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveBalance/balance_controller.dart';

class BalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BalanceController());

  }
}