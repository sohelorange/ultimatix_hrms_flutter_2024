import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? leaveTabController;

  @override
  void onInit() {
    super.onInit();
    leaveTabController = TabController(length: 2, vsync: this);
  }
}
