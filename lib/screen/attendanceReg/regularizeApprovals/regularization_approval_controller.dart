import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../api/dio_client.dart';
import '../../../api/model/GetAttendanceApprovalRegularizeModel.dart';
import '../../../app/app_url.dart';
import '../../../utility/network.dart';
import '../../../utility/preference_utils.dart';

class RegularizeApprovalController extends GetxController{
  RxString employeeName = "OTL0111-Mr. Vivek Singh".obs;
  RxString appliedDate = "24/12/2024".obs;
  RxString presentDay = "".obs;

  String inTime = "";
  String outTime = "";

  String appliedReason = "Forgot to punch in";
  String earlyOut = "";

  RxString inTime2 = "".obs;
  RxString outTime2 = "".obs;

  RxBool isCancelLateIn = true.obs;
  RxBool isCancelEarlyOut = true.obs;

  RxInt selectedValue = 0.obs;

  TextEditingController textCommentController = TextEditingController();
  RxBool isLoading = true.obs;

  Rx<GetAttendanceApprovalRegularizeModel> attendanceApprovalListData = GetAttendanceApprovalRegularizeModel().obs;

  @override
  void onInit() {
    log("This Controller Start");
    getApprovalDetails();
    super.onInit();
  }

  void getApprovalDetails() async{
    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if(message!=null){
        attendanceApprovalListData.value = GetAttendanceApprovalRegularizeModel.fromJson(message);
        selectedValue.value = getSelectedRadio();
        isCancelEarlyOut.value = attendanceApprovalListData.value.data?.elementAt(0).isCancelEarlyOut==0 ? true : false;
        isCancelLateIn.value = attendanceApprovalListData.value.data?.elementAt(0).isCancelLateIn==0 ? true : false;
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    },);

    Map<String, dynamic> requestParam = {
      /*"ApplicationId": 0,*/
    };

    await Isolate.spawn<_IsolateApiData>(_getApprovalDetailsByApi,
        _IsolateApiData(
            token: rootToken,
            requestData: requestParam,
            answerPort: receivePort.sendPort,
            apiUrl: "${AppURL.getAttendanceRegularizeApplicationDetails}?ApplicationId=0"));
  }

  static void _getApprovalDetailsByApi(_IsolateApiData api) async{
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

  void toCallApi() async{
    log("This Function is start");
    isLoading.value = true;

    Map<String, dynamic> requestParam = {
      "applicationID": 0,
      "empID": attendanceApprovalListData.value.data?.elementAt(0).empId,
      "cmpID": attendanceApprovalListData.value.data?.elementAt(0).cmpID,
      "fordate": attendanceApprovalListData.value.data?.elementAt(0).forDate,
      "reason": attendanceApprovalListData.value.data?.elementAt(0).reason ?? "",
      "halfFullDay": getDay(),
      "cancelLateIn": isCancelLateIn.value==true ? 1 : 0,
      "cancelEarlyOut": isCancelEarlyOut.value==true ? 1 : 0,
      "intime": attendanceApprovalListData.value.data?.elementAt(0).shInTime ?? "",
      "outTime": attendanceApprovalListData.value.data?.elementAt(0).shOutTime ?? "",
      "comment": textCommentController.text.trim(),
      "sEmpID": 0,
      "rptLevel": 0,
      "finalApproval": 0,
      "isFWDRej": 0,
      "appStatus": "string"
    };

    await PreferenceUtils.init();

    if(await Network.isConnected()){
      log("Checked the internet connection");
      await DioClient().post(AppURL.attendanceRegularizeApproval, requestParam).then((value) {
        if (value != null) {
          log("The result of the api is:$value");
          isLoading.value = false;
        } else{
          log("The result is getting null");
          isLoading.value = false;
        }
      },);
    }
  }


  int getSelectedRadio() {
    if(attendanceApprovalListData.value.data?.elementAt(0).halfFullDay?.trim().toString()=="Full Day"){
      return 0;
    }else if(attendanceApprovalListData.value.data?.elementAt(0).halfFullDay?.trim().toString()=="Half Day"){
      return 1;
    }else{
      return 2;
    }
  }

  getDay() {
    if(selectedValue.value==0){
      return "Full Day";
    }else if(selectedValue.value==1){
      return "Half Day";
    }else{
      return "Second Day";
    }
  }
}

class _IsolateApiData {
  final RootIsolateToken token;
  final Map<String, dynamic> requestData;
  final SendPort answerPort;
  final String apiUrl;

  _IsolateApiData({required this.token, required this.requestData, required this.answerPort, required this.apiUrl});
}