import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizeApplication/regularize_apply_controller.dart';

class RegularizeApplyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> RegularizeApplyController());
  }

}