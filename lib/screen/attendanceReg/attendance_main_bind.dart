import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/attendance_controller.dart';

class AttendanceMainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> AttendanceMainController());
  }
}