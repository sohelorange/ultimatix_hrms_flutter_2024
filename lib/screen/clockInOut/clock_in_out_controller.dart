import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/database/clock_in_out_entity.dart';
import 'package:ultimatix_hrms_flutter/database/ultimatix_dao.dart';
import 'package:ultimatix_hrms_flutter/database/ultimatix_db.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ultimatix_hrms_flutter/utility/network.dart';
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

  Rx<File?> selectedImage = Rx<File?>(null);

  late Position geoLocation;

  late UltimatixDb database;
  late UltimatixDao localDao;

  RxString checkInTime = "--:--".obs;
  RxString checkOutTime = "--:--".obs;
  RxString totalTime = "00:00".obs;
  RxString nDate = "".obs;

  TextEditingController textDescriptionController = TextEditingController();
  RxBool isShow = true.obs;

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    nDate.value = extractDate();

    getTypeForWork();
    getBgGeoLocation();
    await initDatabase(); //TODO: temp commented because data will not require to get from local db.
    getClockInOutRecord("101", true); //TODO: This will return the data from local and set in ui for clock in or out. commented because not showing from locally.(16-01-2025 11:01AM)

    /*getCheckInOutStatus();*/ //TODO: by this the data set in ui by api for clock in or out
    super.onInit();
  }

  String extractDate() {
    DateTime now = DateTime.now();
    String dateTimeString = now.toString();
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('EEE, MMM dd, yyyy').format(dateTime);
  }

  Future<void> initDatabase() async {
    database =
        await $FloorUltimatixDb.databaseBuilder('ultimatix_db.db').build();
    localDao = database.localDao;
  }

  closeDb() async {
    await database.close();
  }

  /*Getting the In/Out Record from Db then show data in ui*/
  void getClockInOutRecord(String s, bool isImage) async {
    isLoading.value = true;

    var receivePort = ReceivePort();

    var rootToken = RootIsolateToken.instance!;

    receivePort.listen(
      (message) {
        if (message != null) {
          ClockInOutEntity entity = message;
          setDataToUi(entity, isImage);
        }
      },
    );
    await Isolate.spawn<IsolateDb>(
        _getFromDb,
        IsolateDb(
            token: rootToken,
            dao: localDao,
            s: s,
            answerPort: receivePort.sendPort));
  }

  /*Getting data from Db*/
  static void _getFromDb(IsolateDb get) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(get.token);
    ClockInOutEntity? clockInOutEntity =
        await get.dao.getClockInOutRecord(get.s);
    if (clockInOutEntity != null) {
      get.answerPort.send(clockInOutEntity);
    }
    log("data get successfully");
  }

  /*This will update the ui or show data in ui, then getting the datetime*/
  void setDataToUi(ClockInOutEntity? clockInOutEntity, bool isImage) {
    defaultValue.value = clockInOutEntity!.workMode!;
    isCheckIn.value = getStatus(clockInOutEntity.checkInStatus);
    selectedImage.value =
        isImage == true ? File(clockInOutEntity.imgPath!) : null;
    if (isCheckIn.value == false) {
      getDatTime(clockInOutEntity.checkInTime.toString(),
          clockInOutEntity.checkOutTime.toString(), true);
    } else {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('hh:mm:ss a').format(now);
      getDatTime(clockInOutEntity.checkInTime.toString(), formattedTime, false);
    }
  }

  /*This will calculate the time for check in or out, then delete the record if clocking Out*/
  void getDatTime(String punchIn, String punchOut, bool isDelete) {
    isLoading.value = false;

    DateTime tempDate1 = DateFormat("hh:mm:ss").parse(punchIn);
    String dateTimeString1 = tempDate1.toString();
    String timePart1 = dateTimeString1.split(' ')[1];
    String cleanedTime1 = timePart1.replaceAll('.000', '');
    log(cleanedTime1);
    checkInTime.value = cleanedTime1;

    DateTime tempDate2 = DateFormat("hh:mm:ss").parse(punchOut);
    String dateTimeString2 = tempDate2.toString();
    String timePart2 = dateTimeString2.split(' ')[1];
    String cleanedTime2 = timePart2.replaceAll('.000', '');
    log(cleanedTime2);

    DateTime dateTime1 = DateTime.parse('1970-01-01 $cleanedTime1');
    DateTime dateTime2 = DateTime.parse('1970-01-01 $cleanedTime2');

    // Calculate the difference
    Duration difference = dateTime2.difference(dateTime1);

    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    totalTime.value = "$hours:$minutes";
    log(totalTime.value);
    isLoading.value = false;

    if (isDelete) {
      deleteRecord();
    }
  }

  /*This will delete the record after clock out*/
  void deleteRecord() async {
    await localDao.deleteAllRecords();
  }

  /*Return boolean value for the check in/out*/
  bool getStatus(bool? checkInStatus) {
    if (checkInStatus == true) {
      return true;
    } else {
      return false;
    }
  }

  /*This is for storing data to db*/
  void _storeDataToDb() async {
    var rootToken = RootIsolateToken.instance!;
    var geoLocation = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
    String formattedTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    checkInTime.value = formattedTime;

    ClockInOutEntity entity = ClockInOutEntity(
        userId: "101",
        workMode: defaultValue.value,
        latitude: geoLocation.latitude,
        longitude: geoLocation.longitude,
        imgPath: selectedImage.value?.path,
        checkInStatus: isCheckIn.value,
        checkInTime: checkInTime.value,
        checkOutTime: checkOutTime.value,
        workHours: totalTime.value);

    await Isolate.spawn<IsolateDataStore>(_storeToDb,
        IsolateDataStore(token: rootToken, dao: localDao, entity: entity));
  }

  /*Inserting data to local storage*/
  static void _storeToDb(IsolateDataStore store) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(store.token);
    await store.dao.insertClockInOutDetails(store.entity);
    log("data stored successfully");
  }

  /*Data store in db, then getting the records for update the ui*/
  Future<void> updateClockInOut(String workHours, String userId) async {
    String formattedTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    checkOutTime.value = formattedTime;
    await localDao.updateClockInOutDetails(
        formattedTime, workHours, userId, false);
    getClockInOutRecord("101", false);
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
    PreferenceUtils.setIsClocking(isCheckIn.value);
    if (isCheckIn.value) {
      _storeDataToDb(); //TODO: commented because data will not require to store in local db 16-01-2025 11:01 AM
    } else {
      updateClockInOut("00:00", "101"); //TODO: commented because data will not require to store in db 16-01-2025 11:01 AM
    }
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

    var geoLocation = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
    dio.FormData formData = dio.FormData();
    formData.fields.add(const MapEntry("Emp_id", ""));
    formData.fields.add(const MapEntry("Cmp_id", ""));
    formData.fields.add(MapEntry(
        "Date", DateFormat('yyyy-MM-dd hh:mm:ss a').format(DateTime.now())));
    formData.fields.add(const MapEntry("IOFlag", "test"));
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
        }else {
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

  static void _getReasonApi(IsolateGetApiData isolateGetApiData) async{
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateGetApiData.token);

    await PreferenceUtils.init();
    await DioClient()
        .getQueryParam(isolateGetApiData.apiUrl,queryParams: isolateGetApiData.requestParam)
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
    /*defaultValue.value = items.elementAt(0);*/
    isLoading.value = false;
  }

  void checkWorkTypeValidation(BuildContext context){
    if(defaultValue.value.isEmpty || defaultValue.value==''){
      AppSnackBar.showGetXCustomSnackBar(message:"Please select your working mode",backgroundColor: AppColors.colorRed);
    }else{
      if(defaultValue.value=="Other"){
        checkValidation(context);
      }else{
        imageCapture(context);
      }
    }
  }

  void checkValidation(BuildContext context) {
    if(textDescriptionController.text.isEmpty || textDescriptionController.text==''){
      AppSnackBar.showGetXCustomSnackBar(message:"Please enter reason",backgroundColor: AppColors.colorRed);
    }else{
      imageCapture(context);
    }
  }

  void getCheckInOutStatus() async{
    isLoading.value = true;

    var receivePort = ReceivePort();
    receivePort.listen(
          (message) {
        if (message != null) {
          isLoading.value = false;
          remoteDataSetToUi(message);
          log("This is response getting not null:$message");
        }else {
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

  static void _getCheckInOutStatus(IsolateGetApiData isolateGetApiData) async{
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateGetApiData.token);

    await PreferenceUtils.init();
    await DioClient()
        .get(isolateGetApiData.apiUrl)
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

  void remoteDataSetToUi(message) {
    Map<String, dynamic> jsonData = json.decode(message);
    var data = jsonData['data'];

    for (var item in data) {
      String location = item['Location'];
      String ioDatetime = item['IO_Datetime'];

      print('Location: $location');
      print('IO_Datetime: $ioDatetime');

      String textBeforeColon = location.split(':')[0].trim();

      print(textBeforeColon);
    }
  }

}
