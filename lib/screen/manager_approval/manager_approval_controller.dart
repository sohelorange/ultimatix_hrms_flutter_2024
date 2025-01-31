import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/manager_approval_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';

class ManagerApprovalController extends GetxController {
  Rx<ManagerApprovalModel> leaveManagerApprovalResponse =
      ManagerApprovalModel().obs;

  //List<Map<String, dynamic>> exploreItems = [];
  RxList<Map<String, dynamic>> exploreItems = <Map<String, dynamic>>[].obs;

  RxString leaveApprovalCount = "0".obs;
  RxString attendanceCount = "0".obs;
  RxString leaveCancelCount = "0".obs;
  RxString compOffCount = "0".obs;
  RxString ticketCount = "0".obs;
  RxString claimCount = "0".obs;
  RxString travelCount = "0".obs;
  RxString exitCount = "0".obs;

  RxBool isLoading = true.obs;

  RxString errorMsg = ''.obs;

  void handleNavigation(int index) {
    final selectedItem = exploreItems[index];
    switch (selectedItem['id']) {
      case 1: // Leave
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Leave Approval Request...');
        } else {
          Get.toNamed(AppRoutes.leaveManagerApprovalRoute);
        }
        break;
      case 2: // Attendance
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Attendance Regularization Approval Request...');
        } else {}
        break;
      case 3: // Leave Cancel
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Leave Cancel Approval Request...');
        } else {}
        break;
      case 4: // Comp off
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Comp Off Approval Request...');
        } else {}
        break;
      case 5: // Ticket
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Ticket Approval Request...');
        } else {}
        break;
      case 6: // Claim
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Claim Approval Request...');
        } else {}
        break;
      case 7: // Travel
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Travel Approval Request...');
        } else {}
        break;
      case 8: // Exit
        if (selectedItem['count'] == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Exit Approval Request...');
        } else {}
        break;
      default:
        AppSnackBar.showGetXCustomSnackBar(
            message: 'This feature is under development.');
    }
  }

  @override
  void onInit() {
    super.onInit();
    managerApprovalCountAPI();
  }

  Future<void> managerApprovalCountAPI() async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        var response =
            await DioClient().getQueryParam(AppURL.managerApprovalCount);

        leaveManagerApprovalResponse.value =
            ManagerApprovalModel.fromJson(response);
        if (leaveManagerApprovalResponse.value.code == 200 &&
            leaveManagerApprovalResponse.value.status == true) {
          leaveApprovalCount.value =
              leaveManagerApprovalResponse.value.data!.leaveAppCnt.toString();
          attendanceCount.value =
              leaveManagerApprovalResponse.value.data!.lateComer.toString();
          leaveCancelCount.value =
              leaveManagerApprovalResponse.value.data!.leaveCancel.toString();
          compOffCount.value = leaveManagerApprovalResponse
              .value.data!.compOffApprovals
              .toString();
          ticketCount.value = leaveManagerApprovalResponse
              .value.data!.ticketApprovals
              .toString();
          claimCount.value =
              leaveManagerApprovalResponse.value.data!.claimAppCnt.toString();
          travelCount.value =
              leaveManagerApprovalResponse.value.data!.travelAppCnt.toString();
          exitCount.value =
              leaveManagerApprovalResponse.value.data!.exitApproval.toString();

          exploreItems.value = [
            {
              'id': 1,
              'icon': AppImages.approvalLeaveIcon,
              'name': 'Leaves Approvals',
              'count': leaveApprovalCount.value
            },
            {
              'id': 2,
              'icon': AppImages.approvalAttendanceIcon,
              'name': 'Attendance Regularization\nApprovals',
              'count': attendanceCount.value
            },
            {
              'id': 3,
              'icon': AppImages.approvalLeaveCancelIcon,
              'name': 'Leave Cancel Approvals',
              'count': leaveCancelCount.value
            },
            {
              'id': 4,
              'icon': AppImages.approvalCompOffIcon,
              'name': 'Comp Off Approvals',
              'count': compOffCount.value
            },
            {
              'id': 5,
              'icon': AppImages.approvalTicketIcon,
              'name': 'Ticket Approvals',
              'count': ticketCount.value
            },
            {
              'id': 6,
              'icon': AppImages.approvalClaimIcon,
              'name': 'Claim Approvals',
              'count': claimCount.value
            },
            {
              'id': 7,
              'icon': AppImages.approvalTravelIcon,
              'name': 'Travel Approvals',
              'count': travelCount.value
            },
            {
              'id': 8,
              'icon': AppImages.approvalExitIcon,
              'name': 'Exit Approvals',
              'count': exitCount.value
            },
          ];
          debugPrint(
              "leave manger approval balance --${leaveManagerApprovalResponse.value.data}");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveManagerApprovalResponse.value.message}");
        }
      } catch (e) {
        if (e.toString().contains('FetchDataException')) {
          errorMsg.value = 'Internal server error';
        } else if (e.toString().contains('BadRequestException')) {
          errorMsg.value = 'Bad request';
        } else if (e.toString().contains('ApiNotRespondingException')) {
          errorMsg.value = 'Api not working';
        } else if (e.toString().contains('UnAuthorizedException')) {
          errorMsg.value = 'Un authorized';
        } else if (e.toString().contains('SocketException')) {
          errorMsg.value = Constants.somethingWrongMsg;
        } else if (e.toString().contains('TimeOutException')) {
          errorMsg.value = Constants.timeOutMsg;
        } else {
          errorMsg.value = Constants.somethingWrongMsg;
        }
        //AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }
}
