import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import '../../widget/common_app_image.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorAppBars, AppColors.colorAppBars],
          // Gradient colors
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: const [0.8, 0.9],
          // Stops for the gradient colors
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GestureDetector(
            onTap: () {
              Utils.closeKeyboard(context);
            },
            child: SafeArea(
              child: controller.isLoading.isTrue
                  ? SizedBox(
                  height:
                  Utils.getScreenHeight(context: context) / 3.25,
                  child: Center(child: Utils.commonCircularProgress()))
                  : Scaffold(
                appBar: AppBar(
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.colorAppBars,
                          AppColors.colorAppBars
                        ],
                        // Gradient colors
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.3, 0.7],
                        // Stops for the gradient colors
                        tileMode: TileMode.clamp,
                      ),
                    ),
                  ),
                  centerTitle: true,
                  leading: InkWell(
                    splashColor: AppColors.colorWhite,
                    onTap: () {
                      Get.back();
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 15),
                      child: CommonAppImage(
                        imagePath: AppImages.icarrowback,
                        height: 10,
                        width: 10,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  title: CommonText(
                    text: 'Profile',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.colorBlack,
                  ),
                  // bottom: tabBarView(),
                ),
                body: getProfileView(context),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  getProfileView(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.color161F59, AppColors.color631983],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.3, 0.7],
                        // Stops for the gradient colors
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.getGallaryview(context);
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CommonAppImage(
                                  imagePath: controller.profileImage.value.isEmpty
                                      ? controller.userImageUrl.value
                                      :controller.profileImage.value,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )).paddingOnly(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: controller.profilemodelResponse.value.data![0].empFullName!,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              maxLine: 3,
                              color: AppColors.colorWhite,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ).paddingOnly(top: 10, right: 10),
                            CommonText(
                              text: controller.profilemodelResponse.value.data![0].empCode!,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.colorWhite,
                            ).paddingOnly(left: 15)
                          ],
                        )
                      ],
                    )).paddingOnly(left: 5, right: 5),
                CommonText(
                  padding: const EdgeInsets.only(left: 10),
                  text: 'Designation',
                  color: AppColors.color6B6D7A,
                  fontSize: 12,
                  fontWeight: AppFontWeight.w400,
                ).paddingOnly(top: 20, right: 20),
                CommonText(
                  padding: const EdgeInsets.only(left: 10),
                  text: controller.profilemodelResponse.value.data![0].desigName!,
                  color: AppColors.colorBlack,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ).paddingOnly(top: 5, right: 20),
                CommonText(
                  padding: const EdgeInsets.only(left: 10),
                  text: 'Reporting Manager',
                  color: AppColors.color6B6D7A,
                  fontSize: 12,
                  fontWeight: AppFontWeight.w400,
                ).paddingOnly(top: 20, right: 20),
                CommonText(
                  padding: const EdgeInsets.only(left: 10),
                  text: controller
                      .profilemodelResponse.value.data![0].empFullNameSuperior!,
                  color: AppColors.colorBlack,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ).paddingOnly(top: 5, right: 20),
                CommonText(
                  padding: const EdgeInsets.only(left: 10),
                  text: 'Personal Information',
                  color: AppColors.colorBlack,
                  fontSize: 16,
                  fontWeight: AppFontWeight.w500,
                ).paddingOnly(top: 20, right: 20),
                Container(
                    height: Utils.getScreenHeight(context: context) / 2.5,
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.iccalander,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Date of Joining',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 5, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value
                                          .data![0].dateOfJoin!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(
                                      left: 5,
                                    ),
                                  ],
                                ),
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.icbirth,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ).paddingOnly(left: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Date of Birth',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 10, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value.data![0].dOB!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 10,),
                                  ],
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.iccalander,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'UAN Number',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 5, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value
                                          .data![0].uANNo!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(
                                      left: 5,
                                    ),
                                  ],
                                ),
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.colorF8F4FA// Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.icblood,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ).paddingOnly(left: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Blood Group',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 10, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value
                                          .data![0].bloodGroup!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 10),
                                  ],
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                            Row(
                              children: [
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.icaadhar,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Aadhar Card Number',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 5, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value.data != null
                                          ? '--:--'
                                          : controller.profilemodelResponse.value.data![0].aadharCardNo!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(
                                      left: 5,
                                    ),
                                  ],
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                            Row(
                              children: [
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.iccall,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Mobile Number',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 5, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value
                                          .data![0].mobileNo!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(
                                      left: 5,
                                    ),
                                  ],
                                ),
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.icpan,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ).paddingOnly(left: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'PAN Number',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 10, top: 5),
                                    CommonText(
                                      text: controller. profilemodelResponse.value.data![0].panNo!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 10),
                                  ],
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                            Row(
                              children: [
                                Card(
                                    color: AppColors.colorF8F4FA,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.colorF8F4FA, // Background color
                                      ),
                                      child: Center(
                                        child: CommonAppImage(
                                          imagePath: AppImages.icemail,
                                          height: 20,
                                          width: 20,
                                        ).paddingOnly(left: 10, right: 10),
                                      ),
                                    )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Personal Email',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(left: 5, top: 5),
                                    CommonText(
                                      text: controller.profilemodelResponse.value
                                          .data![0].workEmail!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(
                                      left: 5,
                                    ),
                                  ],
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                          ],
                        )
                    )
                ).paddingOnly(top: 5),
              ],
            )).marginOnly(top: 10),
      ],
    );
  }

}
