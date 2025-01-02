import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

import '../../api/dio_client.dart';
import '../../api/model/AttendanceRegularizeDetails.dart';
import '../../api/model/team_attendance_response.dart';
import '../../utility/network.dart';
import '../../widget/common_button.dart';
import '../../widget/common_year_month_grid_view.dart';

class AttendanceMainController extends GetxController{

  RxBool isLoading = true.obs;
  RxString userAddress = "".obs;
  RxString userCheckInTime = "10:00 AM".obs;
  RxString userCheckoutTime = "6:00 PM".obs;

  RxString empID = "".obs;
  RxString cmpID = "".obs;

  RxString userName = "".obs;
  RxString userDesignation = "".obs;

  RxString userProfileUrl = "".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;

  Rx<TeamAttendanceResponse> teamAttendanceResponse = TeamAttendanceResponse().obs;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails = AttendanceRegularizeDetails().obs;

  final RxInt selectedYearIndex = RxInt(-1); // Default to -1 (no selection yet)
  final RxInt selectedMonthIndex = RxInt(-1);

  @override
  void onInit() {
    getLocalData();
    getMyTeamRecords();
    getUserAttendanceRecords(DateTime.now().year,DateTime.now().month);
    super.onInit();
  }

  void getMyTeamRecords() async{
    var receivePort = ReceivePort();

    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if(message!=null){
        teamAttendanceResponse.value = TeamAttendanceResponse.fromJson(message);
        setUserOwnData();
      }else{
        isLoading.value = false;
      }
    },);

    await Isolate.spawn<_IsolateGetApiData>(
        _getAttendanceRecordsByApi, _IsolateGetApiData(
          token: rootToken,
          answerPort: receivePort.sendPort,
          apiUrl: AppURL.myTeamAttendanceURL));
  }

  static void _getAttendanceRecordsByApi(_IsolateGetApiData api) async{
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);

    await PreferenceUtils.init();
    if(await Network.isConnected()){
      await DioClient().get(api.apiUrl).then((value) {
        if(value!=null){
          api.answerPort.send(value);
        }else{
          api.answerPort.send(null);
        }
      },);
    }
  }

  Future<void> setUserOwnData() async{
    try {
      int length = teamAttendanceResponse.value.data?.length ?? 0;

      for (int i = 0; i < length; i++) {
        if ("${teamAttendanceResponse.value.data?.elementAt(i).empId}" == empID.value) {
          userName.value = teamAttendanceResponse.value.data!.elementAt(i).empFullName.toString();
          userDesignation.value = teamAttendanceResponse.value.data!.elementAt(i).desigName.toString();
          userAddress.value = teamAttendanceResponse.value.data!.elementAt(i).branchAddress.toString();
          userCheckInTime.value = teamAttendanceResponse.value.data!.elementAt(i).shInTime.toString();
          userCheckoutTime.value = teamAttendanceResponse.value.data!.elementAt(i).shOutTime.toString();
          userProfileUrl.value = teamAttendanceResponse.value.data!.elementAt(i).imagePath.toString();
          userEmpId.value = teamAttendanceResponse.value.data!.elementAt(i).empId!;
          userCmpId.value = teamAttendanceResponse.value.data!.elementAt(i).cmpID!;
          teamAttendanceResponse.value.data?.removeAt(i);
        }
      }
      isLoading.value = false;
      /*checkTeam();*/
    }catch(e){
      e.printError();
    }
  }

  void getUserAttendanceRecords(int year, int month) async{
    isLoading.value = true;

    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if(message!=null){
        attendanceRegularizeDetails.value = AttendanceRegularizeDetails.fromJson(message);
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    },);

    Map<String, dynamic> requestParam = {
      "month": month,
      "year": year,
      "empId": empID.value,
      "cmpId": cmpID.value
    };

    await Isolate.spawn<_IsolateApiData>(
        _getUserAttendanceByApi, _IsolateApiData(
        token: rootToken,
        requestData: requestParam,
        answerPort: receivePort.sendPort,
        apiUrl: AppURL.attendanceRegularizeDetailsURL));
  }

  static void _getUserAttendanceByApi(_IsolateApiData api) async{
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);

    await PreferenceUtils.init();
    if(await Network.isConnected()){
      await DioClient().post(api.apiUrl, api.requestData).then((value) {
        if (value != null) {
          api.answerPort.send(value);
        }else{
          api.answerPort.send(null);
        }
      },);
    }
  }

  getLocalData() {
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    empID.value = loginData['emp_ID'].toString();
    cmpID.value = loginData['cmp_ID'].toString();
  }

  String getWeekDay(String? date) {
    if(date!=null && date!="") {
      DateFormat inputFormat = DateFormat('MM/dd/yyyy HH:mm:ss');
      DateTime parsedDate = inputFormat.parse(date);
      String daysStr = DateFormat('EEEE').format(parsedDate);
      return daysStr;// Output: 2023-10-01
    }else{
      return "";
    }
  }

  String setDate(String? date) {
    if(date!=null && date!=""){
      DateFormat inputFormat = DateFormat('MM/dd/yyyy HH:mm:ss');
      // Parse the input string to DateTime
      DateTime parsedDate = inputFormat.parse(date);
      // Format the DateTime to the desired output format (MM/dd/yyyy)
      String formattedDate = DateFormat('MM/dd/yyyy').format(parsedDate);
      return formattedDate;
    }else{
      return "";
    }
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
                    getUserAttendanceRecords( selectedYear,
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
                        getUserAttendanceRecords(selectedYear,
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

class _IsolateGetApiData {
  final RootIsolateToken token;
  final SendPort answerPort;
  final String apiUrl;

  _IsolateGetApiData({required this.token, required this.answerPort, required this.apiUrl});
}

class _IsolateApiData {
  final RootIsolateToken token;
  final Map<String, dynamic> requestData;
  final SendPort answerPort;
  final String apiUrl;

  _IsolateApiData({required this.token, required this.requestData, required this.answerPort, required this.apiUrl});
}