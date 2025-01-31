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
        if (PreferenceUtils.getIsLogin()) {
          Get.offAllNamed(AppRoutes.dashBoardRoute);
        } else {
          Get.offAllNamed(AppRoutes.serverRoute);

          // if (PreferenceUtils.getServerConnection().isEmpty) {
          //   Get.offAllNamed(AppRoutes.serverRoute);
          // } else {
          //   Get.offAllNamed(AppRoutes.loginRoute);
          // }
        }
      },
    );
  }

  void checkLocationEnabled() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
  }
}
