import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/attendance_controller.dart';

import '../../../api/dio_client.dart';
import '../../../api/model/get_reason_response.dart';
import '../../../app/app_colors.dart';
import '../../../app/app_snack_bar.dart';
import '../../../app/app_url.dart';
import '../userAttendanceRegularize/attendance_user_controller.dart';

class RegularizeApplyController extends GetxController{

  RxString shiftTime = "".obs;
  RxString presentDay = "".obs;

  String inTime = "";
  String outTime = "";
  String lateIn = "";
  String earlyOut = "";

  RxString inTime2 = "".obs;
  RxString outTime2 = "".obs;

  Rx<GetReasonResponse> responseReason = GetReasonResponse().obs;


  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textReasonController = TextEditingController();
  FocusNode textDescFocus = FocusNode();
  FocusNode textReasonFocus = FocusNode();


  RxString selectedReason = "".obs;
  RxInt selectedReasonIndex = 0.obs;
  RxInt selectedTypeIndex = 0.obs;

  String? selectedItem;

  RxBool isCancelLateIn = true.obs;
  RxBool isCancelEarlyOut = true.obs;

  dynamic argumentData = Get.arguments;

  RxList<String> listOfType = [
    'Full Day',
  ].obs;

  RxBool istre = false.obs;

  RxList<String> listOfReason = [
    '',
  ].obs;

  num empId = 0;
  num cmpId = 0;

  String forDate = "";

  num cancellationLateIn = 0;
  num cancellationEarlyOut = 0;

  late String uiName;

  @override
  void onInit() {
    log("Ui name is:1");
    shiftTime.value = argumentData[0]['Shift1'] +" "+ argumentData[0]['Shift2'];


    empId = argumentData[0]['empId'];
    cmpId = argumentData[0]['cmpId'];
    forDate = argumentData[0]['forDate'];

    presentDay.value = argumentData[0]['halfFullDay'].toString() ?? "--:--";

    cancellationLateIn = argumentData[0]['cancellationLateIn'];
    cancellationEarlyOut = argumentData[0]['cancellationEarlyOut'];

    inTime = argumentData[0]['inTime1'].toString() ?? "--:--";
    outTime = argumentData[0]['outTime1'].toString() ?? "--:--";

    lateIn = argumentData[0]['lateIn'].toString() ?? "--:--";
    earlyOut = argumentData[0]['earlyOut'].toString() ?? "--:--";

    uiName = argumentData[0]['UiName'].toString();

    log("The Ui name is :$uiName");

    inTime2.value = argumentData[0]['Shift1']; //TODO: check condition in native 28-11-2024

    outTime2.value = argumentData[0]['Shift2'];

    /*responseReason.value = GetReasonResponse.fromJson({
      "status" : true,
      "code" : 200,
      "message" : "Success",
      "data" : [{"Res_Id":66,"Reason_Name":"Others1"}]
    });*/

    getAttendanceReason();

    super.onInit();
  }

  void checkValidation(){
    if(listOfReason[selectedReasonIndex.value].isEmpty){
      AppSnackBar.showGetXCustomSnackBar(message:"Please select the Reason");
    }else if(textDescriptionController.text.isEmpty){
      AppSnackBar.showGetXCustomSnackBar(message:"Please enter the description");
    }else if(listOfType[selectedTypeIndex.value].isEmpty){
      AppSnackBar.showGetXCustomSnackBar(message:"Please select the type");
    }else if(inTime2.value.isEmpty){
      AppSnackBar.showGetXCustomSnackBar(message:"Please select the in time");
    }else if(outTime2.value.isEmpty){
      AppSnackBar.showGetXCustomSnackBar(message:"Please select the out time");
    }else {
      attendanceRegularizeApply();
    }
  }

