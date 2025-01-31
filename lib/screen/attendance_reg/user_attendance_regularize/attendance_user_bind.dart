import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendance_reg/user_attendance_regularize/attendance_user_controller.dart';

class AttendanceUserBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserAttendanceController());
  }
}
