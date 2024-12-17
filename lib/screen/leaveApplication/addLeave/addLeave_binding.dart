import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/addLeave/addLeave_controller.dart';

class AddleaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddleaveController());

  }
}