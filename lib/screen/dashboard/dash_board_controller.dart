import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ultimatix_hrms_flutter/app/app_time_format.dart';
import 'package:ultimatix_hrms_flutter/database/database_helper.dart';
import 'package:ultimatix_hrms_flutter/database/ultimatix_dao.dart';
import 'package:ultimatix_hrms_flutter/database/ultimatix_db.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/manager_approval_model.dart';
import 'package:ultimatix_hrms_flutter/widget/common_material_dialog.dart';

import '../../api/dio_client.dart';
import '../../app/app_colors.dart';
import '../../app/app_date_format.dart';
import '../../app/app_images.dart';
import '../../app/app_routes.dart';
import '../../app/app_snack_bar.dart';
import '../../app/app_url.dart';
import '../../database/clock_response.dart';
import '../../database/location_entity.dart';
import '../../services/notification_services.dart';
import '../../utility/constants.dart';
import '../../utility/network.dart';
import '../../utility/preference_utils.dart';
import '../../utility/utils.dart';

class DashController extends GetxController {
  late UltimatixDao localDao;
  late UltimatixDb database;

  RxBool isLoading = false.obs;
  RxBool isViewMore = false.obs;

  RxString address = ''.obs;
  RxString checkInTime = "--:--".obs;
  RxString checkOutTime = "--:--".obs;
  RxString workingHours = "00:00".obs;
  RxString nDate = "Friday,Oct 15,2024".obs;

  RxInt selectedIndex = 0.obs;

  final NotificationServices _notificationServices = NotificationServices();

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
  RxString todayDayDate = "".obs;

  RxString currentMonthYear = "".obs;
  RxString userImageUrl = "".obs;
  RxString cmpImageUrl = "".obs;
  RxString userName = "".obs;
  RxString empID = "".obs;
  RxString cmpID = "".obs;

  int isGeofenceEnable = 0;

  RxList<Map<String, dynamic>> attendanceStatusData =
      <Map<String, dynamic>>[].obs;

  final List<String> bannerListData = [
    "https://www.shutterstock.com/image-vector/happy-diwali-celebration-background-festival-600nw-2523970115.jpg",
    "https://t3.ftcdn.net/jpg/08/95/86/82/360_F_895868299_z8aR16uHjnkrtnUkzohVQ68m26JBNt4f.jpg",
    "https://media.istockphoto.com/id/1774494924/photo/sister-applying-tilaka-to-her-brother-at-home-during-bhai-dooj.jpg?s=612x612&w=0&k=20&c=z2nNx7asAdglLCBIhJwy3JV2qwDVMT5AAyfxrJ5r_XU=",
  ];

  //Tracking Related Field
  late Timer? timer1;
  final Battery _battery = Battery();
  List<List<double>> coordinates = [];
  List<LocationEntity> localGeoLocationList = [];
  RxString textPosition = "".obs;
  String city = "";
  String area = "";
  String imeiNo = "";

  ValueNotifier<bool> checkInOutStatus = ValueNotifier<bool>(false);
  ValueNotifier<String> profileValueNotifier = ValueNotifier<String>('');
  ValueNotifier<String> nameValueNotifier = ValueNotifier<String>('');
  ValueNotifier<String> designationValueNotifier = ValueNotifier<String>('');

  RxString lstClockingDate = ''.obs;
  RxString lstClockingTime = ''.obs;
  RxString leaveApprovalCount = "0".obs;
  RxString attendanceCount = "0".obs;
  RxString leaveCancelCount = "0".obs;
  RxString currentTime = AppTimePicker.currentTime12().obs;
  late Timer _timer;

  RxBool isLogoutLoading = false.obs;
  RxBool isDisable = false.obs;

  Rx<ManagerApprovalModel> leaveManagerApprovalResponse =
      ManagerApprovalModel().obs;

