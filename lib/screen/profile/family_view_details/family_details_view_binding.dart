import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/family_view_details/family_details_view_controller.dart';

class FamilyDetailsViewBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut(() => FamilyDetailsViewController());
    Get.put(
        FamilyDetailsViewController()); // Initialize the controller immediately
  }
}
