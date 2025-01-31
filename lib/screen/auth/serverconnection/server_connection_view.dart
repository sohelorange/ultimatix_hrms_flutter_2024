import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';

import '../../../app/app_images.dart';

class ServerConnectionView extends GetView<ServerConnectionController> {
  const ServerConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 4),
                              child: const CommonAppImage(
                                imagePath: AppImages.icserverlogo,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          CommonText(
                            text: 'Please enter server name',
                            color: AppColors.color2F2F31,
                            fontSize: 16,
                            fontWeight: AppFontWeight.w400,
                          ).paddingOnly(top: 40),
                          CommonAppInputNew(
                            textEditingController:
                                controller.serverConnectionController.value,
                            focusNode: controller.serverFocus,
                            hintText: 'Enter Server Name',
                            textInputAction: TextInputAction.done,
                            hintColor: AppColors.color7B758E,
                          ).paddingOnly(top: 15),
                        ],
                      ),
                    ),
                  ),
                  CommonButtonNew(
                    buttonText: 'Connect',
                    onPressed: () {
                      if (controller
                          .serverConnectionController.value.text.isEmpty) {
                        AppSnackBar.showGetXCustomSnackBar(
                            message: 'Please enter server name.');
                      } else {
                        controller.serverConnectionValidationWithAPI();
                      }
                    },
                    isLoading: controller.isLoading.value,
                    isDisable: controller.isDisable.value,
                  ).paddingOnly(top: 20),
                ],
              )),
        ),
      ),
    );
  }
}
