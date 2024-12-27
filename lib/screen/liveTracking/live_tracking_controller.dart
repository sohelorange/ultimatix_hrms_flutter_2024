import 'dart:developer';
import 'dart:isolate';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../api/model/location_track_response.dart';
import '../../utility/network.dart';
import '../../utility/preference_utils.dart';

class LiveTrackingController extends GetxController{

  RxBool isLoadingOnUi = true.obs;
  late WebViewController? webController;
  RxString userProfile = "".obs;
  RxString userName = "Test User".obs;
  RxString userLocAddress = "".obs;

  num empId = 0;
  num cmpId = 0;

  RxString battery = "0%".obs;
  RxDouble distance = 0.0.obs;
  RxString trackTime = "0.0".obs;
  RxString trackDate = "".obs;

  RxBool isWebLoading = true.obs;

  Rx<LocationTrackResponse> locationTrackingResponse = LocationTrackResponse().obs;
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  dynamic argumentData = Get.arguments;

  @override
  void onInit() async{

    getLocalData();
    webController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/map/index.html')..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {
        isWebLoading.value = false;
        getBgGeoLocation();
      },));
    getGeoLocationTrackingList(selectedDate);
    getBatteryPercentage();
    super.onInit();
  }


  void getGeoLocationTrackingList(String nSelectedDate) async{
    var receivePort = ReceivePort();

    var rootToken = RootIsolateToken.instance!;

    receivePort.listen((message) {
      if(message!=null){
        isLoadingOnUi.value = false;
        locationTrackingResponse.value = LocationTrackResponse.fromJson(message);
        if (locationTrackingResponse.value.data != null && locationTrackingResponse.value.code==200) {
          log("Response getting success:${locationTrackingResponse.value.message}");
          showTrack(locationTrackingResponse.value);
          calculateTimeDifference(locationTrackingResponse.value.data!.first.trackingDate!.trim().toString(), locationTrackingResponse.value.data!.last.trackingDate!.trim().toString());
        }else{ //TODO: Add the dialog or the clean ui without any data show here when data getting the null 11-12-2024.
          isLoadingOnUi.value = false;
          log("Response getting not success");
        }
      }else{
        isLoadingOnUi.value = false;
        log("Response getting error");
      }
    },);

    //"2024-12-03"

    Map<String, dynamic> requestParam = {
      "empID":empId,
      "cmpID":cmpId,
      "date":nSelectedDate
    };

    await Isolate.spawn<_IsolateApiData>(_getGeoLocationTrackingListByApi, _IsolateApiData(
        token: rootToken, requestData: requestParam,
        answerPort: receivePort.sendPort, apiUrl: AppURL.getGeoLocationTrackingList
    ));
  }

  static void _getGeoLocationTrackingListByApi(_IsolateApiData api) async{
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
    return result;// Output: 11:12:09, 01 August 2024
  }

  void getBgGeoLocation() async{

    isLoadingOnUi.value = true;
    var receivePort= ReceivePort();

    receivePort.listen((message) {
      if(message!=null) {
        getCurrentPosition(message);
        log("This address is the:$message");
        userLocAddress.value = message.substring(0,message.lastIndexOf("+"));
        isLoadingOnUi.value = false;
      }else{
        isLoadingOnUi.value = false;
        userLocAddress.value = "Address not found";
      }
    },);

    if(await Geolocator.isLocationServiceEnabled()){
      var rootToken = RootIsolateToken.instance!;
      await Isolate.spawn<_IsolateData>(_getAddressByLoc, _IsolateData(token: rootToken, answerPort: receivePort.sendPort,),);
    }
  }

  static void _getAddressByLoc(_IsolateData isolateData) async{
    try{
      BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);
      var geoLocation = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation));
      List<Placemark> address = await placemarkFromCoordinates(geoLocation.latitude, geoLocation.longitude);
      if(address.isNotEmpty){
        Placemark place = address[0];
        isolateData.answerPort.send("${place.name}, ${place.street}, ${place.subLocality}, ${place
            .thoroughfare}, ${place.locality}, ${place
            .administrativeArea}, ${place.country}, ${place.postalCode} + ${geoLocation.latitude},${geoLocation.longitude}");
      }
    }catch(e){
      e.printError();
    }
  }

  Future<void> getCurrentPosition(address) async {
    try {
      List<String> parts1 = address.split('+');
      var test2 = parts1[1].trim();
      List<String> parts2 = test2.split(',');

      var latitude = parts2[0];
      var longitude = parts2[1];

      webController?.runJavaScript('displayLocation($longitude,$latitude);');
    }catch(e){
      e.printError(info: "Getting Error while collect locations");
    }
  }

  Future<void> getBatteryPercentage() async{
    final level = await Battery().batteryLevel;
    battery.value = level.toString();
  }

  Future<void> showTrack(LocationTrackResponse value) async{
    List<List<double>> locList = [];

    for(int i=0;i<value.data!.length;i++){
      locList.add([value.data!.elementAt(0).longitude!.toDouble(),value.data!.elementAt(0).latitude!.toDouble()]);
    }

    await webController?.runJavaScript('displayTrack($locList)');
    metersToKilometers(value.data!.elementAt(0).latitude!.toDouble(),value.data!.elementAt(0).longitude!.toDouble(),value.data!.elementAt(0).latitude!.toDouble(),value.data!.elementAt(0).longitude!.toDouble());
  }

  Future<void> metersToKilometers(double startLatitude,double startLongitude, double endLatitude, double endLongitude) async{
    double meters = getDistanceByLatLon(startLatitude, startLongitude, endLatitude, endLongitude);
    double km = meters / 1000;
    distance.value = km;
  }

  double getDistanceByLatLon(double startLatitude,double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  Future<void> calculateTimeDifference(String time1Str, String time2Str) async{

    DateTime time1 = DateTime.parse(time1Str);
    DateTime time2 = DateTime.parse(time2Str);

    Duration difference = time2.difference(time1);

    int differenceInMinutes = difference.inMinutes;
    double differenceInHours = difference.inHours.toDouble() + (difference.inMinutes % 60) / 60.0;

    if (differenceInMinutes > 60) {
      log('Difference in hours: ${differenceInHours.toStringAsFixed(2)} hour');
      trackTime.value = "${differenceInHours.toStringAsFixed(2)} hour";
    } else {
      trackTime.value = "${differenceInHours.toStringAsFixed(2)} min";
      log('Difference in minutes: $differenceInMinutes min');
    }
  }

  void setInGeoFencingLocation() async{
    webController?.runJavaScript('displayLocation(72.502564, 23.011767);');
    await webController?.runJavaScript('geoFencing(72.502564, 23.011767, 72.502564, 23.011767)');
  }

  void setOutGeoFencingLocation() async{
    webController?.runJavaScript('displayLocation(72.20294, 22.46072);');
    await webController?.runJavaScript('geoFencing(72.502564, 23.011767, 72.20294, 22.46072)');
  }

  void showStaticTrack() async{
    List<List<double>> locList = [[72.502564, 23.011767],[72.495011, 22.987336]];
    webController?.runJavaScript('displayLocation(72.502564,23.011767);');

    await webController?.runJavaScript('displayTrack($locList)');
    metersToKilometers(23.011767,72.502564,22.987336,72.495011);
  }

  getLocalData() {
    userName.value = argumentData[0]['username'];
    empId = argumentData[0]['empId'];
    cmpId = argumentData[0]['cmpId'];
    userProfile.value = argumentData[0]['userImage'];

    /*Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();

    userProfile.value = loginData['image_Name'] ?? '';
    userName.value = loginData['emp_Full_Name'] ?? '';
    empID.value = loginData['emp_ID'].toString();
    cmpID.value = loginData['cmp_ID'].toString();*/
  }
}

class _IsolateData {
  final RootIsolateToken token;
  final SendPort answerPort;

  _IsolateData({required this.token, required this.answerPort,});
}


class _IsolateApiData {
  final RootIsolateToken token;
  final Map<String, dynamic> requestData;
  final SendPort answerPort;
  final String apiUrl;

  _IsolateApiData({required this.token, required this.requestData, required this.answerPort, required this.apiUrl});
}