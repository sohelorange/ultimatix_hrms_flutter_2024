import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/liveTracking/live_tracking_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_bar.dart';
import '../../widget/common_container.dart';
import '../../widget/common_text.dart';

class LiveTrackingUiBackup extends GetView<LiveTrackingController> {
  const LiveTrackingUiBackup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const CommonAppBar(
            title: 'Live Tracking',
          ),
          body: CommonContainer(
            child: liveTrackingView(context),
          ),
        ));
  }

  liveTrackingView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Obx(()=> Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  height: screenWidth / 1.2,
                  width: screenWidth / 1.1,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0X1C1F370D),
                        // Light gray color for shadow
                        blurRadius: 4.0,
                        // Increase the blur for a more spread-out shadow
                        spreadRadius: 1.0,
                        // Small spread to create a more pronounced shadow
                        offset: Offset(
                            0, 0), // Offset to simulate elevation effect (vertical shadow)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: controller.isWebLoading.value == false ? WebViewWidget(controller: controller.webController!) : const Center(child: CircularProgressIndicator()),
                ).paddingOnly(top: screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0X1C1F370D),
                        // Light gray color for shadow
                        blurRadius: 4.0,
                        // Increase the blur for a more spread-out shadow
                        spreadRadius: 1.0,
                        // Small spread to create a more pronounced shadow
                        offset: Offset(
                            0, 0), // Offset to simulate elevation effect (vertical shadow)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: screenWidth * 0.13,
                              height: screenWidth * 0.13,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: CommonAppImage(
                                imagePath: controller.userProfile.value,
                                height: 20,
                                width: 20,
                              )/*SvgPicture.asset(AppImages.svgAvatar)*/
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: controller.userName.toString().trim(),
                                  fontWeight: AppFontWeight.bold,
                                  fontSize: screenWidth * 0.035, // Responsively adjusted font size
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 8.0),
                                CommonText(
                                  text: controller.userLocAddress.value.trim(),
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  maxLine: 4,
                                  fontSize: screenWidth * 0.035, // Responsively adjusted font size
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).paddingOnly(top: screenHeight * 0.02),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Box 1
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorLightPurple1),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.svgBattery),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: 'Battery',
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.032, // Responsively adjusted font size
                                    color: AppColors.color9C9BA2,
                                  ),
                                  CommonText(
                                    text: controller.battery.value,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.032, // Responsively adjusted font size
                                    color: AppColors.colorBlack,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    // Box 2
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorLightPurple1),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.svgDistance, height: 20, width: 20),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: 'Kilometer',
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.032, // Responsively adjusted font size
                                    color: AppColors.colorBlack,
                                  ),
                                  CommonText(
                                    text: controller.distance.value.toStringAsFixed(2),
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.032, // Responsively adjusted font size
                                    color: AppColors.colorBlack,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    // Box 3
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorLightPurple1),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.svgTime, height: 20, width: 20),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: 'Time',
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.032, // Responsively adjusted font size
                                    color: AppColors.colorBlack,
                                  ),
                                  CommonText(
                                    text: controller.trackTime.value,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.032, // Responsively adjusted font size
                                    color: AppColors.colorBlack,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(left: screenWidth * 0.05, right: screenWidth * 0.05),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () async{
                    var selectedDate = await Utils.selectDateNew(context: context);
                    controller.nDate.value = selectedDate.toString();
                    controller.getGeoLocationTrackingList(selectedDate);
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.colorBlueDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.svgCalender,height: 20, width: 20,),
                        const SizedBox(width: 10,),
                        CommonText(
                          text: 'Select Date',
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.035, // Responsively adjusted font size
                          color: AppColors.colorWhite,
                        )
                      ],
                    ),
                  ),
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
                    child: controller.locationTrackingResponse.value.data?.isNotEmpty==true ? ListView.builder(
                      itemCount: controller.locationTrackingResponse.value.data?.length ?? 0,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, position) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset(AppImages.svgLocation),
                                position != 7 // Avoiding line for last item
                                    ? Container(
                                  height: 65,
                                  width: 2,
                                  color: AppColors.color1C1F37.withOpacity(0.3),
                                ) : const SizedBox(height: 65, width: 2),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: controller.getDateInFormat(controller.locationTrackingResponse.value.data?.elementAt(position).trackingDate),
                                    fontSize: screenWidth * 0.035, // Responsively adjusted font size
                                    fontWeight: AppFontWeight.w600,
                                    color: AppColors.color1C1F37,
                                    padding: const EdgeInsets.only(bottom: 5),
                                  ),
                                  CommonText(
                                    text: controller.locationTrackingResponse.value.data?.elementAt(position).address.toString()==null ? "" : controller.locationTrackingResponse.value.data!.elementAt(position).address.toString(),
                                    fontSize: screenWidth * 0.03, // Responsively adjusted font size
                                    fontWeight: AppFontWeight.w400,
                                    maxLine: 4,
                                    padding: const EdgeInsets.only(bottom: 5),
                                  ),
                                ],
                              ).paddingOnly(left: 10),
                            ),
                          ],
                        );
                      },
                    ) : SizedBox(
                      width: screenWidth,
                      child: const Text("No Data Found",textAlign: TextAlign.center,),
                    ).marginOnly(bottom: screenHeight * 0.08)
                ).marginOnly(top: screenHeight * 0.02, left: 20, right: 20),
              ],
            ),
          ),
        ).marginOnly(top: screenHeight * 0.01),
        ),
      ],
    );
  }
}
