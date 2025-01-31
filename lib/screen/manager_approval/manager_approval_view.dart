import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import 'manager_approval_controller.dart';

class ManagerApprovalView extends GetView<ManagerApprovalController> {
  const ManagerApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
        title: "Approval",
        leadingIconSvg: AppImages.icBack, // Menu icon
      ),
      body: Obx(() => controller.isLoading.isTrue
          ? Center(child: Utils.commonCircularProgress())
          : controller.leaveManagerApprovalResponse.value.data != null
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.colorF1EBFB,
                  ),
                  child: getLeaveApprovalView(context),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonAppImageSvg(
                        imagePath: AppImages.svgNoData,
                        height: 100,
                        width: MediaQuery.sizeOf(context).width),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonText(
                      text: controller
                              .leaveManagerApprovalResponse.value.message ??
                          controller.errorMsg.value,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.colorDarkBlue,
                    ),
                  ],
                )),
    ));
  }

  getLeaveApprovalView(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.exploreItems.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.handleNavigation(index);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonAppImageSvg(
                    imagePath: controller.exploreItems[index]['icon'],
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover, // Ensures the image fills the space
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CommonText(
                      textAlign: TextAlign.start,
                      text: controller.exploreItems[index]['name'],
                      color: AppColors.color2F2F31,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CommonText(
                    text: controller.exploreItems[index]['count'],
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w500,
                  ),
                  // const CommonAppImageSvg(
                  //   imagePath: AppImages.settingsRightArrowIcon,
                  //   height: 14,
                  //   width: 8,
                  //   fit: BoxFit.cover, // Ensures the image fills the space
                  // ),
                ],
              ), // Your widget inside the Container
            ),
          );
        });
  }
}
