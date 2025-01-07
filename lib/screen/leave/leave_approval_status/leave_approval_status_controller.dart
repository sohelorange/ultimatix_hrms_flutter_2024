import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_approval_status/leave_approval_status_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

class LeaveApprovalStatusController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt leaveId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final leaveId = Get.arguments['LeaveAppId'] ?? '';
    getManagerApprovalDetailsAPI(leaveId);
  }

  Rx<LeaveApprovalStatusModel> leaveApprovalResponse =
      LeaveApprovalStatusModel().obs;

  Future<void> getManagerApprovalDetailsAPI(int leaveId) async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> requestParam = {
          "travelApplicationId": 0,
          "cmpId": cmpID,
          "empId": empID,
          "claimAppId": 0,
          "leaveApplicationId": leaveId,
          "flag": "L"
        };

        var response = await DioClient()
            .post(AppURL.managerApprovalDetailsURL, requestParam);

        leaveApprovalResponse.value =
            LeaveApprovalStatusModel.fromJson(response);
        if (leaveApprovalResponse.value.code == 200 &&
            leaveApprovalResponse.value.status == true) {
          debugPrint("leave balance --$leaveApprovalResponse");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveApprovalResponse.value.message}");
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
