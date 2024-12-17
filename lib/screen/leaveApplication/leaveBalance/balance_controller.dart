import 'package:flutter/animation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

class BalanceController extends GetxController  {

  var colors = <Color>[AppColors.color34A853, AppColors.colorEA4335, AppColors.colorDEA500, AppColors.color9675CE, AppColors.colorAAAE01].obs;

  void changeColor(int index, Color newColor) {
    colors[index] = newColor;
  }
}