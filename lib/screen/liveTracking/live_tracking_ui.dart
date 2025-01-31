import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/liveTracking/live_tracking_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_bar.dart';
import '../../widget/common_container.dart';
import '../../widget/common_text.dart';
import '../../widget/new/common_app_bar_two.dart';

class LiveTrackingUi extends GetView<LiveTrackingController> {
  const LiveTrackingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBarTwo(
        title: 'Live Tracking',
      ),
      body: liveTrackingView(context),
    ));
  }

  liveTrackingView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Obx(
          () => Container(
            width: screenWidth,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorLightPurple3),
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      width: screenWidth / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CommonAppImage(
                                  imagePath: controller.userProfile.value,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text:
                                          controller.userName.toString().trim(),
                                      fontWeight: AppFontWeight.w500,
                                      fontSize: controller.responsiveFontSize(
                                          context, 16),
                                      // Responsively adjusted font size
                                      color: AppColors.color2F2F31,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                           const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CommonText(
                                  text: controller.userLocAddress.value.trim(),
                                  color: AppColors.color7B758E,
                                  fontWeight: FontWeight.w400,
                                  maxLine: 4,
                                  fontSize: controller.responsiveFontSize(
                                      context,
                                      12), // Responsively adjusted font size
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ).paddingOnly(top: screenHeight * 0.02),
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    height: screenWidth / 1.2,
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorLightPurple3),
                    child: controller.isWebLoading.value == false
                        ? WebViewWidget(controller: controller.webController!)
                        : const Center(child: CircularProgressIndicator()),
                  ).paddingOnly(top: screenHeight * 0.02),
                  const SizedBox(height: 16.0),
                  Container(
                    width: screenWidth / 1.1,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorLightPurple3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Box 1
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.colorWhite,
                              border: Border.all(
                                color: AppColors.colorDCDCDC,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppImages.svgBatteryNew),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: 'Battery',
                                        fontWeight: FontWeight.w500,
                                        fontSize: controller.responsiveFontSize(
                                            context, 12),
                                        // Responsively adjusted font size
                                        color: AppColors.color2F2F31,
                                      ),
                                      CommonText(
                                        text: controller.battery.value,
                                        fontWeight: FontWeight.w400,
                                        fontSize: controller.responsiveFontSize(
                                            context, 12),
                                        // Responsively adjusted font size
                                        color: AppColors.color7B758E,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Box 2
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.colorWhite,
                              border: Border.all(
                                color: AppColors.colorDCDCDC,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppImages.svgDistanceNew,
                                    height: 20, width: 20),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: 'Kilometer',
                                        fontWeight: FontWeight.w500,
                                        fontSize: controller.responsiveFontSize(
                                            context, 12),
                                        // Responsively adjusted font size
                                        color: AppColors.color2F2F31,
                                      ),
                                      CommonText(
                                        text: controller.distance.value
                                            .toStringAsFixed(2),
                                        fontWeight: FontWeight.w400,
                                        fontSize: controller.responsiveFontSize(
                                            context, 12),
                                        // Responsively adjusted font size
                                        color: AppColors.color7B758E,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Box 3
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.colorWhite,
                              border: Border.all(
                                color: AppColors.colorDCDCDC,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppImages.svgClockLiveTracking,
                                    height: 20, width: 20),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: 'Time',
                                        fontWeight: FontWeight.w500,
                                        fontSize: controller.responsiveFontSize(
                                            context, 12),
                                        // Responsively adjusted font size
                                        color: AppColors.color2F2F31,
                                      ),
                                      CommonText(
                                        text: controller.trackTime.value,
                                        fontWeight: FontWeight.w400,
                                        fontSize: controller.responsiveFontSize(
                                            context, 12),
                                        // Responsively adjusted font size
                                        color: AppColors.color7B758E,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: CommonButtonNew(
                        buttonText: "",
                        isSvgIcon: true,
                        nWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.svgCalender,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CommonText(
                              text: 'Select Date',
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.035,
                              // Responsively adjusted font size
                              color: AppColors.colorWhite,
                            )
                          ],
                        ),
                        onPressed: () async {
                          var selectedDate =
                              await Utils.selectDateNew(context: context);
                          controller.nDate.value = selectedDate.toString();
                          controller.getGeoLocationTrackingList(selectedDate);
                        },
                        isLoading: false),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: screenWidth * 0.05, top: 10),
                    child: Row(
                      children: [
                        Text(controller.nDate.value),
                      ],
                    ),
                  ),
                  Card(
                          shadowColor: AppColors.colorBlack,
                          elevation: 2,
                          color: AppColors.colorWhite,
                          child: controller.locationTrackingResponse.value.data
                                      ?.isNotEmpty ==
                                  true
                              ? ListView.builder(
                                  itemCount: controller.locationTrackingResponse
                                          .value.data?.length ??
                                      0,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, position) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.svgLocationLiveTrack),
                                            position !=
                                                    7 // Avoiding line for last item
                                                ? /*Container(
                                                    height: 65,
                                                    width: 2,
                                                    color: AppColors.color1C1F37
                                                        .withOpacity(0.3),
                                                  )*/
                                                  SvgPicture.asset(
                                                      height: 65,
                                                      width: 2,
                                                      AppImages.svgLocationTrack)
                                                : const SizedBox(
                                                    height: 65, width: 2),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonText(
                                                text: controller
                                                    .getDateInFormat(controller
                                                        .locationTrackingResponse
                                                        .value
                                                        .data
                                                        ?.elementAt(position)
                                                        .trackingDate),
                                                fontSize: controller.responsiveFontSize(context, 14),
                                                // Responsively adjusted font size
                                                fontWeight: AppFontWeight.w500,
                                                color: AppColors.color2F2F31,
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                              ),
                                              CommonText(
                                                text: controller
                                                            .locationTrackingResponse
                                                            .value
                                                            .data
                                                            ?.elementAt(
                                                                position)
                                                            .address
                                                            .toString() ==
                                                        null
                                                    ? ""
                                                    : controller
                                                        .locationTrackingResponse
                                                        .value
                                                        .data!
                                                        .elementAt(position)
                                                        .address
                                                        .toString(),
                                                fontSize: controller.responsiveFontSize(context, 12),
                                                fontWeight: AppFontWeight.w400,
                                                maxLine: 4,
                                                color: AppColors.color7B758E,
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                              ),
                                            ],
                                          ).paddingOnly(left: 10),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : SizedBox(
                                  width: screenWidth,
                                  child: const Text(
                                    "No Data Found",
                                    textAlign: TextAlign.center,
                                  ),
                                ).marginOnly(bottom: screenHeight * 0.08))
                      .marginOnly(
                          top: screenHeight * 0.02, left: 20, right: 20),
                ],
              ),
            ),
          ).marginOnly(top: screenHeight * 0.01),
        ),
      ],
    );
  }
}
