import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/explore/explore_controller.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreController());
  }
}