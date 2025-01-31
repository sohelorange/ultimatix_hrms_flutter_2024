import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';

class ServerConnectionController extends GetxController {
  Rx<TextEditingController> serverConnectionController =
      TextEditingController().obs;
  FocusNode serverFocus = FocusNode();

  var isLoading = false.obs;
  var isDisable = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (PreferenceUtils.getServerConnection().isNotEmpty) {
      serverConnectionController.value.text =
          PreferenceUtils.getServerConnection();
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
          PreferenceUtils.setServerConnection(
              serverConnectionController.value.text);
          PreferenceUtils.setAppUrl(response['data']);
          serverConnectionDialog(Get.context!);
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

  serverConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gradient Title Bar
                Container(
                  //height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.color303E9F,
                        AppColors.color7A1FA2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: CommonText(
                    textAlign: TextAlign.center,
                    text: 'Connected Successfully',
                    color: AppColors.colorWhite,
                    fontSize: 18,
                    fontWeight: AppFontWeight.w500,
                  ),
                ),
                CommonText(
                  textAlign: TextAlign.center,
                  text:
                      'Successfully Connected Enter your Credential to Login.',
                  color: AppColors.color2F2F31,
                  fontSize: 16,
                  fontWeight: AppFontWeight.w400,
                ).paddingOnly(top: 30, bottom: 30),
                CommonButtonNew(
                        buttonText: "OK",
                        onPressed: () {
                          Get.back();
                          Get.toNamed(AppRoutes.loginRoute);
                        },
                        isLoading: false)
                    .paddingOnly(bottom: 30, left: 15, right: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  void serverConnectionValidationWithAPI() {
    if (serverConnectionController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter server name.');
    } else {
      serverConnection(serverConnectionController.value.text);
    }
  }
}
