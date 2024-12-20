import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/feedback/feedback_controller.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController());
  }
}
