import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/app_colors.dart';
import '../../app/app_dimensions.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_status_bar.dart';
import '../../app/app_strings.dart';
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
    );

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.gifLogo,
              filterQuality: FilterQuality.low,
              repeat: ImageRepeat.repeat,
              gaplessPlayback: true,
            ),

            // const CommonAppImage(
            //   imagePath: AppImages.icAppLogo,
            //   height: 80,
            //   width: 80,
            //   fit: BoxFit.fill,
            // ),
            // CommonText(
            //   padding: const EdgeInsets.only(top: 10),
            //   text: AppString.orangeTechnoLabPvt,
            //   color: AppColors.color1C1F37,
            //   fontSize: AppDimensions.fontSizeLarge,
            //   fontWeight: AppFontWeight.w400,
            // ),
            // CommonText(
            //   text: AppString.payrollHRMS,
            //   color: AppColors.color1C1F37,
            //   fontSize: AppDimensions.fontSizeExtraLarge,
            //   fontWeight: AppFontWeight.w700,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Center content horizontally
          children: [
            // const CommonAppImage(
            //   imagePath: AppImages.icAppLogo,
            //   height: 30,
            //   width: 30,
            //   fit: BoxFit.fill,
            // ),
            // const SizedBox(width: 10), // Add space between image and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
