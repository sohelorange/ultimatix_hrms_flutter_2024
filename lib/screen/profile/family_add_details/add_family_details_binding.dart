import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/family_add_details/add_family_details_controller.dart';

class AddFamilyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFamilyDetailsController());
    //Get.put(
    //    AddFamilyDetailsController()); // Initialize the controller immediately
  }
}
