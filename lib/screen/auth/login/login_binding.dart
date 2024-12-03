import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
