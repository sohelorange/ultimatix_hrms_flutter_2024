import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

import '../../app/app_routes.dart';

class SplashController extends GetxController {
  bool serviceEnabled = false;

  @override
  void onInit() {
    super.onInit();
    checkLocationEnabled();

    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        Get.offAllNamed(AppRoutes.clockInOutRoute);

        /*if (PreferenceUtils.getIsLogin()) {
          if (kDebugMode) {
            print('dashboard page');
          }
          //Get.offAllNamed(AppRoutes.dashBoardRoute);
        } else {
          if (kDebugMode) {
            print('login redirect');
          }
          Get.offAllNamed(AppRoutes.loginRoute);
        }*/
      },
    );
  }

  void checkLocationEnabled() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
  }
}
