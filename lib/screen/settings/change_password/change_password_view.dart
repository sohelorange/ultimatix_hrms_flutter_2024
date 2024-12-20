import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/change_password/change_password_controller.dart';

import '../../../app/app_colors.dart';
import '../../../widget/common_app_bar.dart';
import '../../../widget/common_button.dart';
import '../../../widget/common_container.dart';
import '../../../widget/common_input_field.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(title: 'Change Password'),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Obx(() => SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonInputField(
                      suffixIcon: controller.isCurrentPass.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      onSuffixClick: () => controller.currentPassObscured(),
                      textInputAction: TextInputAction.next,
                      textEditingController:
                          controller.currentPasswordController.value,
                      hintText: "Current Password",
                      focusNode: controller.currentPassWordFocus,
                      isPassword: controller.isCurrentPass.value,
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
                      suffixIcon: controller.isChangePass.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      onSuffixClick: () => controller.changePassObscured(),
                      textInputAction: TextInputAction.next,
                      textEditingController:
                          controller.changePasswordController.value,
                      hintText: "Change Password",
                      focusNode: controller.changePassWordFocus,
                      isPassword: controller.isChangePass.value ? true : false,
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
                      suffixIcon: controller.isConfirmPass.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      onSuffixClick: () => controller.confirmPassObscured(),
                      textInputAction: TextInputAction.done,
                      textEditingController:
                          controller.confirmPasswordController.value,
                      hintText: "Confirm Password",
                      focusNode: controller.confirmPassWordFocus,
                      isPassword: controller.isConfirmPass.value ? true : false,
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
                        buttonText: 'Update',
                        onPressed: () {
                          controller.changePasswordWithAPI();
                        },
                        isLoading: controller.isLoading.value,
                        isDisable: controller.isDisable.value),
                  ],
                ),
              )),
        ),
      ),
    ));
  }
}
