import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import '../../../api/dio_client.dart';
import '../../../api/model/AttendanceRegularizeDetails.dart';
import '../../../widget/common_button.dart';
import '../../../widget/common_year_month_grid_view.dart';

class UserAttendanceController extends GetxController{

  RxBool isLoading = false.obs;

  RxString userName = "Tester".obs;
  RxString userProfile = "".obs;
  RxString userDesignation = "Ui/Ux Designer".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;

  dynamic argumentData = Get.arguments;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails = AttendanceRegularizeDetails().obs;

  final RxInt selectedYearIndex = RxInt(-1); // Default to -1 (no selection yet)
  final RxInt selectedMonthIndex = RxInt(-1);

  @override
  void onInit() {

    userProfile.value = argumentData[0]['userPhoto'];
    userName.value = argumentData[0]['userName'];
    userDesignation.value = argumentData[0]['userDesignation'];
    userEmpId.value = argumentData[0]['userEmpId'];
    userCmpId.value = argumentData[0]['userCmpId'];

    callUserAttendanceRegularizationDetails(DateTime.now().year,DateTime.now().month);

    super.onInit();
  }

  Future<void> callUserAttendanceRegularizationDetails(int year, int month) async {
    try {
      isLoading.value = true;

      Map<String, dynamic> requestParam = {"month": month, "year": year, "empId": userEmpId.value, "cmpId": userCmpId.value};

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

  void showYearDialog(BuildContext context) {
    final int currentYear = DateTime.now().year;

    // Generate a list of years dynamically
    final List<Map<String, dynamic>> yearItems = List.generate(
      20,
          (index) => {'name': (currentYear + index).toString()},
    );

    // Set default to current year if no selection has been made yet
    if (selectedYearIndex.value == -1) {
      selectedYearIndex.value = 0; // Default to the current year
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.3, // 30% of screen height
            width: MediaQuery.of(context).size.width * 0.8,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CommonYearMonthGridView(
                  gridItems: yearItems,
                  selectedIndex: selectedYearIndex,
                  onItemTap: (index) {
                    selectedYearIndex.value = index;

                    Get.back(); // Close the year dialog
                    final selectedYear = currentYear + selectedYearIndex.value;
                    showMonthDialog(context, selectedYear);
                  },
                );
              },
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    buttonText: 'Next',
                    onPressed: () {
                      if (selectedYearIndex.value >= 0) {
                        Get.back();
                        final selectedYear =
                            currentYear + selectedYearIndex.value;
                        showMonthDialog(context, selectedYear);
                      }
                    },
                    isLoading: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonButton(
                    buttonText: 'Close',
                    onPressed: () {
                      Get.back();
                    },
                    isLoading: false,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void showMonthDialog(BuildContext context, int selectedYear) {
    // Define months
    final List<Map<String, dynamic>> monthItems = [
      {'name': 'January'},
      {'name': 'February'},
      {'name': 'March'},
      {'name': 'April'},
      {'name': 'May'},
      {'name': 'June'},
      {'name': 'July'},
      {'name': 'August'},
      {'name': 'September'},
      {'name': 'October'},
      {'name': 'November'},
      {'name': 'December'},
    ];

    // Set default to current month if no selection has been made yet
    if (selectedMonthIndex.value == -1) {
      selectedMonthIndex.value =
          DateTime.now().month - 1; // Default to current month
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Month for $selectedYear'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.3, // 30% of screen height
            width: MediaQuery.of(context).size.width * 0.8,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CommonYearMonthGridView(
                  gridItems: monthItems,
                  selectedIndex: selectedMonthIndex,
                  onItemTap: (index) {
                    selectedMonthIndex.value = index;

                    Get.back(); // Close the month dialog
                    callUserAttendanceRegularizationDetails( selectedYear,
                      selectedMonthIndex.value +
                          1,);
                  },
                );
              },
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    buttonText: 'Submit',
                    onPressed: () {
                      if (selectedMonthIndex.value >= 0) {
                        Get.back(); // Close the month dialog
                        callUserAttendanceRegularizationDetails(selectedYear,
                          selectedMonthIndex.value +
                              1,);
                      }
                    },
                    isLoading: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonButton(
                    buttonText: 'Close',
                    onPressed: () {
                      Get.back();
                    },
                    isLoading: false,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}