  //TODO : Bottom-sheet Menu Tab
  final List<Map<String, dynamic>> exploreItems = [
    {
      'id': 1,
      'icon': AppImages.exploreClockingIcon,
      'name': 'Clocking',
      'visible': true,
      'boxColor': const Color(0XFFE8FFF7),
    },
    {
      'id': 2,
      'icon': AppImages.exploreLeaveIcon,
      'name': 'Leaves',
      'visible': true,
      'boxColor': const Color(0XFFF1EBFB),
    },
    {
      'id': 3,
      'icon': AppImages.exploreAttendanceIcon,
      'name': 'Attendance',
      'visible': true,
      'boxColor': const Color(0XFFFFF2F2),
    },
    {
      'id': 4,
      'icon': AppImages.exploreChangeReqIcon,
      'name': 'Change\nRequest',
      'visible': true,
      'boxColor': const Color(0XFFEAF8FF),
    },
    {
      'id': 5,
      'icon': AppImages.exploreTravelIcon,
      'name': 'Travel',
      'visible': true,
      'boxColor': const Color(0XFFFFEEFD),
    },
    {
      'id': 6,
      'icon': AppImages.exploreMedicalIcon,
      'name': 'Medical',
      'visible': true,
      'boxColor': const Color(0XFFFDFCED),
    },
    {
      'id': 7,
      'icon': AppImages.exploreGrievanceIcon,
      'name': 'Grievance',
      'visible': true,
      'boxColor': const Color(0XFFE8FFF7),
    },
    {
      'id': 8,
      'icon': AppImages.exploreCanteenIcon,
      'name': 'Canteen',
      'visible': true,
      'boxColor': const Color(0XFFF1EBFB),
    },
    {
      'id': 9,
      'icon': AppImages.exploreCRMIcon,
      'name': 'CRM',
      'visible': true,
      'boxColor': const Color(0XFFFFF2F2),
    },
    {
      'id': 10,
      'icon': AppImages.exploreTicketAppIcon,
      'name': 'Ticket\nApplication',
      'visible': true,
      'boxColor': const Color(0XFFEAF8FF),
    },
    {
      'id': 11,
      'icon': AppImages.exploreClaimIcon,
      'name': 'Claim',
      'visible': true,
      'boxColor': const Color(0XFFFFEEFD),
    },
    {
      'id': 12,
      'icon': AppImages.exploreExitAppIcon,
      'name': 'Exit\nApplication',
      'visible': true,
      'boxColor': const Color(0XFFFDFCED),
    },
    {
      'id': 13,
      'icon': AppImages.explorePhotoGalleryIcon,
      'name': 'Photo Gallery',
      'visible': true,
      'boxColor': const Color(0XFFE8FFF7),
    },
    {
      'id': 14,
      'icon': AppImages.exploreBirthdayIcon,
      'name': 'Birthday &\nAnniversary',
      'visible': true,
      'boxColor': const Color(0XFFF1EBFB),
    }
  ];

  final RxInt selectedExploreIndex = 0.obs;

