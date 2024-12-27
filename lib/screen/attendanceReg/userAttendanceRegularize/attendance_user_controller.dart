import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import '../../../api/dio_client.dart';
import '../../../api/model/AttendanceRegularizeDetails.dart';

class UserAttendanceController extends GetxController{

  RxBool isLoading = false.obs;

  Rx<String> currentMonth = "May 2024".obs;
  RxString userName = "Tester".obs;
  RxString userProfile = "".obs;
  RxString userDesignation = "Ui/Ux Designer".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;
  RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedMonth = DateTime.now().month.obs;

  RxList<String> items = <String>[
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ].obs;

  dynamic argumentData = Get.arguments;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails = AttendanceRegularizeDetails().obs;


  @override
  void onInit() {
    currentMonth.value = "${items.elementAt(DateTime.now().month-1)} ${DateTime.now().year}";

    userProfile.value = argumentData[0]['userPhoto'];
    userName.value = argumentData[0]['userName'];
    userDesignation.value = argumentData[0]['userDesignation'];
    userEmpId.value = argumentData[0]['userEmpId'];
    userCmpId.value = argumentData[0]['userCmpId'];

    callUserAttendanceRegularizationDetails();

    super.onInit();
  }

  Future<void> callUserAttendanceRegularizationDetails() async {
    try {
      isLoading.value = true;

      Map<String, dynamic> requestParam = {"month": selectedMonth.value, "year": selectedYear.value, "empId": userEmpId.value, "cmpId": userCmpId.value};

      await DioClient().post(AppURL.attendanceRegularizeDetailsURL, requestParam).then((value) {
        if (value != null) {
          String response = "$value";
          log(response);

          Map<String, dynamic> jsonResponse = value;
          log(jsonResponse['message']);
          if (jsonResponse['code'] == 200) {
            if (jsonResponse['data'] != null) {
              attendanceRegularizeDetails.value = AttendanceRegularizeDetails.fromJson(value);
              isLoading.value = false;
            }
          } else {
            isLoading.value = false;
            log("not Success");
          }
        }else{
          isLoading.value = false;
          log("not Success");
        }
      },);
    } catch (e) {
      isLoading.value = false;
      e.printError();
    }
  }

  String getWeekDay(String date) {
    DateFormat inputFormat = DateFormat('MM/dd/yyyy HH:mm:ss');
    DateTime parsedDate = inputFormat.parse(date);
    String daysStr = DateFormat('EEEE').format(parsedDate);
    return daysStr; // Output: 2023-10-01
  }

  String setDate(String date) {
    DateFormat inputFormat = DateFormat('MM/dd/yyyy HH:mm:ss');
    // Parse the input string to DateTime
    DateTime parsedDate = inputFormat.parse(date);
    // Format the DateTime to the desired output format (MM/dd/yyyy)
    String formattedDate = DateFormat('MM/dd/yyyy').format(parsedDate);
    return formattedDate;
  }
}