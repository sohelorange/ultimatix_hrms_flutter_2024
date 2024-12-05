import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_controller.dart';

class ServerConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServerConnectionController());
  }
}