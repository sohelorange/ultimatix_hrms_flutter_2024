import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../../api/dio_client.dart';
import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import '../../app/app_snack_bar.dart';
import '../../database/location_entity.dart';
import '../../database/ultimatix_dao.dart';
import '../../database/ultimatix_db.dart';
import '../../services/notification_services.dart';
import '../../utility/constants.dart';
import '../../utility/network.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;
  RxInt selectedIndex = 0.obs;

  RxString address = ''.obs;
  RxString checkInTime = "--:--".obs;
  RxString checkOutTime = "--:--".obs;
  RxString workingHours = "00:00".obs;
  RxString todayDayDate = "".obs;
  RxString currentMonthYear = "".obs;

  RxString presentDayLbl = "Present".obs;
  RxString presentDayValue = "0".obs;
  RxString leaveDayLbl = "Leave".obs;
  RxString leaveDayValue = "0".obs;
  RxString absentDayLbl = "Absent".obs;
  RxString absentDayValue = "0".obs;
  RxString onDutyDayLbl = "On Duty".obs;
  RxString onDutyDayValue = "0".obs;
  RxString holidayDayLbl = "Holiday".obs;
  RxString holidayDayValue = "0".obs;
  RxString weekOffDayLbl = "Week Off".obs;
  RxString weekOffDayValue = "0".obs;
  RxString userImageUrl = "".obs;
  RxString cmpImageUrl = "".obs;
  RxString userName = "".obs;
  String empID = "";
  String cmpID = "";

  int isGeofenceEnable = 0;

  RxList<Map<String, dynamic>> statusData = <Map<String, dynamic>>[].obs;

  final List<String> listEvent = [
    "https://www.shutterstock.com/image-vector/happy-diwali-celebration-background-festival-600nw-2523970115.jpg",
    "https://t3.ftcdn.net/jpg/08/95/86/82/360_F_895868299_z8aR16uHjnkrtnUkzohVQ68m26JBNt4f.jpg",
    "https://media.istockphoto.com/id/1774494924/photo/sister-applying-tilaka-to-her-brother-at-home-during-bhai-dooj.jpg?s=612x612&w=0&k=20&c=z2nNx7asAdglLCBIhJwy3JV2qwDVMT5AAyfxrJ5r_XU=",
  ];

  final NotificationServices _notificationServices = NotificationServices();

  ValueNotifier<bool> checkInOutStatus = ValueNotifier<bool>(false);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    try {
      checkInOutStatus.value = PreferenceUtils.getIsClocking();

      _getCurrentLocation().then((value) => {
            _notificationServices.requestNotificationPermission(),
            _notificationServices.firebaseInit(Get.context!),
            _notificationServices.setUpInterMsg(Get.context!),
            //notificationServices.isTokenRefresh();
            _notificationServices.getDeviceToken().then((value) => {
                  // ignore: avoid_print
                  print('Device Token $value')
                }),
          });

      Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
      userImageUrl.value = loginData['image_Name'] ?? '';
      cmpImageUrl.value = loginData['cmp_Logo'] ?? '';
      userName.value = loginData['emp_Sort_Name'] ?? '';
      empID = loginData['emp_ID'].toString();
      cmpID = loginData['cmp_ID'].toString();

      isGeofenceEnable = loginData['is_Geofence_enable'];

      fetchDataInParallel();

      // Get the current date
      DateTime now = DateTime.now();
      currentMonthYear.value = DateFormat('MMMM yyyy').format(now);
      todayDayDate.value = getTodayFormattedDate();

      /*await initDatabase();
      await getAllLocationRecords().then(
        (value) {
          syncAllGeoLocationRecord();
        },
      );
      initializeService();*/
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onBottomTabSelected(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.dashBoardRoute);
        break;
      case 1:
        Get.toNamed(AppRoutes.exploreTabRoute);
        break;
      case 2:
        Get.toNamed(AppRoutes.attendanceMainRoute);
        break;
      case 3:
        Get.toNamed(AppRoutes.leaveApplicationRoute);
        break;
    }
  }

  String getTodayFormattedDate() {
    DateTime now = DateTime.now();
    //String formattedDate = DateFormat("E, MMM d, yyyy").format(now);//Short Name Day
    String formattedDate =
        DateFormat("EEEE, MMM d, yyyy").format(now); // Full Name Day
    return formattedDate;
  }

  Future<void> fetchDataInParallel() async {
    if (await Network.isConnected()) {
      try {
        isLoading(true);
        await Future.wait([
          fetchDashboardAttendanceHistoryAPICall(),
          fetchDashboardPresentDetailsAPICall(),
        ]).then((_) {
          isLoading(false);
        });
      } catch (e) {
        isLoading(false);
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> fetchDashboardPresentDetailsAPICall() async {
    //if (await Network.isConnected()) {
    try {
      //Map<String, dynamic> param = {
      //  'Key': 'value',
      //};

      var response = await DioClient().getQueryParam(AppURL.clockInOutTimeURL);

      if (response['code'] == 200 && response['status'] == true) {
        final data = response['data'];
        if (data != null && data is List && data.isNotEmpty) {
          final record = data[0];

          // Handle First_In_Time
          String firstInTime = record['First_In_Time']?.toString() ?? '';
          String lastOutTime = record['Last_Out_Time']?.toString() ?? '';

          // Calculate Duration
          if (firstInTime.isNotEmpty) {
            DateTime firstIn = DateTime.parse(firstInTime);
            DateTime lastOut = lastOutTime.isNotEmpty
                ? DateTime.parse(lastOutTime)
                : DateTime.now();

            // Calculate difference in hours and minutes
            Duration duration = lastOut.difference(firstIn);
            int hours = duration.inHours;
            int minutes = duration.inMinutes % 60;

            // Format duration as hh:mm
            workingHours.value =
                '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
          } else {
            // Default to '00:00' if First_In_Time is null
            workingHours.value = '00:00';
          }

          // Handle First_In_Time Display
          checkInTime.value = firstInTime.isNotEmpty
              ? AppDatePicker.convertDateTimeFormat(
                  firstInTime, Utils.commonUTCDateFormat, 'hh:mm a')
              : 'N/A';

          // Handle Last_Out_Time Display
          checkOutTime.value = lastOutTime.isNotEmpty
              ? AppDatePicker.convertDateTimeFormat(
                  lastOutTime, Utils.commonUTCDateFormat, 'hh:mm a')
              : 'N/A';
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: response['message']);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      //AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
    // } else {
    //   AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    // }
  }

  Future<void> fetchDashboardAttendanceHistoryAPICall() async {
    //if (await Network.isConnected()) {
    try {
      //Map<String, dynamic> param = {
      //  'Key': 'value',
      //};

      var response = await DioClient().getQueryParam(AppURL.dashboardURL);

      if (response['code'] == 200 && response['status'] == true) {
        final data = response['data']; // Keep this as Map<String, dynamic>
        if (data != null && data is Map<String, dynamic>) {
          address.value = data['employeeData']['location'].toString();
          presentDayValue.value =
              data['employeeCount']['present']?.toString() ?? '0';
          leaveDayValue.value =
              data['employeeCount']['leave']?.toString() ?? '0';
          absentDayValue.value =
              data['employeeCount']['absent']?.toString() ?? '0';
          onDutyDayValue.value = data['employeeCount']['od']?.toString() ?? '0';
          holidayDayValue.value =
              data['employeeCount']['ho']?.toString() ?? '0';
          weekOffDayValue.value =
              data['employeeCount']['wo']?.toString() ?? '0';

          if (presentDayValue.value.isNotEmpty &&
              leaveDayValue.value.isNotEmpty &&
              absentDayValue.value.isNotEmpty &&
              onDutyDayValue.value.isNotEmpty &&
              holidayDayValue.value.isNotEmpty &&
              weekOffDayValue.value.isNotEmpty) {
            statusData.value = [
              {
                'color': const Color(0XFF34A853),
                'icon': AppImages.dashPresentIcon,
                'name': presentDayLbl.value.toString(),
                'count': presentDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFEA4335),
                'icon': AppImages.dashLeaveIcon,
                'name': leaveDayLbl.value.toString(),
                'count': leaveDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFF68C1F),
                'icon': AppImages.dashAbsentIcon,
                'name': absentDayLbl.value.toString(),
                'count': absentDayValue.value.toString(),
              },
              {
                'color': const Color(0XFF4285F4),
                'icon': AppImages.dashOnDutyIcon,
                'name': onDutyDayLbl.value.toString(),
                'count': onDutyDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFAF84DD),
                'icon': AppImages.dashHolidayIcon,
                'name': holidayDayLbl.value.toString(),
                'count': holidayDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFAAAE01),
                'icon': AppImages.dashWeekOffIcon,
                'name': weekOffDayLbl.value.toString(),
                'count': weekOffDayValue.value.toString(),
              },
            ];
          }
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: response['message']);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      //AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
    // } else {
    //   AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    // }
  }

  //TODO : Location Logic
  String city = "";
  String area = "";
  String textPosition = "";

  final Battery _battery = Battery();

  List<List<double>> coordinates = [];
  List<LocationEntity> localGeoLocationList = [];

  late UltimatixDao localDao;
  late UltimatixDb database;

  RxString location = 'Fetching location...'.obs;

  Future<String> getBatteryPercentage() async {
    final level = await _battery.batteryLevel;
    return level.toString();
  }

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model.toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else {
      return 'Unknown Device';
    }
  }

  Future<void> initDatabase() async {
    database =
        await $FloorUltimatixDb.databaseBuilder('ultimatix_db.db').build();
    localDao = database.localDao;
  }

  void closeDb() async {
    await database.close();
  }

  void dataStore() {
    PreferenceUtils.setGeoLocations(coordinates);
    //Get Location
    //List<List<double>> coordinates = PreferenceUtils.getGeoLocations();
  }

  void syncAllGeoLocationRecord() async {
    if (localGeoLocationList.isNotEmpty) {
      for (var element in localGeoLocationList) {
        addGeoLocationByAPICall(element.latitude, element.longitude, 0.0);
      }
    }
  }

  Future<void> checkGpsEnabled() async {
    bool gpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!gpsEnabled) {
      Geolocator.openLocationSettings();
    }
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission != LocationPermission.always) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Allow location all time in permission');
      openAppSettings();
    }
  }

  Future<void> handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Location permissions are denied');
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      AppSnackBar.showGetXCustomSnackBar(
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      permission = await Geolocator.requestPermission();
    }
  }

  // Future<void> initializeService() async {
  //   await checkGpsEnabled();
  //
  //   final service = FlutterBackgroundService();
  //
  //   await service.configure(
  //       iosConfiguration: IosConfiguration(),
  //       androidConfiguration: AndroidConfiguration(
  //           onStart: onStartOne,
  //           isForegroundMode: true,
  //           autoStartOnBoot: true));
  //
  //   await service.startService();
  // }

  Future<void> getAllLocationRecords() async {
    if (localGeoLocationList.isNotEmpty) {
      localGeoLocationList.clear();
    }
    localGeoLocationList.addAll(await localDao.getAllRecordsFromDb());
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> address =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = address[0];
      city = place.locality.toString();
      area = place.subLocality.toString();
      textPosition =
          "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
    } catch (e) {
      e.printError();
    }
  }

  Future<void> syncGeolocationByAPICall(double lat, double lon) async {
    if (await Network.isConnected()) {
      try {
        await getAddress(lat, lon);

        Map<String, dynamic> param = {
          "empID": empID,
          "cmpID": cmpID,
          "latitude": lat,
          "longitude": lon,
          "addressLocation": textPosition.toString().trim(),
        };

        var response = await DioClient().post(AppURL.geoLocation, param);

        // if (response['code'] == 200 && response['status'] == true) {
        // }else if (response['code'] == 401) {
        //   AppSnackBar.showGetXCustomSnackBar(
        //       message: '${response['message']}',
        //       backgroundColor: AppColors.colorF45A42);
        // } else {
        //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        // }

        response.then(
          (value) {
            Map<String, dynamic> jsonResponse = value;
            if (jsonResponse['code'] == 200) {
            } else if (jsonResponse['code'] == 401) {
              AppSnackBar.showGetXCustomSnackBar(
                  message: '${jsonResponse['message']}',
                  backgroundColor: AppColors.colorF45A42);
            } else {
              debugPrint("Other status code");
            }
          },
        );
      } catch (e) {
        log(e.toString());
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> addGeoLocationByAPICall(
      double lat, double lon, double accuracy) async {
    if (await Network.isConnected()) {
      await getAddress(lat, lon);

      String gpsAcc = accuracy.toStringAsFixed(1).toString();
      String battery = await getBatteryPercentage();
      String deviceName = await getDeviceName();

      Map<String, dynamic> param = {
        "empID": empID,
        "cmpID": cmpID,
        // "empID": '28201',
        // "cmpID": '187',
        "latitude": lat,
        "longitude": lon,
        "trackingDate": DateFormat('dd/MM/yyyy').format(DateTime.now()),
        "address": textPosition.toString().trim(), // Fixed here
        "city": city.toString().trim(),
        "area": area.toString().trim(),
        "battery": "$battery%",
        "gps": "$gpsAcc Meters",
        "imei": PreferenceUtils.getDeviceID(),
        "modelName": deviceName
      };

      var response = await DioClient().post(AppURL.addLocations, param);

      // if (response['code'] == 200 && response['status'] == true) {
      // }else if (response['code'] == 401) {
      //   AppSnackBar.showGetXCustomSnackBar(
      //       message: '${response['message']}',
      //       backgroundColor: AppColors.colorF45A42);
      // } else {
      //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
      // }

      response.then(
        (value) {
          Map<String, dynamic> jsonResponse = value;
          if (jsonResponse['code'] == 200) {
          } else if (jsonResponse['code'] == 401) {
            AppSnackBar.showGetXCustomSnackBar(
                message: '${jsonResponse['message']}',
                backgroundColor: AppColors.colorF45A42);
          } else {
            debugPrint("Other status code");
          }
        },
      );
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (!status.isGranted) {
      // Request permission
      await Permission.location.request();
    }

    // If permission is permanently denied, open the settings
    if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location.value = 'Location services are disabled.';

      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        location.value = 'Location permissions are denied.';

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location.value = 'Location permissions are permanently denied.';

      return;
    }

    // If permission is granted, get the location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high, // Use LocationSettings for accuracy
      //distanceFilter:
      //100, // Optional: minimum distance (in meters) to move before updates
    ));

    location.value =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
  }
}

