import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import '../../../api/dio_client.dart';
import '../../../api/model/attendance_regularize_details.dart';

class UserAttendanceController extends GetxController {
  RxBool isLoading = false.obs;

  RxString userName = "Tester".obs;
  RxString userProfile = "".obs;
  RxString userDesignation = "Ui/Ux Designer".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;

  dynamic argumentData = Get.arguments;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails =
      AttendanceRegularizeDetails().obs;

  final RxInt selectedMonthIndex = RxInt(-1);

  @override
  void onInit() {
    getListOfYears();
    userProfile.value = argumentData[0]['userPhoto'];
    userName.value = argumentData[0]['userName'];
    userDesignation.value = argumentData[0]['userDesignation'];
    userEmpId.value = argumentData[0]['userEmpId'];
    userCmpId.value = argumentData[0]['userCmpId'];

    callUserAttendanceRegularizationDetails(DateTime.now().year, DateTime.now().month);

    checkCurrentMonth();
    checkCurrentYear();
    super.onInit();
  }

  RxList<String> listOfYears = [""].obs;

  final List<String> listOfMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  final RxString selectedMonths = "".obs;
  final RxString selectedYears = "".obs;

  Future<void> callUserAttendanceRegularizationDetails(
      int year, int month) async {
    try {
      isLoading.value = true;

      Map<String, dynamic> requestParam = {
        "month": month,
        "year": year,
        "empId": userEmpId.value,
        "cmpId": userCmpId.value
      };

      await DioClient()
          .post(AppURL.attendanceRegularizeDetailsURL, requestParam)
          .then(
        (value) {
          if (value != null) {
            String response = "$value";
            log(response);

            Map<String, dynamic> jsonResponse = value;
            log(jsonResponse['message']);
            if (jsonResponse['code'] == 200) {
              if (jsonResponse['data'] != null) {
                attendanceRegularizeDetails.value =
                    AttendanceRegularizeDetails.fromJson(value);
                isLoading.value = false;
              }
            } else {
              isLoading.value = false;
              log("not Success");
            }
          } else {
            isLoading.value = false;
            log("not Success");
          }
        },
      );
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

  getListOfYears() {
    final int currentYear = DateTime.now().year;

    final List<String> yearItems = List.generate(
      13, // Total of 13 years (10 previous + current year + 2 future)
          (index) => (currentYear - 12 + index).toString()
    );

    listOfYears.clear();

    for (var element in yearItems) {
      listOfYears.add(element.toString());
    }
  }

  /*to set the current month*/
  Future<void> checkCurrentMonth() async{
    String cMonth = DateFormat.MMMM().format(DateTime.now());
    for(int i=0;i<listOfMonths.length;i++){
      if(listOfMonths[i]==cMonth){
        selectedMonthIndex.value = i+1;
        selectedMonths.value = listOfMonths.elementAt(i);
      }
    }
  }

  /*to set the current year*/
  Future<void> checkCurrentYear() async{
    String cYear = DateTime.now().year.toString();
    for(int i=0;i<listOfYears.length;i++){
      if(listOfYears.elementAt(i)==cYear){
        selectedYears.value = listOfYears.elementAt(i);
      }
    }
  }
}
