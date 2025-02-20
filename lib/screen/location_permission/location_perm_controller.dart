import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import '../../app/app_routes.dart';

class LocationPermController extends GetxController {

  @override
  void onInit() async{
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    super.onInit();
  }

  Future<void> checkGpsEnabled() async {
    try {
      checkLocationPermission();
      bool gpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!gpsEnabled) {
        Geolocator.openLocationSettings();
      }
    }catch(e){
      e.printError();
    }
  }

  Future<void> checkLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission != LocationPermission.always) {
        openAppSettings();
      } else {
        await PreferenceUtils.setIsLocateMe(true);
        if(!PreferenceUtils.getIsLogin()) {
          Get.offAllNamed(AppRoutes.serverRoute);
        }else{
          Get.offAllNamed(AppRoutes.dashBoardRoute);
        }
      }
    }catch(e){
      e.printError();
    }
  }
}