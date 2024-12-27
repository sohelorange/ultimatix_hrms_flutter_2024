import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';

class LeaveStatusController extends GetxController {
  RxBool isLoading = true.obs;

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

  // RxList<String> yearItems =
  //     <String>['2024', '2025', '2026', '2027', '2028', '2029', '2030'].obs;

  RxList<String> yearItems = <String>[].obs;

  void generateYearItems({int numberOfYears = 10}) {
    int currentYear = DateTime.now().year;
    yearItems.value = List.generate(
      numberOfYears,
      (index) => (currentYear + index).toString(),
    );
  }

  Rx<LeaveStatusModel> leaveStatusListResponse = LeaveStatusModel().obs;

  Rx<TextEditingController> fromDateController = TextEditingController().obs;
  Rx<TextEditingController> toDateController = TextEditingController().obs;

  RxString formattedFromDate = ''.obs;
  RxString formattedToDate = ''.obs;
  RxString fromAPIDt = ''.obs;
  RxString toAPIDt = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fromDateController.value.text = AppDatePicker.currentDate();
    formattedFromDate.value = fromDateController.value.text;
    fromAPIDt.value = AppDatePicker.convertDateTimeFormat(
        formattedFromDate.value, 'dd/MM/yyyy', 'yyyy-MM-dd');

    toDateController.value.text = AppDatePicker.currentDate();
    formattedToDate.value = toDateController.value.text;
    toAPIDt.value = AppDatePicker.convertDateTimeFormat(
        formattedToDate.value, 'dd/MM/yyyy', 'yyyy-MM-dd');

    generateYearItems(numberOfYears: 10);
    onLeaveBalanceAPI(fromAPIDt.value, toAPIDt.value);
  }

  Future<void> onLeaveBalanceAPI(String fromDt, String toDt) async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        // Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        // String empID = loginData['emp_ID'].toString();
        // String cmpID = loginData['cmp_ID'].toString();
        //
        // Map<String, dynamic> requestParam = {
        //   "month": month,
        //   "year": year,
        //   "empId": empID,
        //   "cmpId": cmpID
        // };

        Map<String, dynamic> requestParam = {
          "fromDate": fromDt,
          "toDate": toDt
        };

        var response =
            await DioClient().post(AppURL.getLeaveStatusURL, requestParam);
        leaveStatusListResponse.value = LeaveStatusModel.fromJson(response);
        if (leaveStatusListResponse.value.code == 200 &&
            leaveStatusListResponse.value.status == true) {
          debugPrint("leave status --$leaveStatusListResponse");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveStatusListResponse.value.message}");
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
