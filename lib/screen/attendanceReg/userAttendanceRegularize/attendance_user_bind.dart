import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/userAttendanceRegularize/attendance_user_controller.dart';

class AttendanceUserBind extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> UserAttendanceController());
  }
}