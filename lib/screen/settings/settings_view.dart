import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/settings_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../widget/common_app_image_svg.dart';
import '../../widget/common_switch.dart';
import '../../widget/common_text.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
        title: "Setting",
        leadingIconSvg: AppImages.icBack, // Menu icon
      ),
      body: Container(
        width: double.infinity,
        //height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.colorF1EBFB,
        ),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _changePasswordUI(),
              _feedbackUI(),
              /*_cameraUI(),*/
              /*_patternUI(),*/
              /*_voiceUI(),*/
              /*_contactUSUI(),*/
              _versionUI(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _changePasswordUI() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.changePasswordRoute);
      },
      child: Container(
        //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0X1C1F370D),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Change Password',
              color: AppColors.colorDarkBlue,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ),
            const CommonAppImageSvg(
              imagePath: AppImages.settingsRightArrowIcon,
              height: 14,
              width: 8,
              fit: BoxFit.cover, // Ensures the image fills the space
            ),
          ],
        ), // Your widget inside the Container
      ),
    );
  }

  Widget _feedbackUI() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.feedbackRoute);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0X1C1F370D),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Feedback',
              color: AppColors.colorDarkBlue,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ),
            const CommonAppImageSvg(
              imagePath: AppImages.settingsRightArrowIcon,
              height: 14,
              width: 8,
              fit: BoxFit.cover, // Ensures the image fills the space
            ),
          ],
        ), // Your widget inside the Container
      ),
    );
  }

  /*Widget _cameraUI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: 'Camera',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ),
          Obx(() => CommonSwitch(
                isEnabled: controller.isCameraEnabled.value,
                onChanged: (value) {
                  //controller.isCameraEnabled.value = value; // Update the state
                },
              ))
        ],
      ), // Your widget inside the Container
    );
  }*/

  /*Widget _patternUI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: 'Pattern',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ),
          Obx(() => CommonSwitch(
                isEnabled: controller.isPatternEnabled.value,
                onChanged: (value) {
                  controller.isPatternEnabled.value = value; // Update the state
                },
              ))
        ],
      ), // Your widget inside the Container
    );
  }*/

  /*Widget _voiceUI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: 'Voice',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ),
          Obx(() => CommonSwitch(
                isEnabled: controller.isVoiceEnabled.value,
                onChanged: (value) {
                  controller.isVoiceEnabled.value = value; // Update the state
                },
              ))
        ],
      ), // Your widget inside the Container
    );
  }*/

  /*Temp commented due to play release*/
  /*Widget _contactUSUI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: 'Contact Us',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.makePhoneCall('07949068968'),
                // Open dialer
                child: const CommonAppImageSvg(
                  imagePath: AppImages.settingsCallIcon,
                  height: 16,
                  width: 16,
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () => controller.sendEmail('support@orangewebtech.com'),
                child: const CommonAppImageSvg(
                  imagePath: AppImages.settingsEmailIcon,
                  height: 16,
                  width: 16,
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
            ],
          )
        ],
      ), // Your widget inside the Container
    );
  }*/

  Widget _versionUI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: 'Version',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ),
          Obx(
            () => CommonText(
              text: controller.appVersion.value,
              color: AppColors.colorDarkBlue,
              fontSize: 16,
              fontWeight: AppFontWeight.w500,
            ),
          )
        ],
      ), // Your widget inside the Container
    );
  }
}
