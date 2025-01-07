import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_annoucement_model.dart';

import '../../../api/dio_client.dart';
import '../../../app/app_snack_bar.dart';
import '../../../app/app_url.dart';
import '../../../utility/constants.dart';
import '../../../utility/network.dart';
import '../../../utility/preference_utils.dart';

class NotificationAnnouncementController extends GetxController {
  var notificationList = <Map<String, dynamic>>[].obs;

  // var isLoading = false.obs;
  // var currentPage = 1.obs;
  // var totalPages = 1.obs;
  // late int statusCode;

  Rx<NotificationAnnouncementModel> leaveBalListResponse =
      NotificationAnnouncementModel().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getNotification();
  }

  Future<void> getNotification() async {
    try {
      isLoading.value = true;

      Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
      String empID = loginData['emp_ID'].toString();
      String cmpID = loginData['cmp_ID'].toString();
      String depID = loginData['depT_Id'].toString();

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'empID': empID,
          'cmpID': cmpID,
          'deptID': depID,
          'galleryType': '1',
          'strType': 'D',
        };

        var response = await DioClient().post(AppURL.getNotificationURL, param);
        leaveBalListResponse.value =
            NotificationAnnouncementModel.fromJson(response);
        if (leaveBalListResponse.value.code == 200 &&
            leaveBalListResponse.value.status == true) {
          debugPrint("Notification Data --$leaveBalListResponse");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveBalListResponse.value.message}");
        }

        // if (response['code'] == 200 && response['status'] == true) {
        //   List<dynamic> data = response['data'];
        //   notificationList.value = data
        //       .map((item) => item as Map<String, dynamic>)
        //       .toList();
        //   statusCode = response['code'];
        //   print(statusCode);
        // } else {
        //   statusCode = response['code'];
        //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        // }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
