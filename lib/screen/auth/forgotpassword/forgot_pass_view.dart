import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/forgotpassword/forgot_pass_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_input.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class ForgotPassView extends GetView<ForgotPassController> {
  const ForgotPassView({super.key});

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
                    imagePath: AppImages.icAppLogo,
                    height: 60,
                    width: 60,
                    fit: BoxFit.fill,
                  ),
                ) ,
              ),
              Row(
                children: [
                  CommonText(
                    padding:
                    const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: 'Forgot Password',
                    color: AppColors.colorBlack,
                    fontSize: 20,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ],
              ).paddingOnly(left: 15, top: 20),
              Row(
                children: [
                  CommonText(
                    padding:
                    const EdgeInsets.only(left: 12),
                    text: AppString.forgotPasswordText,
                    color: AppColors.colorBlack,
                    fontSize: 15,
                    fontWeight: AppFontWeight.regular,
                  ),
                ],
              ).paddingOnly(left: 15, top: 20),
              Row(
                children: [
                  CommonText(
                    padding:
                    const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: AppString.loginId,
                    color: AppColors.colorBlack,
                    fontSize: 14,
                    fontWeight: AppFontWeight.medium,
                  ),
                ],
              ).paddingOnly(left: 15, top: 17),
              CommonAppInput(
                textEditingController: controller.forgotpassController,
                focusNode: controller.forgotFocus,
                hintText: AppString.enterUserName,
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
                    //Get.toNamed(AppRoutes.dashBoard);
                  },
                  child: CommonText(
                    text: AppString.submit,
                    color: AppColors.colorWhite,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ),
                ),
              ).paddingOnly(left: 30, right: 30, top: 20),

            ],
          ),
        ),
      ),
    );
  }

}