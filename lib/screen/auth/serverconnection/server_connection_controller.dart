import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class ServerConnectionController extends GetxController {
  TextEditingController serverController = TextEditingController();

  FocusNode serverFocus = FocusNode();

  serverConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
            onTap: () {
              Utils.closeKeyboard(context);
            },
            child: AlertDialog(
              surfaceTintColor: Colors.white,
              titlePadding: EdgeInsets.zero,
              actionsPadding: const EdgeInsets.only(bottom: 20, top: 10),
              content: SizedBox(
                height: 250,
                child: Column(
                  children: [
                    const CommonAppImage(
                      imagePath: AppImages.icserverright,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    ).paddingOnly(top: 20),
                    CommonText(
                      padding: const EdgeInsets.only(top: 10),
                      text: AppString.successText,
                      fontSize: 16,
                      color: AppColors.colorBlack,
                      fontWeight: AppFontWeight.regular,
                    ).paddingOnly(top: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith(
                              (states) => AppColors.colorPurple,
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        onPressed: () {
                          Get.back();
                          // controller.onLogInAPI();
                          //Get.toNamed(AppRoutes.dashBoard);
                        },
                        child: CommonText(
                          text: AppString.ok,
                          color: AppColors.colorWhite,
                          fontSize: 16,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ).paddingOnly(left: 30, right: 20, top: 20),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
