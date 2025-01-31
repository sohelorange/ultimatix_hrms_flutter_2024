import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../widget/common_button.dart';
import 'leave_manager_approval_details_controller.dart';
import '../leave_manager_approval/leave_manager_approval_model.dart';

class LeaveManagerApprovalDetailsView
    extends GetView<LeaveManagerApprovalDetailsController> {
  const LeaveManagerApprovalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        title: 'Leave Approvals',
        actions: [
          Visibility(
            visible: true,
            child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.leaveManagerApprovalEditDetailsRoute,
                      arguments: {
                        'leaveEditApprovalData':
                            Get.arguments['leaveApprovalData'] as Data,
                      });
                },
                icon: const Icon(Icons.edit)),
          )
        ],
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Obx(() => getLeaveDetailsView(context)),
        ),
      ),
    ));
  }

  getLeaveDetailsView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: AppColors.gradientBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: controller.userImageUrl.value.isEmpty
                        ? const CommonAppImageSvg(
                            imagePath: AppImages.svgAvatar, // Default SVG image
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
                              '${controller.leaveEmpCode.value} - ${controller.leaveEmpName.value}',
                          color: AppColors.colorWhite,
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
                              color: AppColors.colorWhite,
                              fit: BoxFit
                                  .cover, // Ensures the image fills the space
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CommonText(
                              textAlign: TextAlign.start,
                              text:
                                  "${AppDatePicker.convertDateTimeFormat(controller.leaveFromDt.value, Utils.commonUTCDateFormat, 'dd/MM/yyyy')} to ${AppDatePicker.convertDateTimeFormat(controller.leaveToDt.value, Utils.commonUTCDateFormat, 'dd/MM/yyyy')}",
                              color: AppColors.colorWhite,
                              fontSize: 12,
                              fontWeight: AppFontWeight.w400,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(6),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Leave Type ',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 12,
                    color: AppColors.color6B6D7A,
                  ),
                  CommonText(
                    text: controller.leaveName.value,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withValues(alpha: 0.2),
                  ),
                  CommonText(
                    text: 'Leave From',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 12,
                    color: AppColors.color6B6D7A,
                  ),
                  CommonText(
                    text: AppDatePicker.convertDateTimeFormat(
                        controller.leaveFromDt.value,
                        Utils.commonUTCDateFormat,
                        'dd/MM/yyyy'),
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withValues(alpha: 0.2),
                  ),
                  CommonText(
                      text: 'Leave To',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color6B6D7A),
                  CommonText(
                    text: AppDatePicker.convertDateTimeFormat(
                        controller.leaveToDt.value,
                        Utils.commonUTCDateFormat,
                        'dd/MM/yyyy'),
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withValues(alpha: 0.2),
                  ),
                  CommonText(
                    text: 'Period',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 12,
                    color: AppColors.color6B6D7A,
                  ),
                  CommonText(
                    text: '${controller.leavePeriod.value} Days',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withValues(alpha: 0.2),
                  ),
                  CommonText(
                    text: 'Days Available',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 12,
                    color: AppColors.color6B6D7A,
                  ),
                  CommonText(
                    text: controller.leaveType.value,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withValues(alpha: 0.2),
                  ),
                  CommonText(
                      text: 'Reason',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color6B6D7A),
                  CommonText(
                    text: controller.leaveReason.value,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                ],
              )),
          Visibility(
              visible: true,
              child: CommonButton(
                buttonText: 'Confirm',
                onPressed: () {
                  controller.showApprovalDialog();
                },
                isLoading: false,
              )),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                overlayColor: Colors.transparent,
              ),
              child: CommonText(
                text: 'Reject',
                fontWeight: AppFontWeight.w500,
                fontSize: 18,
                color: AppColors.purpleSwatch,
              ),
              onPressed: () async {
                controller.showCancelDialog();
              },
            ),
          )
        ],
      ),
    );
  }
}
