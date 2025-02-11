import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import '../../app/app_images.dart';
import '../../app/app_snack_bar.dart';
import '../../utility/isolates_class.dart';
import '../../utility/preference_utils.dart';
import '../../utility/utils.dart';

class ClockInOutController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxString defaultValue = ''.obs;

  RxList<String> items = <String>[].obs;

  RxBool isCheckIn = false.obs;
  RxBool isLoading = false.obs;
  static RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  RxString userLocAddress = "".obs;
  RxString userLastLocAddress = "N/A".obs;

  Rx<File?> selectedImage = Rx<File?>(null);

  RxString checkInOutDate = "N/A".obs;
  RxString checkInOutTime = "N/A".obs;

  TextEditingController textDescriptionController = TextEditingController();

  RxBool isLoadDropDown = true.obs;

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();

    getTypeForWork();
    getBgGeoLocation();
    getCheckInOutStatus();
    super.onInit();
  }

  /*First, executed this method after image capture clockInOutByApi method call Api for Clock In/Out*/
  void imageCapture(BuildContext context) async {
    selectedImage.value?.absolute.delete();
    var image = await Utils.captureSelfie(context: context);
    if (image != null) {
      selectedImage.value = File(image.path);
      clockInOutByApi();
    }
  }

  /*This will update the ui as well as store & update the data in local db after getting api success response*/
  void checkInOutEvent() async {
    isCheckIn.value = !isCheckIn.value;
  }

  /*This method is collecting the geolocation lat long, then getting address by _getAddressByLoc method*/
  void getBgGeoLocation() async {
    isLoading.value = true;
    var receivePort = ReceivePort();

    receivePort.listen(
      (message) {
        if (message != null) {
          userLocAddress.value = message;
          isLoading.value = false;
        } else {
          isLoading.value = false;
          userLocAddress.value = "Address not found";
        }
      },
    );

    if (await Geolocator.isLocationServiceEnabled()) {
      var rootToken = RootIsolateToken.instance!;
      await Isolate.spawn<IsolateLocationData>(
        _getAddressByLoc,
        IsolateLocationData(
          token: rootToken,
          answerPort: receivePort.sendPort,
        ),
      );
    }
  }

  /*This will get the Address by lat long*/
  static void _getAddressByLoc(IsolateLocationData isolateData) async {
    try {
      BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);
      var geoLocation = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.bestForNavigation));
      List<Placemark> address = await placemarkFromCoordinates(
          geoLocation.latitude, geoLocation.longitude);
      if (address.isNotEmpty) {
        Placemark place = address[0];
        isolateData.answerPort.send(
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.thoroughfare}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}");
      }
    } catch (e) {
      e.printError();
    }
  }

  /*This method preparing the data, then execute the _callApi for Api*/
  Future<void> clockInOutByApi() async {
    isLoading.value = true;

    log("Is Login:${isCheckIn.value}");

    var geoLocation = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
    dio.FormData formData = dio.FormData();
    formData.fields.add(const MapEntry("Emp_id", ""));
    formData.fields.add(const MapEntry("Cmp_id", ""));
    formData.fields.add(MapEntry(
        "Date", DateFormat('yyyy-MM-dd hh:mm:ss a').format(DateTime.now())));
    formData.fields.add(MapEntry("IOFlag", isCheckIn.value==false ? "I" : "O"));
    formData.fields.add(const MapEntry("IMEIno", ""));
    formData.fields.add(MapEntry("Address", userLocAddress.value.trim()));
    formData.fields.add(MapEntry("Latitude", "${geoLocation.latitude}"));
    formData.fields.add(MapEntry("Longitude", "${geoLocation.longitude}"));
    formData.fields.add(MapEntry("Reason", "$defaultValue"));

    if (selectedImage.value != null) {
      formData.files.add(MapEntry(
        'file',
        await dio.MultipartFile.fromFile(selectedImage.value!.path,
            filename: selectedImage.value?.path.isImageFileName.toString()),
      ));
    } else {
      formData.files.add(MapEntry(
        'file',
        dio.MultipartFile.fromString("", filename: "test.jpg"),
      ));
    }

    var receivePort = ReceivePort();
    receivePort.listen(
      (message) {
        if (message != null) {
          log(message);
          isLoading.value = false;
          checkInOutEvent();
        }
      },
    );

    for (var element in formData.fields) {
      log("The data of request is:${element}");
    }

    var rootToken = RootIsolateToken.instance!;
    if (await Network.isConnected()) {
      Isolate.spawn(
          _callApi,
          IsolateApiFormData(
              token: rootToken,
              formData: formData,
              answerPort: receivePort.sendPort,
              apiUrl: isCheckIn.value == false
                  ? AppURL.clockInURL
                  : AppURL.clockOutURL));
    }
  }

  /*This method is call the api with parameters*/
  static void _callApi(IsolateApiFormData isolateData) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);

    await PreferenceUtils.init();
    await DioClient()
        .postFormData(isolateData.apiUrl, isolateData.formData)
        .then(
      (value) {
        if (value != null) {
          isolateData.answerPort.send("Api data getting success");
        } else {
          isolateData.answerPort.send("Api data getting null");
        }
      },
    );
  }

  getTypeForWork() async {
    isLoading.value = true;

    Map<String, dynamic> requestParam = {"ReasonType": "MA"};

    var receivePort = ReceivePort();
    receivePort.listen(
      (message) {
        if (message != null) {
          setToUi(message);
        } else {
          isLoading.value = false;
          log("This is response getting null");
        }
      },
    );

    var rootToken = RootIsolateToken.instance!;
    if (await Network.isConnected()) {
      Isolate.spawn(
          _getReasonApi,
          IsolateGetApiData(
              token: rootToken,
              answerPort: receivePort.sendPort,
              apiUrl: AppURL.attendanceGetReasonURL,
              requestParam: requestParam));
    }
  }

  static void _getReasonApi(IsolateGetApiData isolateGetApiData) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateGetApiData.token);

    await PreferenceUtils.init();
    await DioClient()
        .getQueryParam(isolateGetApiData.apiUrl,
            queryParams: isolateGetApiData.requestParam)
        .then(
      (value) {
        if (value != null) {
          isolateGetApiData.answerPort.send(value);
        } else {
          isolateGetApiData.answerPort.send(null);
        }
      },
    );
  }

  void setToUi(message) {
    Map<String, dynamic> mes = message;

    List<dynamic> data = mes['data'];

    for (var item in data) {
      items.add(item['Reason_Name'].toString().trim());
    }
    addItemsToDropdown(items);

    isLoading.value = false;
  }

  /*void checkWorkTypeValidation(BuildContext context) {
    if (defaultValue.value.isEmpty || defaultValue.value == '') {
      AppSnackBar.showGetXCustomSnackBar(
          message: "Please select your working mode",
          backgroundColor: AppColors.colorRed);
    } else {
      if (defaultValue.value == "Other") {
        checkValidation(context);
      } else {
        imageCapture(context);
      }
    }
  }*/

  /*As per discussion with sir will made it non-mandatory*/
  void checkWorkTypeValidation(BuildContext context) {
    if (defaultValue.value == "Other") {
      checkValidation(context);
    } else {
      imageCapture(context);
    }
  }

  void checkValidation(BuildContext context) {
    if (textDescriptionController.text.isEmpty ||
        textDescriptionController.text == '') {
      AppSnackBar.showGetXCustomSnackBar(
          message: "Please enter reason", backgroundColor: AppColors.colorRed);
    } else {
      imageCapture(context);
    }
  }

  void getCheckInOutStatus() async {
    isLoading.value = true;

    var receivePort = ReceivePort();
    receivePort.listen(
      (message) {
        if (message != null) {
          isLoading.value = false;
          log("This is response getting not null:$message");
          remoteDataSetToUi(message);
        } else {
          isLoading.value = false;
          log("This is response getting null");
        }
      },
    );

    var rootToken = RootIsolateToken.instance!;
    if (await Network.isConnected()) {
      Isolate.spawn(
          _getCheckInOutStatus,
          IsolateGetApiData(
            token: rootToken,
            answerPort: receivePort.sendPort,
            apiUrl: AppURL.checkInOutStatusURL,
          ));
    }
  }

  static void _getCheckInOutStatus(IsolateGetApiData isolateGetApiData) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateGetApiData.token);

    await PreferenceUtils.init();
    await DioClient().get(isolateGetApiData.apiUrl).then(
      (value) {
        if (value != null) {
          isolateGetApiData.answerPort.send(value);
        } else {
          isolateGetApiData.answerPort.send(null);
        }
      },
    );
  }

  void remoteDataSetToUi(message) {
    Map<String, dynamic> mes = message;
    //Map<String, dynamic> jsonData = json.decode(message);
    if(mes['data']!=null && mes['data']!=isBlank){
      var data = mes['data'];

      for (var item in data) {
        String location = item['Location'];
        String ioDatetime = item['IO_Datetime'];
        String inOutFlag = item['In_Out_Flag'];


        log('Location: $location');
        log('IO_Datetime: $ioDatetime');
        log('In_Out_Flag: $inOutFlag');

        String textBeforeColon = location.split(':')[0].trim();

        log(textBeforeColon);

        defaultValue.value = '';
        isCheckIn.value = textBeforeColon.trim()=="In" && inOutFlag.trim()=="I" ? true : false;
        selectedImage.value = null;
        userLastLocAddress.value = location.trim();
        setDateTimeLastCheckInOut(ioDatetime.trim());
      }
    }
  }

  void setDateTimeLastCheckInOut(String ioTime) {
    DateTime dateTime = DateTime.parse(ioTime);
    checkInOutDate.value = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    checkInOutTime.value = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  final List<DropdownMenuItem<String>> menuItems = [];

  void addItemsToDropdown(RxList<String>? items) {
    for (final String item in items!) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 0.8),
                ),
              ),
              child: Row(
                children: [
                  defaultValue.value != item
                      ? Container()
                      : SvgPicture.asset(AppImages.svgClockNew),
                  Text(
                    item,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    isLoadDropDown.value = false;
  }
}
