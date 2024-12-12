import 'package:flutter/material.dart';
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
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: _uiFun(),
                ),
              ),
            )),
      ),
    );
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
        //CommonButton(buttonText: 'Login', onPressed: () {}, isLoading: false)
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
