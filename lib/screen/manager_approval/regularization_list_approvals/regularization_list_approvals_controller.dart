import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../api/dio_client.dart';
import '../../../api/model/GetAttendanceApprovalRegularizeModel.dart';
import '../../../app/app_url.dart';
import '../../../utility/network.dart';
import '../../../utility/preference_utils.dart';

class RegularizationListApprovalsController extends GetxController{

  RxBool isLoading = true.obs;
  RxString currentMonth = "".obs;
  RxString userProfile = "".obs;
  RxString userName = "".obs;
  RxString userDesignation = "".obs;
  RxString userEmpId = "".obs;
  RxString userCmpId = "".obs;

  Rx<GetAttendanceApprovalRegularizeModel> attendanceApprovalListData = GetAttendanceApprovalRegularizeModel().obs;

  @override
  void onInit() {
    getRegularizeApprovalList();
    super.onInit();
  }

  void getRegularizeApprovalList() async{
    var receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if(message!=null){
        attendanceApprovalListData.value = GetAttendanceApprovalRegularizeModel.fromJson(message);
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    },);

    await Isolate.spawn<_IsolateGetApiData>(_getAttendanceRecordsByApi,
        _IsolateGetApiData(
            token: rootToken,
            answerPort: receivePort.sendPort,
            apiUrl: AppURL.attendanceRegularizeApplicationRecord));
  }

  static void _getAttendanceRecordsByApi(_IsolateGetApiData api) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(api.token);
    await PreferenceUtils.init();
    if(await Network.isConnected()) {
      await DioClient().get(api.apiUrl).then((value) {
        if(value!=null){
          api.answerPort.send(value);
        }else{
          api.answerPort.send(null);
        }
      },);
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

//TODO: *This class required to make common 27-12-2024*
class _IsolateGetApiData {
  final RootIsolateToken token;
  final SendPort answerPort;
  final String apiUrl;

  _IsolateGetApiData({required this.token, required this.answerPort, required this.apiUrl});
}