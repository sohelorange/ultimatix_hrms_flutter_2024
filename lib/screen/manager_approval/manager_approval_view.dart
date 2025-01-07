import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import 'manager_approval_controller.dart';

class ManagerApprovalView extends GetView<ManagerApprovalController> {
  const ManagerApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(
        title: 'Leave Approvals',
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Obx(() => controller.isLoading.isTrue
              ? Center(child: Utils.commonCircularProgress())
              : controller.leaveManagerApprovalResponse.value.data != null
                  ? getLeaveApprovalView(context)
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
                              .leaveManagerApprovalResponse.value.message!,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.colorDarkBlue,
                        ),
                      ],
                    )),
        ),
      ),
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
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(15),
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
                      color: AppColors.colorDarkGray,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CommonText(
                    text: controller.exploreItems[index]['count'],
                    color: AppColors.colorDarkGray,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w700,
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
