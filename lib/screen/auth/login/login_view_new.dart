import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/login/login_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_input_field.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_dimensions.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_routes.dart';
import '../../../app/app_status_bar.dart';
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
      body: Obx(() => SingleChildScrollView(
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: _uiFun(),
              ),
            ),
          )),
    ));
  }

  Widget _uiFun() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
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
        const SizedBox(
          height: 40,
        ),
        CommonText(
          padding: const EdgeInsets.only(top: 10),
          text: !controller.isShowHide.value
              ? AppString.serverConnection
              : AppString.login,
          color: AppColors.color1C1F37,
          fontSize: AppDimensions.fontSizeExtraLarge,
          fontWeight: AppFontWeight.w500,
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            controller.isShowHide.value = false;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              TextEditingController textController =
                  controller.serverConnectionController.value;

              // Set cursor position to the end of the text
              textController.selection = TextSelection.fromPosition(
                TextPosition(offset: textController.text.length),
              );

              // Request focus to show the keyboard
              controller.serverConnectionFocus.requestFocus();
            });
          },
          child: CommonInputField(
            textEditingController: controller.serverConnectionController.value,
            hintText: "Server name",
            isEnable: !controller.isShowHide.value,
            textInputAction: TextInputAction.done,
            suffixIcon: controller.isShowHide.value ? Icons.edit : null,
            suffixColor: AppColors.colorDarkBlue,
            focusNode: controller.serverConnectionFocus,
            //nextFocusNode: controller.userNameFocus,
            labelStyle: TextStyle(
              color: !controller.isShowHide.value
                  ? AppColors.colorDarkBlue
                  : AppColors.colorDarkGray,
            ),
            hintStyle: TextStyle(
              color: !controller.isShowHide.value
                  ? AppColors.colorDarkBlue
                  : AppColors.colorDarkGray,
            ),
          ),
        ),
        Visibility(
          visible: controller.isShowHide.value,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CommonInputField(
                textInputAction: TextInputAction.next,
                textEditingController: controller.loginIDController.value,
                hintText: "Login ID",
                focusNode: controller.loginIDFocus,
                labelStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CommonInputField(
                suffixIcon: controller.isObscured.value
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                onSuffixClick: () => controller.toggleObscured(),
                textInputAction: TextInputAction.done,
                textEditingController: controller.passwordController.value,
                hintText: "Password",
                focusNode: controller.passWordFocus,
                isPassword: controller.isObscured.value ? true : false,
                labelStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Wrap the CheckboxListTile with Flexible or Expanded if needed
                  Flexible(
                    child: CheckboxListTile(
                      value: controller.isRememberCheck.value,
                      // Bind to reactive variable
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          controller.isRememberCheck.value = newValue;
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
                        }
                      },
                      title: CommonText(
                        text: AppString.rememberMe,
                        color: AppColors.colorDarkBlue,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w400,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.purpleSwatch,
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(horizontal: -2.0, vertical: -2.0),
                      tileColor: Colors.transparent,
                      // Set background to transparent
                      selectedTileColor:
                          Colors.transparent, // Remove tint when tapped
                    ),
                  ),

                  // GestureDetector to handle the "Forgot Password" click
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
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        CommonButton(
            buttonText: !controller.isShowHide.value ? 'Connect' : 'Login',
            onPressed: () {
              if (controller.isShowHide.value) {
                //TODO : Login API Call
                controller.loginValidationWithAPI();
              } else {
                //TODO : Server Connection API Call
                controller.serverConnectionValidationWithAPI();
              }
            },
            isLoading: controller.isLoading.value,
            isDisable: controller.isDisable.value),

        //CommonButton(buttonText: 'Login', onPressed: () {}, isLoading: false)
      ],
    );
  }

/*void _serverConnectionValidationWithAPI() {
    if (controller.serverConnectionController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter server name.');
    } else {
      controller
          .serverConnection(controller.serverConnectionController.value.text);
    }
  }

  void _loginValidationWithAPI() {
    if (controller.loginIDController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter login ID.');
    } else if (controller.passwordController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter password.');
    } else {
      controller.login(controller.loginIDController.value.text,
          controller.passwordController.value.text);
    }
  }*/

}
