import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../../../api/dio_client.dart';
import '../../../app/app_snack_bar.dart';
import '../../../app/app_url.dart';
import '../../../utility/constants.dart';
import '../../../utility/network.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;
  var isDisable = false.obs;

  RxBool isCurrentPass = true.obs;
  Rx<TextEditingController> currentPasswordController =
      TextEditingController().obs;
  FocusNode currentPassWordFocus = FocusNode();

  RxBool isChangePass = true.obs;
  Rx<TextEditingController> changePasswordController =
      TextEditingController().obs;
  FocusNode changePassWordFocus = FocusNode();

  RxBool isConfirmPass = true.obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  FocusNode confirmPassWordFocus = FocusNode();

  void currentPassObscured() {
    isCurrentPass.value = !isCurrentPass.value;
  }

  void changePassObscured() {
    isChangePass.value = !isChangePass.value;
  }

  void confirmPassObscured() {
    isConfirmPass.value = !isConfirmPass.value;
  }

  void changePasswordWithAPI() {
    if (currentPasswordController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please current password.');
    } else if (changePasswordController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please enter change password.');
    } else if (confirmPasswordController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please enter confirm password.');
    } else if (changePasswordController.value.text !=
        confirmPasswordController.value.text) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Confirm password & Change Password does not same.');
    } else {
      changePassword(
          currentPasswordController.value.text,
          changePasswordController.value.text,
          confirmPasswordController.value.text);
    }
  }

  Future<void> changePassword(
      String currentPass, String changePass, String confirmPass) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'userName': currentPass,
          'newPassword': changePass,
          'confirmPassword': confirmPass,
        };

        var response = await DioClient().post(AppURL.changePassURL, param);
        if (response['code'] == 200 && response['status'] == true) {
          Utils.closeKeyboard(Get.context!);
          Get.back();
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
}
