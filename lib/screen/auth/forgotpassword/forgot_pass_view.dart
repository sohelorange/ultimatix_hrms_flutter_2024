import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/forgotpassword/forgot_pass_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';

import '../../../app/app_dimensions.dart';

class ForgotPassView extends GetView<ForgotPassController> {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Obx(() => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: _mainUI().paddingOnly(top: 50),
                    ),
                  ),
                  Visibility(
                    visible: controller.isForgotPass.value,
                    child: CommonButtonNew(
                            buttonText: 'Submit',
                            onPressed: () {
                              controller.forgotPassValidationWithAPI();
                            },
                            isLoading: controller.isLoading.value,
                            isDisable: controller.isDisable.value)
                        .paddingOnly(top: 20),
                  ),
                  Visibility(
                    visible: controller.isVerifyOTP.value,
                    child: CommonButtonNew(
                            buttonText: 'Verify',
                            onPressed: () {
                              controller.verifyOTPValidationWithAPI();
                            },
                            isLoading: controller.isLoading.value,
                            isDisable: controller.isDisable.value)
                        .paddingOnly(top: 20),
                  ),
                  Visibility(
                    visible: controller.isResetPass.value,
                    child: CommonButtonNew(
                            buttonText: 'Submit',
                            onPressed: () {
                              controller.resetPassValidationWithAPI();
                            },
                            isLoading: controller.isLoading.value,
                            isDisable: controller.isDisable.value)
                        .paddingOnly(top: 20),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _mainUI() {
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
        ).paddingOnly(bottom: 40),
        Visibility(
            visible: controller.isForgotPass.value, child: _forgotPasswordUI()),
        Visibility(
            visible: controller.isVerifyOTP.value, child: _verifyOTPUI()),
        Visibility(
            visible: controller.isResetPass.value, child: _resetPasswordUI()),
      ],
    );
  }

  Widget _forgotPasswordUI() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: AppString.forgotPassWord.replaceAll('?', ''),
          color: AppColors.color2F2F31,
          fontSize: AppDimensions.fontSizeExtraLarge,
          fontWeight: AppFontWeight.w500,
        ),
        CommonText(
          text:
              'We just need your registered Login ID to send you password reset instructions.',
          color: AppColors.color2F2F31,
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 20),
        CommonText(
          text: 'Login ID',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 30),
        CommonAppInputNew(
          textEditingController: controller.forgotPassController.value,
          focusNode: controller.forgotPassFocus,
          hintText: 'Enter Login ID',
          textInputAction: TextInputAction.done,
          hintColor: AppColors.color7B758E,
        ).paddingOnly(top: 15),
        // CommonButtonNew(
        //         buttonText: 'Submit',
        //         onPressed: () {
        //           controller.forgotPassValidationWithAPI();
        //         },
        //         isLoading: controller.isLoading.value,
        //         isDisable: controller.isDisable.value)
        //     .paddingOnly(top: 20),
      ],
    );
  }

  Widget _verifyOTPUI() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: false,
          child: CommonText(
            text: 'Verify Password',
            color: AppColors.color2F2F31,
            fontSize: AppDimensions.fontSizeExtraLarge,
            fontWeight: AppFontWeight.w500,
          ),
        ),
        CommonText(
          text: 'Enter a passcode of 4 digits.',
          color: AppColors.color2F2F31,
          //fontSize: AppDimensions.fontSizeMedium,
          fontSize: AppDimensions.fontSizeExtraLarge,
          //fontWeight: AppFontWeight.w400,
          fontWeight: AppFontWeight.w500,
        ).paddingOnly(top: 20),
        Center(
          child: PinInputTextField(
            textInputAction: TextInputAction.done,
            pinLength: 4,
            decoration: BoxLooseDecoration(
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: AppFontWeight.w500,
                color: AppColors.colorBlack,
              ),
              //gapSpace: 45,
              strokeColorBuilder: PinListenColorBuilder(
                AppColors.color7A1FA2, // Blue color for active
                AppColors.colorDCDCDC, // Gray color for inactive/disabled
              ),
              bgColorBuilder: const FixedColorBuilder(
                Colors.transparent, // No background color
              ),
              //borderWidth: 2, // Box border width
              radius: const Radius.circular(6), // Rounded corners
            ),
            keyboardType: TextInputType.number,
            autoFocus: true,
            cursor: Cursor(
              width: 2,
              color: AppColors.color303E9F, // Blue cursor color
              enabled: true,
            ),
            onChanged: (pin) {
              if (pin.isEmpty) {
                controller.verifyOTP.value = 0;
              } else {
                controller.verifyOTP.value = int.parse(pin);
              }

              if (pin.length == 4) {
                Utils.closeKeyboard(Get.context!);
              }
            },
            onSubmit: (pin) {
              if (pin.isEmpty) {
                controller.verifyOTP.value = 0;
              } else {
                controller.verifyOTP.value = int.parse(pin);
              }
            },
          ).paddingOnly(top: 30),
        ),

        Visibility(
          visible: false,
          child: PinInputTextField(
            textInputAction: TextInputAction.done,
            pinLength: 4,
            decoration: UnderlineDecoration(
              textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: AppFontWeight.w500,
                  color: AppColors.colorBlack),
              colorBuilder: const FixedColorBuilder(AppColors.color303E9F),
            ),
            keyboardType: TextInputType.number,
            autoFocus: true,
            cursor: Cursor(
              width: 2,
              color: AppColors.color303E9F,
              enabled: true,
            ),
            onChanged: (pin) {
              if (pin.isEmpty) {
                controller.verifyOTP.value = 0;
              } else {
                controller.verifyOTP.value = int.parse(pin);
              }

              if (pin.length == 4) {
                Utils.closeKeyboard(Get.context!);
              }
            },
            onSubmit: (pin) {
              if (pin.isEmpty) {
                controller.verifyOTP.value = 0;
              } else {
                controller.verifyOTP.value = int.parse(pin);
              }
            },
          ).paddingOnly(top: 20),
        ),
        // CommonButtonNew(
        //         buttonText: 'Verify',
        //         onPressed: () {
        //           controller.verifyOTPValidationWithAPI();
        //         },
        //         isLoading: controller.isLoading.value,
        //         isDisable: controller.isDisable.value)
        //     .paddingOnly(top: 20),
      ],
    );
  }

  Widget _resetPasswordUI() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Reset Password',
          color: AppColors.color2F2F31,
          fontSize: AppDimensions.fontSizeExtraLarge,
          fontWeight: AppFontWeight.w500,
        ),
        CommonText(
          text: 'New Password',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 30),
        CommonAppInputNew(
          textEditingController: controller.newPassController.value,
          focusNode: controller.newPassFocus,
          hintText: 'Enter New Password',
          textInputAction: TextInputAction.next,
          hintColor: AppColors.color7B758E,
        ).paddingOnly(top: 15),
        CommonText(
          text: 'Confirm Password',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 30),
        CommonAppInputNew(
          textEditingController: controller.confirmPassController.value,
          focusNode: controller.confirmPassFocus,
          hintText: 'Enter Confirm Password',
          textInputAction: TextInputAction.done,
          hintColor: AppColors.color7B758E,
        ).paddingOnly(top: 15),
        // CommonButtonNew(
        //         buttonText: 'Submit',
        //         onPressed: () {
        //           controller.resetPassValidationWithAPI();
        //         },
        //         isLoading: controller.isLoading.value,
        //         isDisable: controller.isDisable.value)
        //     .paddingOnly(top: 20),
      ],
    );
  }
}
