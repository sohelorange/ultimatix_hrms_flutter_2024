import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/leave_manager_approval/leave_manager_approval_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/manager_approval_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class LeaveManagerApprovalView extends GetView<LeaveManagerApprovalController> {
  const LeaveManagerApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      canPop: true,
      onPopInvoked: (val) {
        final ManagerApprovalController controller =
            Get.find<ManagerApprovalController>();
        controller.managerApprovalCountAPI();
      },
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
                            text: controller.leaveManagerApprovalResponse.value
                                        .message !=
                                    null
                                ? controller
                                    .leaveManagerApprovalResponse.value.message!
                                : "No record found",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.colorDarkBlue,
                          ),
                        ],
                      )),
          ),
        ),
      ),
    ));
  }

  getLeaveApprovalView(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.leaveManagerApprovalResponse.value.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.leaveManagerApprovalDetailsRoute,
                  arguments: {
                    'leaveApprovalData': controller
                        .leaveManagerApprovalResponse.value.data![index],
                  });
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
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: controller.userImageUrl.value.isEmpty
                            ? const CommonAppImageSvg(
                                imagePath:
                                    AppImages.svgAvatar, // Default SVG image
                                height: 40,
                                width: 40,
                                fit: BoxFit
                                    .cover, // Ensures the image fills the space
                              )
                            : CommonAppImageSvg(
                                imagePath: controller.userImageUrl.value,
                                // Use profile image URL
                                height: 40,
                                width: 40,
                                fit: BoxFit
                                    .cover, // Ensures the image fills the space
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              textAlign: TextAlign.start,
                              text:
                                  "${controller.leaveManagerApprovalResponse.value.data![index].empCode!} - ${controller.leaveManagerApprovalResponse.value.data![index].empFullName!}",
                              color: AppColors.colorDarkBlue,
                              fontSize: 14,
                              fontWeight: AppFontWeight.w500,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                const CommonAppImageSvg(
                                  imagePath: AppImages.approvalCalendarIcon,
                                  height: 12,
                                  width: 12,
                                  fit: BoxFit
                                      .cover, // Ensures the image fills the space
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CommonText(
                                  textAlign: TextAlign.start,
                                  text:
                                      "${AppDatePicker.convertDateTimeFormat(controller.leaveManagerApprovalResponse.value.data![index].fromDate!, Utils.commonUTCDateFormat, 'dd/MM/yyyy')} to ${AppDatePicker.convertDateTimeFormat(controller.leaveManagerApprovalResponse.value.data![index].toDate!, Utils.commonUTCDateFormat, 'dd/MM/yyyy')}",
                                  color: AppColors.colorDarkBlue,
                                  fontSize: 12,
                                  fontWeight: AppFontWeight.w400,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CommonAppImageSvg(
                        imagePath: AppImages.settingsRightArrowIcon,
                        height: 14,
                        width: 8,
                        fit: BoxFit.cover, // Ensures the image fills the space
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          // Add vertical padding for spacing
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.colorF7F8FC,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            // Let the column adjust to its content
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                textAlign: TextAlign.start,
                                text: 'Leave Type',
                                color: AppColors.color6B6D7A,
                                fontSize: 14,
                                fontWeight: AppFontWeight.w400,
                              ),
                              const SizedBox(height: 4),
                              // Add spacing between the two texts
                              CommonText(
                                textAlign: TextAlign.start,
                                text: controller.leaveManagerApprovalResponse
                                    .value.data![index].leaveName!,
                                color: AppColors.colorDarkBlue,
                                fontSize: 14,
                                fontWeight: AppFontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                                // Truncate text if it overflows
                                maxLine: 1, // Limit to one line
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          // Add vertical padding for spacing
                          decoration: BoxDecoration(
                            // boxShadow: const [
                            //   BoxShadow(
                            //     color: AppColors.colorDarkGray,
                            //     blurRadius: 0.0,
                            //     spreadRadius: 0.0,
                            //     offset: Offset(
                            //         0, 0),
                            //   ),
                            // ],
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.colorF7F8FC,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                textAlign: TextAlign.start,
                                text: 'Leave Days',
                                color: AppColors.color6B6D7A,
                                fontSize: 14,
                                fontWeight: AppFontWeight.w400,
                              ),
                              CommonText(
                                textAlign: TextAlign.start,
                                text:
                                    "${controller.leaveManagerApprovalResponse.value.data![index].leavePeriod.toString()} ${controller.leaveManagerApprovalResponse.value.data![index].leaveType!}",
                                color: AppColors.colorDarkBlue,
                                fontSize: 14,
                                fontWeight: AppFontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
