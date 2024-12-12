import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';

import '../../../api/dio_client.dart';
import '../../../app/app_snack_bar.dart';
import '../../../utility/constants.dart';
import '../../../utility/network.dart';

class ForgotPassController extends GetxController {
  var isLoading = false.obs;
  var isDisable = false.obs;

  Rx<TextEditingController> forgotPassController = TextEditingController().obs;

  FocusNode forgotPassFocus = FocusNode();

  @override
  void dispose() {
    forgotPassController.value.dispose();
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

  void forgotPassValidationWithAPI() {
    if (forgotPassController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter login ID.');
    } else {
      forgotPass(forgotPassController.value.text);
    }
  }
}
