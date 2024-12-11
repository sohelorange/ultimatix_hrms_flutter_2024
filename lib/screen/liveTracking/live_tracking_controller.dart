import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/network.dart';

class LiveTrackingController extends GetxController{

  RxBool isLoading = false.obs;
  late WebViewController? webController;
  RxString userProfile = "".obs;
  RxString userName = "Test User".obs;
  RxString textPosition = "Ahemedabad".obs;
  RxString battery = "20%".obs;
  RxDouble distance = 0.0.obs;
  RxString trackDate = "".obs;

  @override
  void onInit() {
    getLiveTrackingByApi();
    webController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/map/index.html')..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {
        isLoading.value = false;
        /*getCurrentPosition(Get.context!);*/
      },));
    super.onInit();
  }

  Future<void> getLiveTrackingByApi() async{
    Map<String, dynamic> requestParam = {
      "empID":"28199",
      "cmpID":"187",
      "date":"2024-12-03"
    };

    if(await Network.isConnected()){
      await DioClient().post(AppURL.getTrackRecordURL, requestParam).then((value) {
        if (value != null) {
          String response = "$value";
          log(response);
          Map<String, dynamic> jsonResponse = value;
          log(jsonResponse['message']);
        }else{
          log("Location Tracking data not getting");
        }
      },);
    }
  }

  String getDateInFormat(String? trackingDate) {
    // Original date string
    String dateStr = trackingDate ?? "";

    // Parse the string to a DateTime object
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the DateTime object
    String formattedTimeFirst = DateFormat('HH:mm:ss').format(dateTime);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

    // Combine formatted time and date
    String result = '$formattedTimeFirst, $formattedDate';
    return result;
    print(result); // Output: 11:12:09, 01 August 2024
  }
}

class _IsolateGet {
  final RootIsolateToken token;
  final SendPort answerPort;

  _IsolateGet({required this.token, required this.answerPort});
}