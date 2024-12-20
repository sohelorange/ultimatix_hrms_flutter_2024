import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/services/notification_services.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../../utility/network.dart';

class LoginController extends GetxController {
  final NotificationServices notificationServices = NotificationServices();

  var isLoading = false.obs;
  var isDisable = false.obs;

  var token = ''.obs;

  Rx<TextEditingController> serverConnectionController =
      TextEditingController().obs;
  Rx<TextEditingController> loginIDController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  FocusNode serverConnectionFocus = FocusNode();
  FocusNode loginIDFocus = FocusNode();
  FocusNode passWordFocus = FocusNode();

  RxBool isShowHide = false.obs;
  RxBool isRememberCheck = false.obs;

  RxString strIdentifier = 'Unknown'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    deviceID();

    if (PreferenceUtils.getServerConnection().isNotEmpty) {
      isShowHide.value = true;
      serverConnectionController.value.text =
          PreferenceUtils.getServerConnection();
    }

    if (PreferenceUtils.getIsRemember()) {
      isRememberCheck.value = PreferenceUtils.getIsRemember();
      loginIDController.value.text = PreferenceUtils.getLoginUserID();
      passwordController.value.text = PreferenceUtils.getLoginUserPassword();
    }

    notificationServices.getDeviceToken().then((value) => {
          PreferenceUtils.setFCMId(value),
        });
  }

  @override
  void dispose() {
    passwordController.value.dispose();
    loginIDController.value.dispose();
    serverConnectionController.value.dispose();
    super.dispose();
  }

  Future<void> deviceID() async {
    String? identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    strIdentifier.value = identifier!;
    PreferenceUtils.setDeviceID(strIdentifier.value);
    if (kDebugMode) {
      print("Uniq ID : ${strIdentifier.value}");
    }
  }

  Future<void> serverConnection(String strServerConnection) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'strCode': strServerConnection,
        };

        String serverURL =
            "${AppURL.serverConnectionURL}?strCode=${param["strCode"]}";

        var response = await DioClient().post(serverURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          isShowHide.value = true;
          PreferenceUtils.setServerConnection(
              serverConnectionController.value.text);
          PreferenceUtils.setAppUrl(response['data']);
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
      isLoading(false);
      isDisable(false);
    }
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'userName': username,
          'password': password,
          'imeiNo': '',
          'deviceID': PreferenceUtils.getDeviceID(),
        };

        var response = await DioClient().post(AppURL.loginURL, param);
        if (response['code'] == 200 && response['status'] == true) {
          PreferenceUtils.setAuthToken('Bearer ${response['data']['token']}');
          PreferenceUtils.setLoginDetails(response['data']['loginData']);
          PreferenceUtils.setDetails(response['data']['details']);

          print('Token :' + PreferenceUtils.getAuthToken());
          PreferenceUtils.setIsLogin(true);
          print('Login Check' + PreferenceUtils.getIsLogin().toString());

          //print('loginData :' + PreferenceUtils.getLoginDetails().toString());
          //print('details :' + PreferenceUtils.getDetails().toString());

          AppSnackBar.showGetXCustomSnackBar(
              message: response['message'],
              backgroundColor: AppColors.colorGreen);

          Get.offAllNamed('/dash_board_route');
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isLoading(false);
      isDisable(false);
    }
  }

  void serverConnectionValidationWithAPI() {
    if (serverConnectionController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter server name.');
    } else {
      serverConnection(serverConnectionController.value.text);
    }
  }

  void loginValidationWithAPI() {
    if (loginIDController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter login ID.');
    } else if (passwordController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter password.');
    } else {
      login(loginIDController.value.text, passwordController.value.text);
    }
  }
}