  Future<void> attendanceRegularizeApply() async{
    try{
      Map<String, dynamic> requestParam = {
        "empID": empId,
        "cmpID": cmpId,
        "month": DateTime.now().month,
        "year": DateTime.now().year,
        "fordate": forDate,
        "reason": listOfReason[selectedReasonIndex.value],
        "halfFullDay": listOfType[selectedTypeIndex.value],
        "cancelLateIn": isCancelLateIn.value==false ? 0 : 1,
        "cancelEarlyOut": isCancelEarlyOut.value==false ? 0 : 1,
        "intime": inTime2.value,
        "outTime": outTime2.value,
        "isApprove": 0,
        "otherReason": "string",
        "imeiNo": "string"
      };

      await DioClient().post(AppURL.attendanceRegularizeInsertURL, requestParam).then((value) {
        if(value!=null){

          String response = "$value";
          log(response);

          Map<String, dynamic> jsonResponse = value;
          log(jsonResponse["message"]);

          if(jsonResponse["code"]==200){
            if(jsonResponse["data"]!=null){
              String respMessage = jsonResponse["data"].toString();
              RegExp regExp = RegExp(r'(\w+\s[\w\s]+)#(\w+)#\d+');
              Match? match = regExp.firstMatch(respMessage);

              if (match != null) {
                String attendanceMessage = match.group(1) ?? '';
                goBack(attendanceMessage,"green");
              }else{
                goBack(jsonResponse["data"],"red");
              }
            }else{
              log("Server data getting empty");
            }
          }else{
            log("Server Error");
          }
        }else{
          AppSnackBar.showGetXCustomSnackBar(message: "Data getting null");
          log("Api Data getting null");
        }
      });
    }catch(e){
      e.printError();
    }
  }

  Future<void> getAttendanceReason() async {
    try{
      Map<String, dynamic> requestParam = {
        "ReasonType":"R"
      };

      await DioClient().getQueryParam(AppURL.attendanceGetReasonURL, queryParams: requestParam).then((value) {
        if(value!=null){
          String response = "$value";
          log(response);

          Map<String, dynamic> jsonResponse = value;
          log(jsonResponse["message"]);

          if(jsonResponse["code"]==200){
            responseReason.value = GetReasonResponse.fromJson(value);

            storeReason(responseReason.value);
          }
        }else{
          log("Data getting null");
          log("Api Data getting null");
        }
      });
    }catch(e){
      e.printError();
    }
  }

  void storeReason(GetReasonResponse value) {
    listOfReason.clear();
    for(int i=0;i<responseReason.value.data!.length;i++){
      listOfReason.add(responseReason.value.data?.elementAt(i).reasonName??"");
    }
  }

  Future<void> displayTimePicker(String s) async{
    var time = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now().replacing(),
        initialEntryMode: TimePickerEntryMode.dialOnly
    );
    if(time!=null) {
      final localizations = MaterialLocalizations.of(Get.context!);
      String formattedTime = localizations.formatTimeOfDay(
          time, alwaysUse24HourFormat: true);

      log("This time: $formattedTime ${time.period.name}");
      if(s=="outTime"){
        outTime2.value = "$formattedTime ${time.period.name}";
      }else{
        inTime2.value = "$formattedTime ${time.period.name}";
      }
    }
  }

  void goBack(String message, String color) {
    if(uiName=="AttendanceMainUi"){
      Get.find<AttendanceMainController>().getUserAttendanceRecords(DateTime.now().year,DateTime.now().month);
      Get.back();
      AppSnackBar.showGetXCustomSnackBar(message:message,backgroundColor: color == "green" ? AppColors.colorGreen : AppColors.colorRed);
    }else if(uiName=="AttendanceUserUi"){
      Get.find<UserAttendanceController>().callUserAttendanceRegularizationDetails(DateTime.now().year,DateTime.now().month);
      Get.back();
      AppSnackBar.showGetXCustomSnackBar(message:message,backgroundColor: color == "green" ? AppColors.colorGreen : AppColors.colorRed);
    }else{
      Get.back();
    }
  }

}