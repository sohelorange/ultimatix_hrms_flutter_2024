import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/forgotpassword/forgot_pass_controller.dart';

class ForgotPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPassController());
  }
}
