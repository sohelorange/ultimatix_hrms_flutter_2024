import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/family_edit_details/edit_family_details_controller.dart';

class EditFamilyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditFamilyDetailsController());
    //Get.put(
    //    EditFamilyDetailsController()); // Initialize the controller immediately
  }
}
