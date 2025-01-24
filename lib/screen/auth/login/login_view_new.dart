import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_status_bar.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/login/login_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_routes.dart';
import '../../../app/app_strings.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_text.dart';

class LoginViewNew extends GetView<LoginController> {
  const LoginViewNew({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusBar.setStatusBarStyle(
      statusBarColor: AppColors.colorWhite,
      //statusBarIconBrightness: Brightness.dark,
    );

    return SafeArea(
        child: Scaffold(
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: _uiFun().paddingOnly(top: 50),
                  ),
                ),
                CommonButtonNew(
                        buttonText: 'Login',
                        onPressed: () {
                          controller.loginValidationWithAPI();
                        },
                        isLoading: controller.isLoading.value,
                        isDisable: controller.isDisable.value)
                    .paddingOnly(top: 20),
              ],
            ),
          )),
    ));
  }

  Widget _uiFun() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: CommonAppImage(
            imagePath: AppImages.icAppLogo,
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          ),
        ),
        CommonText(
          text: AppString.login,
          color: AppColors.color1C1F37,
          fontSize: 24,
          fontWeight: AppFontWeight.w500,
        ).paddingOnly(top: 40),

        RichText(
          text: TextSpan(
            text: 'Please enter your username and password to connect mobile ',
            style: TextStyle(
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ),
            children: [
              TextSpan(
                text: 'Payroll and HRMS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: AppFontWeight.w600, // Bold
                  color:
                      AppColors.color2F2F31, // Replace with desired bold color
                ),
              ),
            ],
          ),
        ).paddingOnly(top: 20),

        // CommonText(
        //   text:
        //       'Please enter your username and password to connect mobile Payroll and HRMS',
        //   color: AppColors.color1C1F37,
        //   fontSize: 16,
        //   fontWeight: AppFontWeight.w400,
        // ).paddingOnly(top: 20),

        CommonText(
          text: 'Login ID',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 30),
        CommonAppInputNew(
          textEditingController: controller.loginIDController.value,
          focusNode: controller.loginIDFocus,
          hintText: 'Enter Login ID',
          textInputAction: TextInputAction.next,
          hintColor: AppColors.color7B758E,
        ).paddingOnly(top: 15),
        CommonText(
          text: 'Password',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 20),
        CommonAppInputNew(
          textEditingController: controller.passwordController.value,
          focusNode: controller.passWordFocus,
          hintText: 'Enter Password',
          textInputAction: TextInputAction.done,
          hintColor: AppColors.color7B758E,
          isPassword: controller.isObscured.value ? true : false,
          suffixIcon: controller.isObscured.value
              ? Icons.visibility_off_rounded
              : Icons.visibility_rounded,
          onSuffixClick: () => controller.toggleObscured(),
        ).paddingOnly(top: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.isRememberCheck.value = !controller.isRememberCheck.value;
                      PreferenceUtils.setIsRemember(
                          controller.isRememberCheck.value);

                      if (PreferenceUtils.getIsRemember()) {
                        PreferenceUtils.setLoginUserID(
                            controller.loginIDController.value.text);
                        PreferenceUtils.setLoginUserPassword(
                            controller.passwordController.value.text);
                      } else {
                        PreferenceUtils.setLoginUserID('');
                        PreferenceUtils.setLoginUserPassword('');
                      }
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: controller.isRememberCheck.value
                            ? AppColors.color7A1FA2
                            : Colors.transparent,
                        border: Border.all(
                          color: AppColors.color2F2F31,
                          width: 1,
                        ),
                        borderRadius:
                            BorderRadius.circular(4), // For rounded corners
                      ),
                      child: controller.isRememberCheck.value
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CommonText(
                    text: AppString.rememberMe,
                    color: AppColors.colorDarkBlue,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                ],
              ),
              // child: CheckboxListTile(
              //   value: controller.isRememberCheck.value,
              //   onChanged: (bool? newValue) {
              //     if (newValue != null) {
              //       controller.isRememberCheck.value = newValue;
              //       PreferenceUtils.setIsRemember(
              //           controller.isRememberCheck.value);
              //
              //       if (PreferenceUtils.getIsRemember()) {
              //         PreferenceUtils.setLoginUserID(
              //             controller.loginIDController.value.text);
              //         PreferenceUtils.setLoginUserPassword(
              //             controller.passwordController.value.text);
              //       } else {
              //         PreferenceUtils.setLoginUserID('');
              //         PreferenceUtils.setLoginUserPassword('');
              //       }
              //     }
              //   },
              //   title: CommonText(
              //     text: AppString.rememberMe,
              //     color: AppColors.colorDarkBlue,
              //     fontSize: 14,
              //     fontWeight: AppFontWeight.w400,
              //   ),
              //   controlAffinity: ListTileControlAffinity.leading,
              //   activeColor: AppColors.color303E9F,
              //   contentPadding: EdgeInsets.zero,
              //   visualDensity:
              //       const VisualDensity(horizontal: -4.0, vertical: -2.0),
              //   tileColor: Colors.transparent,
              //   // Set background to transparent
              //   selectedTileColor:
              //       Colors.transparent, // Remove tint when tapped
              // ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.forgotPasswordRoute);
              },
              child: CommonText(
                text: AppString.forgotPassWord,
                color: AppColors.colorDarkBlue,
                fontSize: 14,
                underlineColor: AppColors.colorDarkBlue,
                decorationUnderline: TextDecoration.underline,
                fontWeight: AppFontWeight.w400,
              ),
            ),
          ],
        ).paddingOnly(top: 20),
      ],
    );
  }
}
