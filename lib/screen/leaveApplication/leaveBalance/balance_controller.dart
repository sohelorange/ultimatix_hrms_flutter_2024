import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveBalance/leave_balance_model.dart';

class BalanceController extends GetxController {
  RxBool isLoading = true.obs;

  final List<Color> colors = [
    AppColors.colorF9FCFA,
    AppColors.colorFEF9F9,
    AppColors.colorFEFCF7,
    AppColors.colorF8FCFE,
    AppColors.colorFCFBFE
  ];

  RxInt selectedYear = 0.obs;
  RxInt selectedMonth = 0.obs;
  RxList<String> items = <String>[
    'January',
    'February',
    'March',
    'April',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ].obs;

  RxString defaultYearValue = '2024'.obs;
  RxList<String> yearItems =
      <String>['2024', '2025', '2026', '2027', '2028', '2029', '2030'].obs;

  Rx<Leavebalancemodel> leavebalnceListResponse = Leavebalancemodel().obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    RxInt currentYear = now.year.obs;
    RxInt currentMonth = now.month.obs;

    debugPrint("yearmon --${currentMonth.value},${currentYear.value}");
    onLeavebalanceAPI(currentYear.value, currentMonth.value);
  }

  Future<void> onLeavebalanceAPI(int year, int month) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> requestParam = {
        "month": month,
        "year": year,
        "empId": 0,
        "cmpId": 0
      };

      var response = await DioClient()
          .post(AppURL.getLeaveBalanceWithDataURL, requestParam);
      debugPrint("res --$response");

      leavebalnceListResponse.value = Leavebalancemodel.fromJson(response);
      if (leavebalnceListResponse.value.code == 200 &&
          leavebalnceListResponse.value.status == true) {
        debugPrint("leave balance --$leavebalnceListResponse");
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${leavebalnceListResponse.value.message}");
      }
    } catch (e) {
      debugPrint("Login catch --$e");
    } finally {
      isLoading.value = false;
    }
  }

}
