import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_comment_dialog.dart';

import '../../leave_manager_approval/leave_manager_approval_controller.dart';
import '../../leave_manager_approval/leave_manager_approval_model.dart';

class LeaveManagerApprovalEditDetailsController extends GetxController {
  RxString leaveRowId = ''.obs;
  RxString leaveApplicationID = ''.obs;
  RxString leaveId = ''.obs;
  RxString leaveEmpCode = ''.obs;
  RxString leaveEmpName = ''.obs;
  RxString leaveStatus = ''.obs;
  RxString leaveAppStatus = ''.obs;
  RxString leaveName = ''.obs;
  RxString leaveType = ''.obs;
  RxString leaveFromDt = ''.obs;
  RxString leaveToDt = ''.obs;
  RxString leavePeriod = ''.obs;
  RxString leaveReason = ''.obs;
  RxString userImageUrl = "".obs;
  RxString leaveRPTLevel = "".obs;
  RxString leaveFinalApproval = "".obs;
  RxString leaveFrdRej = "".obs;
  RxString leaveEmpID = "".obs;

  var isDialogLoading = false.obs;
  var isDisable = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final leaveData = Get.arguments['leaveEditApprovalData'] as Data;
    // Safely assign values with null checks
    leaveRowId.value = leaveData.rowID?.toString() ?? '';
    leaveApplicationID.value = leaveData.leaveApplicationID?.toString() ?? '';
    leaveId.value = leaveData.leaveID?.toString() ?? '';

    leaveEmpCode.value = leaveData.empCode ?? '';
    leaveEmpName.value = leaveData.empFullName ?? '';
    leaveName.value = leaveData.leaveName ?? '';
    leaveType.value = leaveData.leaveType ?? '';
    leaveFromDt.value = leaveData.fromDate ?? '';
    leaveToDt.value = leaveData.toDate ?? '';
    leavePeriod.value = leaveData.leavePeriod?.toString() ?? '0';
    leaveReason.value = leaveData.leaveReason ?? '';
    leaveStatus.value = leaveData.applicationStatus ?? '';
    leaveAppStatus.value = leaveData.leaveApplicationStatus ?? '';
    userImageUrl.value = leaveData.imagePath ?? '';
    leaveRPTLevel.value = leaveData.rptLevel?.toString() ?? '0';
    leaveFrdRej.value = leaveData.isFwdLeaveRej?.toString() ?? '0';
    leaveFinalApproval.value = leaveData.finalApprover?.toString() ?? '0';
    leaveEmpID.value = leaveData.empID?.toString() ?? '0';
  }

  void showApprovalDialog() {
    final TextEditingController commentController = TextEditingController();
    final FocusNode commentFocusNode = FocusNode();

    Get.dialog(CommonCommentDialog(
      title: 'Approval Request',
      hintText: 'Comment',
      textController: commentController,
      focusNode: commentFocusNode,
      isLoading: isDialogLoading,
      onConfirm: () async {
        final comment = commentController.text.trim();
        if (comment.isNotEmpty) {
          insertManagerApprovalLeave(comment, 'A');
          //Get.back();
          //Get.offAndToNamed(AppRoutes.leaveManagerApprovalRoute);
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'Please enter a comment');
        }
      },
      onCancel: () {
        Get.back();
      },
    ));
  }

  void showCancelDialog() {
    final TextEditingController commentController = TextEditingController();
    final FocusNode commentFocusNode = FocusNode();

    Get.dialog(CommonCommentDialog(
      title: 'Reject Request',
      hintText: 'Comment',
      textController: commentController,
      // Pass the controller to the dialog
      focusNode: commentFocusNode,
      // Pass the focus node to the dialog
      isLoading: isDialogLoading,
      onConfirm: () async {
        final comment =
            commentController.text.trim(); // Get the entered comment
        if (comment.isNotEmpty) {
          insertManagerApprovalLeave(comment, 'R');
          //Get.back();
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'Please enter a comment');
        }
      },
      onCancel: () {
        Get.back(); // Close the dialog on cancel
      },
    ));
  }

  Future<void> insertManagerApprovalLeave(String reason, String status) async {
    try {
      isDialogLoading.value = true; // Show loader

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> param = {
          "empID": leaveEmpID.value,
          "cmpID": cmpID,
          "leaveID": leaveId.value,
          "leaveAppID": leaveApplicationID.value,
          "fromDate": leaveFromDt.value,
          "period": leavePeriod.value,
          "toDate": leaveToDt.value,
          "assignAs": leaveType.value,
          "comment": reason,
          "hLeaveDate": leaveFromDt.value,
          "appStatus": status,
          "appComment": "",
          "finalApproval": leaveFinalApproval.value,
          "isFWDRej": leaveFrdRej.value,
          "rptLevel": leaveRPTLevel.value,
          "sEmpID": empID,
          "intime": AppDatePicker.currentUTCFormatDate(),
          "outTime": AppDatePicker.currentUTCFormatDate(),
          "loginID": loginID,
          "attachment": "",
          "compoffLeaveDates": ""
        };

        var response =
            await DioClient().post(AppURL.managerApprovalInsertURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          Utils.closeKeyboard(Get.context!);
          // if (data[0].containsKey('From_date')) {
          // } else
          if (data.containsKey('Result')) {
            final result = data['Result']?.toString() ?? '';
            if (result.contains('False')) {
              AppSnackBar.showGetXCustomSnackBar(message: result.split('#')[0]);
            } else {
              Get.back(); // Close the dialog
              // final LeaveManagerApprovalController controller =
              //     Get.put(LeaveManagerApprovalController());
              // controller.managerApprovalLeaveAPI().then((val){
              //   Get.until((route) =>
              //   route.settings.name ==
              //       AppRoutes
              //           .leaveManagerApprovalRoute); // Navigate back to the target route
              // });

              Get.until((route) =>
                  route.settings.name == AppRoutes.leaveManagerApprovalRoute);
              final LeaveManagerApprovalController controller =
                  Get.find<LeaveManagerApprovalController>();
              controller.managerApprovalLeaveAPI();

              AppSnackBar.showGetXCustomSnackBar(
                  message: result.split('#')[0], backgroundColor: Colors.green);
            }
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isDialogLoading.value = false; // Hide loader
    }
  }
}
