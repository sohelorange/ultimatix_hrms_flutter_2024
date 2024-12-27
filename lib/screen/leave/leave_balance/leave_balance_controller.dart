import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_balance/leave_balance_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';

import '../../../utility/preference_utils.dart';

class LeaveBalanceController extends GetxController {
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
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ].obs;

  RxList<String> yearItems =
      <String>['2024', '2025', '2026', '2027', '2028', '2029', '2030'].obs;

  Rx<LeaveBalanceModel> leaveBalListResponse = LeaveBalanceModel().obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    RxInt currentYear = now.year.obs;
    RxInt currentMonth = now.month.obs;
    onLeaveBalanceAPI(currentYear.value, currentMonth.value);
  }

  Future<void> onLeaveBalanceAPI(int year, int month) async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> requestParam = {
          "month": month,
          "year": year,
          "empId": empID,
          "cmpId": cmpID
        };

        var response = await DioClient()
            .post(AppURL.getLeaveBalanceURL, requestParam);

        leaveBalListResponse.value = LeaveBalanceModel.fromJson(response);
        if (leaveBalListResponse.value.code == 200 &&
            leaveBalListResponse.value.status == true) {
          debugPrint("leave balance --$leaveBalListResponse");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveBalListResponse.value.message}");
        }
      } catch (e) {
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }
}
