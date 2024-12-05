import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_input.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_images.dart';

class ServerConnectionView extends GetView<ServerConnectionController> {
  const ServerConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 4),
                  child: const CommonAppImage(
                    imagePath: AppImages.icserverlogo,
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ) ,
              ),
              Row(
                children: [
                  CommonText(
                    padding:
                    const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: AppString.serverConnection,
                    color: AppColors.colorBlack,
                    fontSize: 20,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ],
              ).paddingOnly(left: 15, top: 20),
              CommonAppInput(
                textEditingController: controller.serverController,
                focusNode: controller.serverFocus,
                hintText: AppString.servername,
                // prifixPadding: const EdgeInsets.all(12),
                hintColor: AppColors.colorBlack.withOpacity(0.3),
              ).paddingOnly(left: 20, right: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.resolveWith(
                            (states) => AppColors.colorPurple,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                  onPressed: () {
                    controller.serverConnectionDialog(context);
                    //Get.toNamed(AppRoutes.dashBoard);
                  },
                  child: CommonText(
                    text: AppString.connect,
                    color: AppColors.colorWhite,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ),
                ),
              ).paddingOnly(left: 30, right: 30, top: 20),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.loginRoute);
                },
                child:  CommonText(
                  padding:
                  const EdgeInsets.only(top: 20, bottom: 12, left: 12),
                  text: AppString.cancel,
                  color: AppColors.colorPurple,
                  fontSize: 18,
                  fontWeight: AppFontWeight.medium,
                ),
              )
             ,
            ],
          ),
        ),
      ),
    );
  }

}