import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_model.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_dropdown_new.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';

import '../../../app/app_images.dart';
import '../../../widget/common_app_image_svg.dart';

class LeaveApplicationDetailsView
    extends GetView<LeaveApplicationDetailsController> {
  const LeaveApplicationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
          title: 'Application Status', leadingIconSvg: AppImages.icBack),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Obx(() => getLeaveDetailsView(context)),
      ),
    ));
  }

  getLeaveDetailsView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: controller.leaveAppStatus.value == 'A'
          //         ? AppColors.colorGreen
          //             .withValues(alpha: 0.1) // Green for status 'A'
          //         : controller.leaveAppStatus.value == 'P'
          //             ? AppColors.colorAmber
          //                 .withValues(alpha: 0.1) // Amber for status 'P'
          //             : AppColors.colorRed.withValues(alpha: 0.1),
          //     borderRadius: BorderRadius.circular(6),
          //     boxShadow: [
          //       BoxShadow(
          //         color: controller.leaveAppStatus.value == 'A'
          //             ? AppColors.colorGreen
          //                 .withValues(alpha: 0.1) // Green for status 'A'
          //             : controller.leaveAppStatus.value == 'P'
          //                 ? AppColors.colorAmber.withValues(alpha: 0.1)
          //                 : AppColors.colorRed.withValues(alpha: 0.1),
          //         blurRadius: 0.0,
          //         spreadRadius: 1.0,
          //         offset: const Offset(0, 0),
          //       ),
          //     ],
          //   ),
          //   child: Center(
          //     child: CommonText(
          //       text: controller.leaveStatus.value,
          //       fontWeight: AppFontWeight.w500,
          //       fontSize: 16,
          //       color: controller.leaveAppStatus.value == 'A'
          //           ? AppColors.colorGreen // Green for status 'A'
          //           : controller.leaveAppStatus.value == 'P'
          //               ? AppColors.colorAmber // Amber for status 'P'
          //               : AppColors.colorRed,
          //     ),
          //   ),
          // ),

          Container(
            width: double.infinity,
            //height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorF1EBFB,
            ),
            child: Container(
                //margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: 'Request Details',
                          fontWeight: AppFontWeight.w500,
                          fontSize: 14,
                          color: AppColors.color2F2F31,
                        ),
                        Container(
                          height: 24,
                          //width: 80,
                          decoration: BoxDecoration(
                            color: controller.leaveAppStatus.value == 'A'
                                ? const Color(
                                    0XFF00ABA4) // Green for status 'A'
                                : controller.leaveAppStatus.value == 'P'
                                    ? const Color(
                                        0XFFB2AF76) // Amber for status 'P'
                                    : AppColors.colorRed
                                        .withValues(alpha: 0.80),
                            // Red for statuses 'C' or 'R',
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: CommonText(
                              text: controller.leaveStatus.value,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.colorWhite,
                            ).paddingSymmetric(horizontal: 10),
                          ),
                        ),
                      ],
                    ),
                    CommonText(
                      text: 'Leave Type ',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color7B758E,
                    ).paddingOnly(top: 5),
                    CommonText(
                      text: controller.leaveType.value,
                      fontWeight: AppFontWeight.w400,
                      fontSize: 14,
                      color: AppColors.color2F2F31,
                    ),
                    CommonText(
                      text: 'Leave From',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color7B758E,
                    ).paddingOnly(top: 5),
                    CommonText(
                      text: controller.leaveFromDt.value,
                      fontWeight: AppFontWeight.w400,
                      fontSize: 14,
                      color: AppColors.color2F2F31,
                    ),
                    CommonText(
                      text: 'Leave To',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color7B758E,
                    ).paddingOnly(top: 5),
                    CommonText(
                      text: controller.leaveToDt.value,
                      fontWeight: AppFontWeight.w400,
                      fontSize: 14,
                      color: AppColors.color2F2F31,
                    ),
                    CommonText(
                      text: 'Period',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color7B758E,
                    ).paddingOnly(top: 5),
                    CommonText(
                      text: '${controller.leavePeriod.value} Days',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 14,
                      color: AppColors.color2F2F31,
                    ),
                    CommonText(
                      text: 'Reason',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color7B758E,
                    ).paddingOnly(top: 5),
                    CommonText(
                      text: controller.leaveReason.value,
                      fontWeight: AppFontWeight.w400,
                      fontSize: 14,
                      color: AppColors.color2F2F31,
                    ),
                  ],
                )),
          ),
          Visibility(
              visible:
                  controller.leaveAppStatus.value.toString().toUpperCase() ==
                      'P',
              child: CommonButtonNew(
                buttonText: 'Delete',
                onPressed: () {
                  controller.deleteWithAPI();
                },
                isLoading: controller.isDeleteLoading.value,
                isDisable: controller.isDisable.value,
              ).paddingOnly(top: 20)),
          Visibility(
              visible:
                  controller.leaveAppStatus.value.toString().toUpperCase() ==
                      'A',
              child: controller.isLoading.isTrue
                  ? SizedBox(
                          height: 500,
                          child: Center(child: Utils.commonCircularProgress()))
                      .paddingOnly(top: 20)
                  : controller.leaveDetailsListResponse.value.data != null
                      ? _leaveCancelListUI(context).paddingOnly(top: 20)
                      : SizedBox(
                          height: 500,
                          child: Column(
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
                                    .leaveDetailsListResponse.value.message!,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.colorDarkBlue,
                              ),
                            ],
                          )).paddingOnly(top: 20)),
        ],
      ),
    );
  }

  Widget _leaveCancelListUI(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      //height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.leaveDetailsListResponse.value.data!.length,
          //physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var data = controller.leaveDetailsListResponse.value.data![index];
            return _cancelListUI(data, index);
          }),
    );
  }

  Widget _cancelListUI(LeaveApplicationDetailsModel data, int index) {
    // Define variables for leave type and duration
    RxString leaveTypeText = ''.obs;
    RxString leaveDurationText = ''.obs;

    // Check for valid leave type and assign values accordingly
    if (data.leaveAssignAs != null &&
        controller.leaveTypesDay.contains(data.leaveAssignAs!)) {
      leaveTypeText.value = data.leaveAssignAs!;
      //leaveDurationText.value = ("${data.actualLeaveDay.toString()} - ${data.leaveAssignAs}");
      leaveDurationText.value = (leaveTypeText.value == "Full Day")
          ? "(1.0 - ${leaveTypeText.value})"
          : "(0.5 - ${leaveTypeText.value})";
    } else {
      leaveTypeText.value = '';
      leaveDurationText.value = "(0.0 - Full Day)";
    }

    // Set selected leave type for the current data
    controller.selectedLeaveTypesDay?.value = data.leaveAssignAs ?? '';
    // Create or retrieve a persistent controller for this specific item
    TextEditingController reasonController =
        TextEditingController(text: data.approvalComments);
    // Create a persistent FocusNode for the text field
    FocusNode reasonFocusNode = FocusNode();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: AbsorbPointer(
        absorbing: data.appstatus.toString().substring(0, 1) == 'A',
        // Disable if approved
        child: Opacity(
          opacity: data.appstatus.toString().substring(0, 1) == 'A' ? 0.5 : 1.0,
          // Make it semi-transparent if approved
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with date and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: AppDatePicker.convertDateTimeFormat(
                        data.forDate!, Utils.commonUTCDateFormat, 'dd/MM/yyyy'),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.color2F2F31,
                  ),
                  Visibility(
                    visible: data.appstatus.toString().substring(0, 1) != 'A',
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: _getStatusColor(data.appstatus),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: CommonText(
                          text: data.appstatus ?? '',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: _getStatusTextColor(data.appstatus),
                        ).paddingSymmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
              CommonText(
                text: 'Leave Type',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w400,
              ).paddingOnly(top: 10),
              Visibility(
                visible: controller.leaveTypesDay.isNotEmpty,
                child: CommonDropdownNew(
                  items: controller.leaveTypesDay,
                  initialValue: data.leaveAssignAs != null &&
                          controller.leaveTypesDay.contains(data.leaveAssignAs!)
                      ? data.leaveAssignAs!
                      : null, // Ensure the value is valid
                  hint: "Select Leave Type",
                  onChanged: (value) {
                    controller.selectedLeaveTypesDay?.value = value;

                    // Update the leaveAssignAs in the model
                    data.leaveAssignAs = value;

                    if (data.leaveAssignAs == "Full Day") {
                      data.actualLeaveDay = 1.0; // Full Day
                      leaveDurationText.value =
                          ("${data.actualLeaveDay.toString()} - ${data.leaveAssignAs}");
                    } else {
                      data.actualLeaveDay = 0.5; // Half Day or other types
                      leaveDurationText.value =
                          ("${data.actualLeaveDay.toString()} - ${data.leaveAssignAs}");
                    }
                  },
                ),
              ).paddingOnly(top: 15),
              Obx(() => CommonText(
                    text: leaveDurationText.value,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.color2F2F31,
                  )).paddingOnly(top: 10),
              // Input field for reason
              CommonText(
                text: 'Reason *',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w400,
              ).paddingOnly(top: 10),
              CommonAppInputNew(
                textEditingController: reasonController,
                hintText: "Enter Reason",
                focusNode: reasonFocusNode, // Assign focus node
                onChanged: (value) {
                  data.approvalComments = value;
                },
              ).paddingOnly(top: 15),
              Visibility(
                  visible: data.appstatus.toString().substring(0, 1) != 'A',
                  child: const SizedBox(height: 10)),
              // Cancel button
              Visibility(
                visible: data.appstatus.toString().substring(0, 1) != 'A',
                child: CommonButtonNew(
                  buttonText: 'Cancel',
                  onPressed: () {
                    // Create a map with the current data to match the required array structure
                    Map<String, dynamic> leaveData = {
                      "forDate": AppDatePicker.convertDateTimeFormat(
                          data.forDate!,
                          Utils.commonUTCDateFormat,
                          'yyyy-MM-dd'),
                      "comment": data.approvalComments ?? '',
                      "assignAs": data.leaveAssignAs ?? '',
                      "actualLeaveDay":
                          data.actualLeaveDay?.toString() ?? '0.0',
                      "period": data.leavePeriod,
                    };

                    List<Map<String, dynamic>> strDetailsList = [
                      leaveData,
                    ];

                    if (strDetailsList.isNotEmpty) {
                      controller.insertCancelLeaveDetailsAPI(
                          int.parse(controller.leaveId.value),
                          int.parse(controller.leaveAppId.value),
                          int.parse(controller.leaveApprovalId.value),
                          strDetailsList);
                      // Print the created array with the current data
                      if (kDebugMode) {
                        print("Updated data at index $index: ${[leaveData]}");
                      }
                    }
                  },
                  isLoading: controller.isCancelLoading.value,
                  isDisable: controller.isCancelDisable.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper methods for status colors
  Color _getStatusColor(String? status) {
    if (status == null) return AppColors.colorRed.withValues(alpha: 0.80);
    switch (status.toUpperCase().substring(0, 1)) {
      case 'A':
        return const Color(0XFF00ABA4);
      case 'P':
        return const Color(0XFFB2AF76);
      default:
        return AppColors.colorRed.withValues(alpha: 0.80);
    }
  }

  Color _getStatusTextColor(String? status) {
    if (status == null) return AppColors.colorWhite;
    switch (status.toUpperCase().substring(0, 1)) {
      case 'A':
        return AppColors.colorWhite;
      case 'P':
        return AppColors.colorWhite;
      default:
        return AppColors.colorWhite;
    }
  }
}
