import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

import '../../app/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        if (PreferenceUtils.getIsLogin()) {
          if(!PreferenceUtils.getIsLocateMe()) {
            Get.offAllNamed(AppRoutes.locationPermRoute);
          }else{
            Get.offAllNamed(AppRoutes.dashBoardRoute);
          }
        } else {
          goToNext();

          // if (PreferenceUtils.getServerConnection().isEmpty) {
          //   Get.offAllNamed(AppRoutes.serverRoute);
          // } else {
          //   Get.offAllNamed(AppRoutes.loginRoute);
          // }
        }
      },
    );
  }

  void goToNext() {
    if(PreferenceUtils.getIsLocateMe()) {
      Get.offAllNamed(AppRoutes.serverRoute);
    }else{
      Get.offAllNamed(AppRoutes.locationPermRoute);
    }
  }
}
