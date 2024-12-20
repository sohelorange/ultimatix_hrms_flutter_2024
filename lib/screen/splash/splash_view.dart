import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_dimensions.dart';
import 'package:ultimatix_hrms_flutter/app/app_status_bar.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_strings.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_text.dart';
import 'splash_controller.dart';

// ignore: must_be_immutable
class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    AppStatusBar.setStatusBarStyle(
      statusBarColor: AppColors.colorWhite,
      //statusBarIconBrightness: Brightness.dark,
    );

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonAppImage(
              imagePath: AppImages.icAppLogo,
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
            CommonText(
              padding: const EdgeInsets.only(top: 10),
              text: AppString.orangeTechnoLabPvt,
              color: AppColors.color1C1F37,
              fontSize: AppDimensions.fontSizeLarge,
              fontWeight: AppFontWeight.w400,
            ),
            CommonText(
              text: AppString.payrollHRMS,
              color: AppColors.color1C1F37,
              fontSize: AppDimensions.fontSizeExtraLarge,
              fontWeight: AppFontWeight.w700,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonAppImage(
                    imagePath: AppImages.icAppLogo,
                    height: 30,
                    width: 30,
                    fit: BoxFit.fill,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: AppString.poweredBy,
                          color: AppColors.color1C1F37,
                          fontSize: AppDimensions.fontSizeThin,
                          fontWeight: AppFontWeight.w500,
                        ),
                        CommonText(
                          text: AppString.copyRights,
                          maxLine: 2,
                          color: AppColors.color1C1F37,
                          fontSize: AppDimensions.fontSizeThin,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ],
                    ).paddingOnly(left: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
