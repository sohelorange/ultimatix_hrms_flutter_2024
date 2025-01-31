import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

class LeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? leaveTabController;

  RxString cmpImageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    cmpImageUrl.value = loginData['cmp_Logo'] ?? '';
    leaveTabController = TabController(length: 2, vsync: this);
  }
}
