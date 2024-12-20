import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/forgotpassword/forgot_pass_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_dimensions.dart';
import '../../../widget/common_button.dart';
import '../../../widget/common_input_field.dart';

class ForgotPassView extends GetView<ForgotPassController> {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Obx(() => SingleChildScrollView(
              child: Container(
                //height: MediaQuery.of(context).size.height, // Full screen height
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: _mainUI(),
              ),
            )),
      ),
    );
  }

  Widget _mainUI() {
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
          color: AppColors.color1C1F37,
          fontSize: AppDimensions.fontSizeExtraLarge,
          fontWeight: AppFontWeight.w500,
        ),
        const SizedBox(
          height: 20,
        ),
        CommonText(
          padding: const EdgeInsets.only(top: 10),
          text: AppString.forgotPasswordText.replaceAll('?', ''),
          color: const Color(0XFF6B6D7A),
          maxLine: 3,
          fontSize: AppDimensions.fontSizeRegular,
          fontWeight: AppFontWeight.w400,
        ),
        const SizedBox(
          height: 30,
        ),
        CommonInputField(
          textInputAction: TextInputAction.done,
          textEditingController: controller.forgotPassController.value,
          hintText: "Login ID",
          focusNode: controller.forgotPassFocus,
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
        CommonButton(
            buttonText: 'Submit',
            onPressed: () {
              controller.forgotPassValidationWithAPI();
            },
            isLoading: controller.isLoading.value,
            isDisable: controller.isDisable.value),
      ],
    );
  }

  Widget _verifyOTPUI() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Enter a passcode of 4 digits',
          color: AppColors.colorDarkBlue,
          fontSize: AppDimensions.fontSizeLarge,
          fontWeight: AppFontWeight.w500,
        ),
        const SizedBox(
          height: 40,
        ),
        VerificationCodeField(
          length: 4,
          onFilled: (value) {
            controller.verifyOTP.value = int.parse(value);
            if (kDebugMode) {
              print(value);
              print(controller.verifyOTP.value);
            }
          },
          size: const Size(70, 60),
          spaceBetween: 13,
          matchingPattern: RegExp(r'^\d+$'),
        ),
        const SizedBox(
          height: 30,
        ),
        CommonButton(
            buttonText: 'Verify',
            onPressed: () {
              controller.verifyOTPValidationWithAPI();
            },
            isLoading: controller.isLoading.value,
            isDisable: controller.isDisable.value),
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
          color: AppColors.colorDarkBlue,
          fontSize: AppDimensions.fontSizeExtraLarge,
          fontWeight: AppFontWeight.w500,
        ),
        const SizedBox(
          height: 40,
        ),
        CommonInputField(
          textInputAction: TextInputAction.next,
          textEditingController: controller.newPassController.value,
          hintText: "New Password",
          focusNode: controller.newPassFocus,
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
          textInputAction: TextInputAction.done,
          textEditingController: controller.confirmPassController.value,
          hintText: "Confirm Password",
          focusNode: controller.confirmPassFocus,
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
        CommonButton(
            buttonText: 'Submit',
            onPressed: () {
              controller.resetPassValidationWithAPI();
            },
            isLoading: controller.isLoading.value,
            isDisable: controller.isDisable.value),
      ],
    );
  }

// void _forgotPassValidationWithAPI() {
//   if (controller.forgotPassController.value.text.isEmpty) {
//     AppSnackBar.showGetXCustomSnackBar(message: 'Please enter login ID.');
//   } else {
//     controller.forgotPass(controller.forgotPassController.value.text);
//   }
// }
}
