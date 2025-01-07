import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../../../api/dio_client.dart';
import '../../../app/app_snack_bar.dart';
import '../../../utility/constants.dart';
import '../../../utility/network.dart';

class ForgotPassController extends GetxController {
  var isLoading = false.obs;
  var isDisable = false.obs;

  var isForgotPass = true.obs;
  var isVerifyOTP = false.obs;
  var isResetPass = false.obs;

  RxInt verifyOTP = 0.obs;
  Rx<TextEditingController> forgotPassController = TextEditingController().obs;
  Rx<TextEditingController> newPassController = TextEditingController().obs;
  Rx<TextEditingController> confirmPassController = TextEditingController().obs;

  FocusNode forgotPassFocus = FocusNode();
  FocusNode newPassFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();

  @override
  void dispose() {
    forgotPassController.value.dispose();
    newPassController.value.dispose();
    confirmPassController.value.dispose();
    super.dispose();
  }

  Future<void> forgotPass(String strUserName) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'UserName': strUserName,
        };

        String forgotPassURL =
            "${AppURL.forgotPassWordURL}?UserName=${param["UserName"]}";

        var response = await DioClient().post(forgotPassURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          isForgotPass.value = false;
          isVerifyOTP.value = true;
          isResetPass.value = false;
          Utils.closeKeyboard(Get.context!);
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

  void forgotPassValidationWithAPI() {
    if (forgotPassController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter login ID.');
    } else {
      forgotPass(forgotPassController.value.text);
    }
  }

  Future<void> verifyPass(String strUserName, int otpCode) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'UserName': strUserName,
          'OtpCode': otpCode,
        };

        String verifyOTPURL =
            "${AppURL.otpVerificationURL}?UserName=${param["UserName"]}&OtpCode=${param["OtpCode"]}";

        var response = await DioClient().post(verifyOTPURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          isForgotPass.value = false;
          isVerifyOTP.value = false;
          isResetPass.value = true;
          Utils.closeKeyboard(Get.context!);
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

  void verifyOTPValidationWithAPI() {
    String otpString = verifyOTP.value.toString();

    if (otpString.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Please enter 4-digit passcode.',
      );
    } else if (otpString.length != 4) {
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Please enter a valid 4-digit passcode.',
      );
    } else {
      verifyPass(forgotPassController.value.text, verifyOTP.value);
    }
  }

  Future<void> resetPass(String userName, String newPass) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'userName': userName,
          'oldPassword': '',
          'newPassword': newPass,
        };

        var response = await DioClient().post(AppURL.resetPasswordURL, param);
        if (response['code'] == 200 && response['status'] == true) {
          Utils.closeKeyboard(Get.context!);
          Get.back();
          AppSnackBar.showGetXCustomSnackBar(
              message: response['message'], backgroundColor: Colors.green);
        } else {
          if (response['code'] == 204 && response['status'] == false) {
            AppSnackBar.showGetXCustomSnackBar(
                message:
                    response['data'].toString().replaceAll('#False#', '.'));
          } else {
            //AppSnackBar.showGetXCustomSnackBar(message: response['message']);
            AppSnackBar.showGetXCustomSnackBar(
                message:
                    response['data'].toString().replaceAll('#False#', '.'));
          }
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

  void resetPassValidationWithAPI() {
    if (newPassController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter new password.');
    } else if (confirmPassController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please enter confirm password.');
    } else if (newPassController.value.text !=
        confirmPassController.value.text) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Confirm password & New password does not match.');
    } else {
      resetPass(
        forgotPassController.value.text,
        newPassController.value.text,
      );
    }
  }
}
