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

import '../../../app/app_routes.dart';
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
  RxBool isObscured = true.obs;

  RxString strIdentifier = 'Unknown'.obs;

  final NotificationServices _notificationServices = NotificationServices();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _notificationServices.requestNotificationPermission();
    _notificationServices.firebaseInit(Get.context!);
    _notificationServices.setUpInterMsg(Get.context!);
    //notificationServices.isTokenRefresh();
    _notificationServices.getDeviceToken().then((value) => {
          // ignore: avoid_print
          print('Device Token $value')
        });

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

  void toggleObscured() {
    isObscured.value = !isObscured.value;
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
          'imeiNo': PreferenceUtils.getDeviceID(),
          'deviceID': PreferenceUtils.getFCMId(),
        };

        var response = await DioClient().post(AppURL.loginURL, param);
        if (response['code'] == 200 && response['status'] == true) {
          PreferenceUtils.setLoginUserID(loginIDController.value.text);
          PreferenceUtils.setLoginUserPassword(passwordController.value.text);

          PreferenceUtils.setAuthToken('Bearer ${response['data']['token']}');

          if (response['data']['loginData'] is Map<String, dynamic>) {
            await PreferenceUtils.setLoginDetails(
                response['data']['loginData']);
          }
          //TODO : Get MAP DATA
          Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();

          if (response['data']['details'] is List<dynamic>) {
            await PreferenceUtils.setDetails(response['data']['details']);
          }
          //TODO : Get List DATA
          List<dynamic> details = PreferenceUtils.getDetails();

          if (loginData.isNotEmpty && details.isNotEmpty) {
            PreferenceUtils.setIsLogin(true).then((_) {
              Get.offAllNamed(AppRoutes.dashBoardRoute);
              AppSnackBar.showGetXCustomSnackBar(
                  message: response['message'],
                  backgroundColor: AppColors.colorGreen);
            });
          }
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
