import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/services/notification_services.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

class LoginController extends GetxController {
  final NotificationServices notificationServices = NotificationServices();

  var isLoading = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    notificationServices.getDeviceToken().then((value) => {
          PreferenceUtils.setFCMId(value),
        });
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'UserName': username,
          'Password': password,
        };

        var response = await DioClient().post(AppURL.loginURL, param);
        if (response['StatusCode'] == 200 && response['Status'] == 'OK') {
          AppSnackBar.showGetXCustomSnackBar(
              message: response['Message'],
              backgroundColor: AppColors.colorGreen);
          Get.offAllNamed('/dash_board_route');
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['Message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