/*final _viewModelController = Get.put(DashboardController());
late Timer timer;

@pragma('vm:entry-point')
void onStartOne(ServiceInstance service) async {
  log("OnStart Method");

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
      log("**Service set As Foreground**");
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
      log("**Service set As Background**");
    });

    service.on('stopService').listen((event) async {
      timer.cancel();
      service.stopSelf();
      log("**Service is stop**");
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Locate ME", content: "Updated at${DateTime.now()}");
        try {
          insertDataToStorage();
        } catch (e) {
          e.printError(info: "Getting Error while collecting locations");
        }
      }
    });
  }
}

void insertDataToStorage() async {
  LocationPermission permission = await Geolocator.checkPermission();
  bool gpsEnabled = await Geolocator.isLocationServiceEnabled();

  if (permission != LocationPermission.always || !gpsEnabled) {
    _viewModelController.checkGpsEnabled();
  } else {
    if (await Network.isConnected()) {
      // await Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.high)
      //     .then(
      //   (value) {
      //     _viewModelController.addGeoLocationByAPICall(
      //         value.latitude, value.longitude, value.accuracy);
      //   },
      // );

      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high, // Use LocationSettings for accuracy
          distanceFilter:
              100, // Optional: minimum distance (in meters) to move before updates
        ),
      ).then(
        (value) {
          _viewModelController.addGeoLocationByAPICall(
            value.latitude,
            value.longitude,
            value.accuracy,
          );
        },
      );
    } else {
      // await Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.best)
      //     .then(
      //   (value) {
      //     _viewModelController.localDao.insertLocations(LocationEntity(latitude: value.latitude, longitude: value.longitude, dateTime: DateTime.now().toString(), gpsOff: false));
      //   },
      // );

      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high, // Use LocationSettings for accuracy
          distanceFilter:
              100, // Optional: minimum distance (in meters) to move before updates
        ),
      ).then(
        (value) {
          _viewModelController.localDao.insertLocations(LocationEntity(
              latitude: value.latitude,
              longitude: value.longitude,
              dateTime: DateTime.now().toString(),
              gpsOff: false));
        },
      );
    }
  }
}*/
