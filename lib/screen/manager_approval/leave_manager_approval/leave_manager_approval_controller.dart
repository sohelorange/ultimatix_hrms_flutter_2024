import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/leave_manager_approval/leave_manager_approval_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

class LeaveManagerApprovalController extends GetxController {
  RxString userImageUrl = "".obs;
  RxBool isLoading = true.obs;

  Rx<LeaveManagerApprovalModel> leaveManagerApprovalResponse =
      LeaveManagerApprovalModel().obs;

  @override
  void onInit() {
    super.onInit();
    managerApprovalLeaveAPI();
  }

  Future<void> managerApprovalLeaveAPI() async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> requestParam = {
          "empId": empID,
          "cmpId": cmpID,
          "strType": "Application",
          "strStatus": ""
        };

        var response = await DioClient()
            .post(AppURL.managerApprovalLeaveURL, requestParam);

        leaveManagerApprovalResponse.value =
            LeaveManagerApprovalModel.fromJson(response);
        if (leaveManagerApprovalResponse.value.code == 200 &&
            leaveManagerApprovalResponse.value.status == true) {
          debugPrint(
              "leave manger approval balance --${leaveManagerApprovalResponse.value.data}");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveManagerApprovalResponse.value.message}");
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
