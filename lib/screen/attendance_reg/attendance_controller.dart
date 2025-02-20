import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../api/dio_client.dart';
import '../../api/model/attendance_regularize_details.dart';
import '../../api/model/team_attendance_response.dart';
import '../../utility/isolates_class.dart';
import '../../utility/network.dart';
import '../../widget/common_button.dart';
import '../../widget/common_year_month_grid_view.dart';
import '../../utility/preference_utils.dart';
import '../../app/app_url.dart';

class AttendanceMainController extends GetxController {
  RxBool isLoading = true.obs;
  RxString userAddress = "".obs;
  RxString userCheckInTime = "--:--".obs;
  RxString userCheckoutTime = "--:--".obs;
  RxString empID = "".obs;
  RxString cmpID = "".obs;
  RxString userName = "".obs;
  RxString userDesignation = "".obs;
  RxString userProfileUrl = "".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;

  Rx<TeamAttendanceResponse> teamAttendanceResponse =
      TeamAttendanceResponse().obs;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails =
      AttendanceRegularizeDetails().obs;

  final RxInt selectedYearIndex = RxInt(-1);
  final RxInt selectedMonthIndex = RxInt(-1);
  RxInt selectedYear = DateTime.now().year.obs;
  RxString cmpImageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    getLocalData();
    getMyTeamRecords();
    getUserAttendanceRecords(DateTime.now().year, DateTime.now().month);
  }

  Future<void> getMyTeamRecords() async {
    await _fetchDataFromApi(
      AppURL.myTeamAttendanceURL,
      (data) {
        teamAttendanceResponse.value = TeamAttendanceResponse.fromJson(data);
        setUserOwnData();
      },
    );
  }

  Future<void> _fetchDataFromApi(
      String apiUrl, Function(Map<String, dynamic>) onSuccess) async {
    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if (message != null) {
        onSuccess(message);
      } else {
        isLoading.value = false;
      }
    });

    await Isolate.spawn(
      _getAttendanceRecordsByApi,
      IsolateGetApiData(
          token: rootToken, answerPort: receivePort.sendPort, apiUrl: apiUrl),
    );
  }

  static void _getAttendanceRecordsByApi(IsolateGetApiData api) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);
    await PreferenceUtils.init();

    if (await Network.isConnected()) {
      var value = await DioClient().get(api.apiUrl);
      api.answerPort.send(value);
    }
  }

  Future<void> setUserOwnData() async {
    var userData = teamAttendanceResponse.value.data?.firstWhere(
      (item) => "${item.empId}" == empID.value,
    );

    if (userData != null) {
      userName.value = userData.empFullName!;
      userDesignation.value = userData.desigName!;
      userAddress.value = userData.branchAddress!;
      userCheckInTime.value =
          userData.status == '' ? "--:--" : userData.status!;
      userCheckoutTime.value =
          userData.status2 == '' ? "--:--" : userData.status2!;
      userProfileUrl.value = userData.imagePath!;
      userEmpId.value = userData.empId!;
      userCmpId.value = userData.cmpID!;
      teamAttendanceResponse.value.data?.remove(userData);
    }

    isLoading.value = false;
  }

  Future<void> getUserAttendanceRecords(int year, int month) async {
    isLoading.value = true;

    var requestParam = {
      "month": month,
      "year": year,
      "empId": empID.value,
      "cmpId": cmpID.value,
    };

    await _fetchDataFromApiWithParams(
      AppURL.attendanceRegularizeDetailsURL,
      requestParam,
      (data) {
        attendanceRegularizeDetails.value =
            AttendanceRegularizeDetails.fromJson(data);
        isLoading.value = false;
      },
    );
  }

  Future<void> _fetchDataFromApiWithParams(
    String apiUrl,
    Map<String, dynamic> params,
    Function(Map<String, dynamic>) onSuccess,
  ) async {
    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if (message != null) {
        onSuccess(message);
      } else {
        isLoading.value = false;
      }
    });

    await Isolate.spawn(
      _getUserAttendanceByApi,
      IsolatePostApiData(
          token: rootToken,
          requestData: params,
          answerPort: receivePort.sendPort,
          apiUrl: apiUrl),
    );
  }

  static void _getUserAttendanceByApi(IsolatePostApiData api) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);
    await PreferenceUtils.init();

    if (await Network.isConnected()) {
      var value = await DioClient().post(api.apiUrl, api.requestData);
      api.answerPort.send(value);
    }
  }

  void getLocalData() {
    var loginData = PreferenceUtils.getLoginDetails();
    empID.value = loginData['emp_ID'].toString();
    cmpID.value = loginData['cmp_ID'].toString();
    cmpImageUrl.value = loginData['cmp_Logo'] ?? '';
  }

  String getWeekDay(String? date) {
    if (date != null && date != "") {
      DateFormat inputFormat = DateFormat('MM/dd/yyyy HH:mm:ss');
      DateTime parsedDate = inputFormat.parse(date);
      String daysStr = DateFormat('EEEE').format(parsedDate);
      return daysStr; // Output: 2023-10-01
    } else {
      return "";
    }
  }

  String setDate(String? date) {
    if (date != null && date != "") {
      DateFormat inputFormat = DateFormat('MM/dd/yyyy HH:mm:ss');
      // Parse the input string to DateTime
      DateTime parsedDate = inputFormat.parse(date);
      // Format the DateTime to the desired output format (MM/dd/yyyy)
      String formattedDate = DateFormat('MM/dd/yyyy').format(parsedDate);
      return formattedDate;
    } else {
      return "";
    }
  }

  void showYearDialog(BuildContext context) {
    final int currentYear = DateTime.now().year;

    // Generate a list of years from (currentYear - 10) to (currentYear + 2)
    final List<Map<String, dynamic>> yearItems = List.generate(
      13, // Total of 13 years (10 previous + current year + 2 future)
      (index) => {'name': (currentYear - 10 + index).toString()},
    );

    // Set default to current year if no selection has been made yet
    if (selectedYearIndex.value == -1) {
      selectedYearIndex.value = 10; // Default to the current year
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
                    selectedYear.value =
                        currentYear - 10 + selectedYearIndex.value;
                    showMonthDialog(context, selectedYear.value);
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
                            currentYear - 10 + selectedYearIndex.value;
                        showMonthDialog(context, selectedYear);
                      }
                    },
                    isLoading: false,
                  ),
                ),
                const SizedBox(width: 10),
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
    _showDialog(
      context,
      'Select Month for $selectedYear',
      _generateMonthItems(),
      selectedMonthIndex,
      (index) {
        selectedMonthIndex.value = index;
        Get.back();
        getUserAttendanceRecords(selectedYear, index + 1);
      },
    );
  }

  void _showDialog(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> items,
    RxInt selectedIndex,
    Function(int) onItemTap,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            child: CommonYearMonthGridView(
              gridItems: items,
              selectedIndex: selectedIndex,
              onItemTap: onItemTap,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    buttonText: 'Submit',
                    onPressed: () {
                      if (selectedIndex.value >= 0) {
                        Get.back();
                        onItemTap(selectedIndex.value);
                      }
                    },
                    isLoading: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonButton(
                    buttonText: 'Close',
                    onPressed: Get.back,
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

  // ignore: unused_element
  List<Map<String, dynamic>> _generateYearItems() {
    var currentYear = DateTime.now().year - 15;
    return List.generate(
        50, (index) => {'name': (currentYear + index).toString()});
  }

  List<Map<String, dynamic>> _generateMonthItems() {
    return [
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
  }
}