  void _updateTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = AppTimePicker.currentTime12();
    });
  }

  void onBottomTabSelected(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.dashBoardRoute);
        break;
      case 1:
        //Get.toNamed(AppRoutes.settingsRoute);
        break;
      case 2:
        Get.toNamed(AppRoutes.attendanceMainRoute);
        break;
      case 3:
        Get.toNamed(AppRoutes.leaveApplicationRoute);
        break;
    }
  }

  void onDrawerTabSelected(int index) {
    switch (index) {
      case 0:
        Get.back();
        //Get.toNamed(AppRoutes.managerApprovalRoute);
        break;
      case 1:
        Get.back();
        break;
      case 2:
        Get.back();
        //Get.toNamed(AppRoutes.liveTrackingRoute);
        Get.toNamed(AppRoutes.liveTrackingRoute, arguments: [
          {
            "username": userName.value,
            "empId": int.parse(empID.value),
            "cmpId": int.parse(cmpID.value),
            "userImage": userImageUrl.value
          }
        ]);
        break;
      case 3:
        Get.back();
        break;
      case 4:
        Get.back();
        break;
      case 5:
        Get.back();
        break;
      case 6:
        Get.back();
        //Get.toNamed(AppRoutes.settingsRoute);
        break;
      case 7:
        Get.back();
        Get.dialog(CommonMaterialDialog(
          title: 'Logout',
          message: 'Are you sure you want to\nsign out?',
          yesButtonText: 'Yes',
          noButtonText: 'No',
          onConfirm: () {
            logout();
            // PreferenceUtils.setIsLogin(false).then((_) {
            //   Get.offAllNamed(AppRoutes.loginRoute);
            // });
          },
          onCancel: () {
            Get.back();
          },
          isLoading: isLogoutLoading,
        ));

        break;
    }
  }

  void handleMenuNavigation(int index) {
    // Retrieve the selected item dynamically based on index
    final selectedItem = exploreItems[index];

    // Use 'id' to handle navigation dynamically
    switch (selectedItem['id']) {
      case 1: // Clocking
        if (isGeofenceEnable == 1) {
          Get.toNamed(AppRoutes.geofenceRoute);
        } else {
          Get.toNamed(AppRoutes.clockInRoute);
        }
        break;
      case 2: // Leaves
        //Get.toNamed(AppRoutes.leaveApplicationRoute);
        break;
      case 3: // Attendance
        //Get.toNamed(AppRoutes.attendanceMainRoute);
        break;
      case 4: // Change Request
        break;
      case 5: // Travel
        break;
      case 6: // Medical
        break;
      case 7: // Grievance
        break;
      case 8: // Canteen
        break;
      case 9: // CRM
        break;
      case 10: // Ticket Application
        break;
      case 11: // Claim
        break;
      case 12: // Exit Application
        break;
      case 13: // Photo Gallery
        break;
      case 14: // Birthday & Anniversary
        break;
      default:
        AppSnackBar.showGetXCustomSnackBar(
            message: 'This feature is under development.');
    }
  }

  @override
  onInit() async {
    super.onInit();
    _updateTime();
    checkInOutStatus.value = PreferenceUtils.getIsClocking();

    _notificationServices.requestNotificationPermission();
    _notificationServices.firebaseInit(Get.context!);
    _notificationServices.setUpInterMsg(Get.context!);

    await getLoginDetails();
    await fetchDataInParallel();
    /*await initDatabase();*/

    imeiNo = await getImeiNo() ?? "";
    todayDayDate.value = getTodayFormattedDate();

    currentMonthYear.value =
        "My Attendance - Since ${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}";
  }

  @override
  void dispose() {
    _timer.cancel();
    timer1?.cancel();
    super.dispose();
  }

  //TODO: dashboard normal field
  String getTodayFormattedDate() {
    DateTime now = DateTime.now();
    //String formattedDate = DateFormat("E, MMM d, yyyy").format(now);//Short Name Day
    String formattedDate =
        DateFormat("EEEE, MMM d, yyyy").format(now); // Full Name Day
    return formattedDate;
  }

  Future<void> getLoginDetails() async {
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    userImageUrl.value = loginData['image_Name'] ?? '';
    cmpImageUrl.value = loginData['cmp_Logo'] ?? '';
    userName.value = loginData['emp_Sort_Name'] ?? '';
    empID.value = loginData['emp_ID'].toString();
    cmpID.value = loginData['cmp_ID'].toString();
    isGeofenceEnable = loginData['is_Geofence_enable'] ?? 0;

    profileValueNotifier.value = userImageUrl.value;
    nameValueNotifier.value = userName.value;
    designationValueNotifier.value = loginData['desig_Name'].toString();
  }

  Future<void> fetchDataInParallel() async {
    if (await Network.isConnected()) {
      try {
        isLoading(true);
        await Future.wait([
          fetchDashboardAttendanceHistoryAPICall(),
          //fetchDashboardPresentDetailsAPICall(),
          fetchManagerApprovalCountAPI(),
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

  Future<void> fetchDashboardAttendanceHistoryAPICall() async {
    try {
      var response = await DioClient().getQueryParam(AppURL.dashboardURL);

      if (response['code'] == 200 && response['status'] == true) {
        final data = response['data']; // Keep this as Map<String, dynamic>
        if (data != null && data is Map<String, dynamic>) {
          lstClockingDate.value = AppDatePicker.convertDateTimeFormat(
              data['employeeData']['iO_Datetime'].toString(),
              Utils.commonUTCDateFormat,
              'EEE, MMM dd, yyyy');
          lstClockingTime.value = AppDatePicker.convertDateTimeFormat(
              data['employeeData']['iO_Datetime'].toString(),
              Utils.commonUTCDateFormat,
              'hh:mm a');
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
            attendanceStatusData.value = [
              {
                'color': const Color(0XFFE8FFF7),
                'icon': AppImages.dashPresentIcon,
                'name': presentDayLbl.value.toString(),
                'count': presentDayValue.value.toString(),
              },
              {
                'color': AppColors.colorF1EBFB,
                'icon': AppImages.dashLeaveIcon,
                'name': leaveDayLbl.value.toString(),
                'count': leaveDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFFFF2F2),
                'icon': AppImages.dashAbsentIcon,
                'name': absentDayLbl.value.toString(),
                'count': absentDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFEAF8FF),
                'icon': AppImages.dashOnDutyIcon,
                'name': onDutyDayLbl.value.toString(),
                'count': onDutyDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFFFEEFD),
                'icon': AppImages.dashHolidayIcon,
                'name': holidayDayLbl.value.toString(),
                'count': holidayDayValue.value.toString(),
              },
              {
                'color': const Color(0XFFFDFCED),
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
    }
  }

  Future<void> fetchDashboardPresentDetailsAPICall() async {
    try {
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
        if (response['code'] != 204 && response['status'] == false) {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        } else {
          //Empty
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void setDataToUi(ClockResponse response) {
    checkInTime.value = extractTime(response.data?.elementAt(0).firstInTime);
    checkOutTime.value = extractTime(response.data?.elementAt(0).lastOutTime);
    workingHours.value = response.data!.elementAt(0).duration!.trim();
    nDate.value = extractDate(response.data!.elementAt(0).forDate);
    isLoading.value = false;
  }

  String extractTime(String? firstInTime) {
    if (firstInTime != null) {
      String dateTimeString = firstInTime;
      DateTime dateTime = DateTime.parse(dateTimeString);
      String timeString = dateTime.toLocal().toString().split(' ')[1];
      return timeString.replaceAll('.000', '');
    } else {
      return "--:--";
    }
  }

  String extractDate(String? date) {
    if (date != null) {
      String dateTimeString = date;
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('EEE, MMM dd, yyyy').format(dateTime);
    } else {
      return "00:00";
    }
  }

  Future<void> fetchManagerApprovalCountAPI() async {
    try {
      var response =
          await DioClient().getQueryParam(AppURL.managerApprovalCount);

      leaveManagerApprovalResponse.value =
          ManagerApprovalModel.fromJson(response);
      if (leaveManagerApprovalResponse.value.code == 200 &&
          leaveManagerApprovalResponse.value.status == true) {
        leaveApprovalCount.value =
            leaveManagerApprovalResponse.value.data!.leaveAppCnt.toString();
        attendanceCount.value =
            leaveManagerApprovalResponse.value.data!.lateComer.toString();
        leaveCancelCount.value =
            leaveManagerApprovalResponse.value.data!.leaveCancel.toString();
        debugPrint(
            "leave manger approval balance --${leaveManagerApprovalResponse.value.data}");
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${leaveManagerApprovalResponse.value.message}");
      }
    } catch (e) {
      //AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      isLogoutLoading.value = true;
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'loginToken':
              PreferenceUtils.getAuthToken().replaceAll('Bearer ', '').trim(),
        };

        var response =
            await DioClient().postQuery(AppURL.logoutURL, queryParams: param);
        if (response['code'] == 200 && response['status'] == true) {
          deleteRecord();
          deleteAllLocations();

          PreferenceUtils.setIsLogin(false).then((_) {
            closeDb();
            Get.offAllNamed(AppRoutes.loginRoute);
          });

          AppSnackBar.showGetXCustomSnackBar(
              message: response['message'], backgroundColor: Colors.green);
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isLogoutLoading.value = false;
      isDisable(false);
    }
  }

  //TODO: dashboard use for live tracking field
  Future<void> initDatabase() async {
    localDao = await DatabaseHelper.localDao;
    await getAllLocationRecords().then(
      (value) {
        syncAllGeoLocationRecord();
      },
    );
    await initializeService();
  }

  closeDb() async {
    await database.close();
  }

  void deleteRecord() async {
    await localDao.deleteAllRecords();
  }

  void deleteAllLocations() async {
    await localDao.deleteAllLocations();
  }

  Future<String> getBatteryPercentage() async {
    final level = await _battery.batteryLevel;
    return level.toString();
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

  Future<void> initializeService() async {
    await checkGpsEnabled();
    final service = FlutterBackgroundService();

    await service.configure(
        iosConfiguration: IosConfiguration(),
        androidConfiguration: AndroidConfiguration(
            onStart: onStartOne,
            isForegroundMode: true,
            autoStartOnBoot: true));

    await service.startService();
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

  Future<void> getAllLocationRecords() async {
    if (localGeoLocationList.isNotEmpty) {
      localGeoLocationList.clear();
    }
    localGeoLocationList.addAll(await localDao.getAllRecordsFromDb());
  }

  void syncAllGeoLocationRecord() async {
    if (localGeoLocationList.isNotEmpty) {
      for (var element in localGeoLocationList) {
        addGeoLocationByAPICall(element.latitude, element.longitude, 0.0);
      }
    }
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> address =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = address[0];
      city = place.locality.toString();
      area = place.subLocality.toString();
      textPosition.value =
          "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
    } catch (e) {
      e.printError();
    }
  }

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model.toString();
  }

  Future<String?> getImeiNo() async {
    return ""; /*await UniqueIdentifier.serial;*/
  }

  Future<void> addGeoLocationByAPICall(
      double lat, double lon, double accuracy) async {
    if (await Network.isConnected()) {
      await getAddress(lat, lon);
      await PreferenceUtils.init();

      String gpsAcc = accuracy.toStringAsFixed(1).toString();
      String battery = await getBatteryPercentage();
      String deviceName = await getDeviceName();

      Map<String, dynamic> param = {
        "empID": 0,
        "cmpID": 0,
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

      await DioClient().post(AppURL.addLocations, param).then(
        (value) {
          if (value != null) {
            Map<String, dynamic> jsonResponse = value;
            if (jsonResponse['code'] == 200) {
              log("successfully data stored for location");
            } else if (jsonResponse['code'] == 401) {
              AppSnackBar.showGetXCustomSnackBar(
                  message: '${jsonResponse['message']}',
                  backgroundColor: AppColors.colorF45A42);
            } else {
              debugPrint("Other status code");
            }
          }
        },
      );
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }
}

final _viewModelController = Get.put(DashController());

late Timer timer;

@pragma('vm:entry-point')
void onStartOne(ServiceInstance service) async {
  log("OnStart Method");
  DartPluginRegistrant.ensureInitialized();

  /*_viewModelController.initDatabase();*/

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
      log("Service running****");
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
      await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best, // Use LocationSettings for accuracy
        //distanceFilter:
        //100, // Optional: minimum distance (in meters) to move before updates
      )).then(
        (value) {
          _viewModelController.addGeoLocationByAPICall(
              value.latitude, value.longitude, value.accuracy);
        },
      );
    } else {
      await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best, // Use LocationSettings for accuracy
        //distanceFilter:
        //100, // Optional: minimum distance (in meters) to move before updates
      )).then(
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
}
