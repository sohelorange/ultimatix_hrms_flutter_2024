import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/geofence/geofence_controller.dart';

class GeofenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GeofenceController());

  }
}