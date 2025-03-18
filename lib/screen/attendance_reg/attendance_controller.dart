import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../api/dio_client.dart';
import '../../api/model/attendance_regularize_details.dart';
import '../../api/model/team_attendance_response.dart';
import '../../utility/isolates_class.dart';
import '../../utility/network.dart';
import '../../utility/preference_utils.dart';
import '../../app/app_url.dart';

class AttendanceMainController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingOnItem = false.obs;
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

  Rx<TeamAttendanceResponse> subTeamAttendanceResponse =
      TeamAttendanceResponse().obs;

  RxString cmpImageUrl = "".obs;

  RxList<String> listOfYears = [""].obs;

  RxString currentMonth = "".obs;

  RxList<bool> expanded = [false].obs;

  @override
  void onInit() {
    super.onInit();
    nowDate.value = DateFormat('dd/MM/yyyy').format(DateTime.now());

    currentMonth.value = DateFormat.MMMM().format(DateTime.now());

    getListOfYears();
    _initializeData();
  }

  void _initializeData() {
    getLocalData();
    getMyTeamRecords(empID.value, cmpID.value,false);
    getUserAttendanceRecords(DateTime.now().year, DateTime.now().month);
    getAttendanceChartData();
  }

  Future<void> getMyTeamRecords(String empId, String cmpId, bool isSubEmpData) async {

    await _fetchDataFromApi(
      AppURL.myTeamAttendanceURL,
      (data) {
        if(isSubEmpData==true) {
          isLoadingOnItem.value = false;
          subTeamAttendanceResponse.value = TeamAttendanceResponse.fromJson(data);
          subTeamAttendanceResponse.value.data?.removeAt(0);
        } else {
          expanded.clear();
          teamAttendanceResponse.value = TeamAttendanceResponse.fromJson(data);
          expanded.value = List.generate(teamAttendanceResponse.value.data!.length-1, (index) => false,);
          setUserOwnData();
        }
      },
      empId,
      cmpId
    );
  }

  Future<void> _fetchDataFromApi(
      String apiUrl, Function(Map<String, dynamic>) onSuccess, String empId, String cmpId) async {
    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    var requestParam = {
      "cmpId": cmpId,
      "empId": empId
    };

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
          token: rootToken, answerPort: receivePort.sendPort, apiUrl: apiUrl, requestParam: requestParam),
    );
  }

  static void _getAttendanceRecordsByApi(IsolateGetApiData api) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);
    await PreferenceUtils.init();

    if (await Network.isConnected()) {
      var value = await DioClient().getQueryParam(api.apiUrl, queryParams: api.requestParam);
      api.answerPort.send(value);
    }
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

  RxBool isShowChart = false.obs;
  Rx<double> present = 0.0.obs;
  Rx<double> absent = 0.0.obs;
  Rx<int> totalEmployees = 0.obs;

  RxString nowDate = "".obs;

  Future<void> getAttendanceChartData() async{
    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if (message != null) {
        log("The Api Data of PieChart:$message");
        if(message['data']!=null) {
          present.value = (message['data']['present'] as int).toDouble();
          absent.value = (message['data']['absent'] as int).toDouble();
          totalEmployees.value = message['data']['totalEmployees'];
        }
      } else {
        isLoading.value = false;
      }
    });

    await Isolate.spawn(
      _getAttendanceChartData,
      IsolateGetApiData(
          token: rootToken,
          answerPort: receivePort.sendPort,
          apiUrl: AppURL.getAttendanceChartData
      ),
    );
  }

  static void _getAttendanceChartData(IsolateGetApiData api) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);
    await PreferenceUtils.init();

    if (await Network.isConnected()) {
      var value = await DioClient().get(api.apiUrl);
      api.answerPort.send(value);
    }
  }
}