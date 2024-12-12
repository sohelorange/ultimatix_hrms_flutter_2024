import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../../api/dio_client.dart';
import '../../app/app_images.dart';
import '../../app/app_snack_bar.dart';
import '../../utility/constants.dart';
import '../../utility/network.dart';

class DashboardController extends GetxController {
  RxString address = ''.obs;
  RxString checkInTime = "--:--".obs;
  RxString checkOutTime = "--:--".obs;
  RxString workingHours = "00:00".obs;
  RxString todayDayDate = "".obs;
  RxString currentMonthYear = "".obs;

  RxString presentDayLbl = "Present".obs;
  RxString presentDayValue = "0".obs;
  RxString leaveDayLbl = "Leave".obs;
  RxString leaveDayValue = "0".obs;
  RxString absentDayLbl = "Absent".obs;
  RxString absentDayValue = "0".obs;
  RxString onDutyDayLbl = "On Duty".obs;
  RxString onDutyDayValue = "0".obs;
  RxString holidayDayLbl = "Holiday".obs;
  RxString holidayDayValue = "0".obs;
  RxString weekOffDayLbl = "Week Off".obs;
  RxString weekOffDayValue = "0".obs;

  RxList<Map<String, dynamic>> statusData = <Map<String, dynamic>>[].obs;

  final List<String> listEvent = [
    "https://www.shutterstock.com/image-vector/happy-diwali-celebration-background-festival-600nw-2523970115.jpg",
    "https://t3.ftcdn.net/jpg/08/95/86/82/360_F_895868299_z8aR16uHjnkrtnUkzohVQ68m26JBNt4f.jpg",
    "https://media.istockphoto.com/id/1774494924/photo/sister-applying-tilaka-to-her-brother-at-home-during-bhai-dooj.jpg?s=612x612&w=0&k=20&c=z2nNx7asAdglLCBIhJwy3JV2qwDVMT5AAyfxrJ5r_XU=",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDataInParallel();

    // Get the current date
    DateTime now = DateTime.now();
    currentMonthYear.value = DateFormat('MMMM yyyy').format(now);
    todayDayDate.value = getTodayFormattedDate();
  }

  String getTodayFormattedDate() {
    DateTime now = DateTime.now();
    //String formattedDate = DateFormat("E, MMM d, yyyy").format(now);//Short Name Day
    String formattedDate =
        DateFormat("EEEE, MMM d, yyyy").format(now); // Full Name Day
    return formattedDate;
  }

  Future<void> fetchDataInParallel() async {
    try {
      await Future.wait([
        fetchDashboardPresentDetailsAPICall(),
        fetchDashboardAttendanceHistoryAPICall(),
      ]);
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> fetchDashboardPresentDetailsAPICall() async {
    if (await Network.isConnected()) {
      try {
        //Map<String, dynamic> param = {
        //  'Key': 'value',
        //};

        var response =
            await DioClient().getQueryParam(AppURL.clockInOutTimeURL);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          if (data != null && data is Map<String, dynamic>) {
            workingHours.value = data['Duration'] ?? '00:00';
            checkInTime.value = AppDatePicker.convertDateTimeFormat(
                data['First_In_Time'].toString(),
                Utils.commonUTCDateFormat,
                'hh:mm a');
            checkOutTime.value = AppDatePicker.convertDateTimeFormat(
                data['Last_Out_Time'].toString(),
                Utils.commonUTCDateFormat,
                'hh:mm a');
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        //AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> fetchDashboardAttendanceHistoryAPICall() async {
    if (await Network.isConnected()) {
      try {
        //Map<String, dynamic> param = {
        //  'Key': 'value',
        //};

        var response = await DioClient().getQueryParam(AppURL.dashboardURL);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data']; // Keep this as Map<String, dynamic>
          if (data != null && data is Map<String, dynamic>) {
            address.value = data['employeeData']['location'].toString();
            presentDayValue.value =
                data['employeeCount']['present']?.toString() ?? '0';
            leaveDayValue.value =
                data['employeeCount']['leave']?.toString() ?? '0';
            absentDayValue.value =
                data['employeeCount']['absent']?.toString() ?? '0';
            onDutyDayValue.value =
                data['employeeCount']['od']?.toString() ?? '0';
            holidayDayValue.value =
                data['employeeCount']['ho']?.toString() ?? '0';
            weekOffDayValue.value =
                data['employeeCount']['wo']?.toString() ?? '0';

            if (presentDayValue.value.isNotEmpty &&
                leaveDayValue.value.isNotEmpty &&
                absentDayValue.value.isNotEmpty &&
                onDutyDayValue.value.isNotEmpty &&
                holidayDayValue.value.isNotEmpty &&
                weekOffDayValue.value.isNotEmpty) {
              statusData.value = [
                {
                  'color': const Color(0XFF34A853),
                  'icon': AppImages.dashPresentIcon,
                  'name': presentDayLbl.value.toString(),
                  'count': presentDayValue.value.toString(),
                },
                {
                  'color': const Color(0XFFEA4335),
                  'icon': AppImages.dashLeaveIcon,
                  'name': leaveDayLbl.value.toString(),
                  'count': leaveDayValue.value.toString(),
                },
                {
                  'color': const Color(0XFFF68C1F),
                  'icon': AppImages.dashAbsentIcon,
                  'name': absentDayLbl.value.toString(),
                  'count': absentDayValue.value.toString(),
                },
                {
                  'color': const Color(0XFF4285F4),
                  'icon': AppImages.dashOnDutyIcon,
                  'name': onDutyDayLbl.value.toString(),
                  'count': onDutyDayValue.value.toString(),
                },
                {
                  'color': const Color(0XFFAF84DD),
                  'icon': AppImages.dashHolidayIcon,
                  'name': holidayDayLbl.value.toString(),
                  'count': holidayDayValue.value.toString(),
                },
                {
                  'color': const Color(0XFFAAAE01),
                  'icon': AppImages.dashWeekOffIcon,
                  'name': weekOffDayLbl.value.toString(),
                  'count': weekOffDayValue.value.toString(),
                },
              ];
            }

            print(statusData);
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        //AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }
}
