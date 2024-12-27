import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

import '../../api/dio_client.dart';
import '../../api/model/AttendanceRegularizeDetails.dart';
import '../../api/model/team_attendance_response.dart';
import '../../utility/network.dart';

class AttendanceMainController extends GetxController{

  RxBool isLoading = true.obs;
  RxString userAddress = "".obs;
  RxString userCheckInTime = "10:00 AM".obs;
  RxString userCheckoutTime = "6:00 PM".obs;
  RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedMonth = DateTime.now().month.obs;
  RxList<String> items = <String>[
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ].obs;

  RxString empID = "".obs;
  RxString cmpID = "".obs;

  RxString userName = "".obs;
  RxString userDesignation = "".obs;

  RxString userProfileUrl = "".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;

  Rx<TeamAttendanceResponse> teamAttendanceResponse = TeamAttendanceResponse().obs;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails = AttendanceRegularizeDetails().obs;

  @override
  void onInit() {
    getLocalData();
    getMyTeamRecords();
    getUserAttendanceRecords();
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

  void checkTeam() {
    log("The length of the User is*= ${teamAttendanceResponse.value.data?.length}");
    if(teamAttendanceResponse.value.data!.isEmpty){
      getUserAttendanceRecords();
    }
  }

  void getUserAttendanceRecords() async{
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
      "month": selectedMonth.value,
      "year": selectedYear.value,
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