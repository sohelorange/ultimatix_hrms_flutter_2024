import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_model.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_dropdown.dart';
import 'package:ultimatix_hrms_flutter/widget/common_input_field.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';

import '../../../app/app_images.dart';
import '../../../widget/common_app_bar.dart';
import '../../../widget/common_app_image_svg.dart';

class LeaveApplicationDetailsView
    extends GetView<LeaveApplicationDetailsController> {
  const LeaveApplicationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        title: 'Application Status',
        actions: [
          Visibility(
            visible: false,
            //visible:
            //    controller.leaveAppStatus.value.toString().toUpperCase() == 'A',
            child: IconButton(
              onPressed: () {
                controller.leaveCancelDialog(context);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(20),
          //child: getLeaveDetailsView(context),
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
            height: 50,
            decoration: BoxDecoration(
              color: controller.leaveAppStatus.value == 'A'
                  ? AppColors.colorGreen
                      .withOpacity(0.1) // Green for status 'A'
                  : controller.leaveAppStatus.value == 'P'
                      ? AppColors.colorAmber
                          .withOpacity(0.1) // Amber for status 'P'
                      : AppColors.colorRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: controller.leaveAppStatus.value == 'A'
                      ? AppColors.colorGreen
                          .withOpacity(0.1) // Green for status 'A'
                      : controller.leaveAppStatus.value == 'P'
                          ? AppColors.colorAmber.withOpacity(0.1)
                          : AppColors.colorRed.withOpacity(0.1),
                  blurRadius: 0.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: CommonText(
                text: controller.leaveStatus.value,
                fontWeight: AppFontWeight.w500,
                fontSize: 16,
                color: controller.leaveAppStatus.value == 'A'
                    ? AppColors.colorGreen // Green for status 'A'
                    : controller.leaveAppStatus.value == 'P'
                        ? AppColors.colorAmber // Amber for status 'P'
                        : AppColors.colorRed,
              ),
            ),
          ),
          CommonText(
            text: 'Request Details',
            fontWeight: AppFontWeight.w400,
            fontSize: 14,
            color: AppColors.colorBlack,
          ).paddingOnly(top: 20),
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
                    text: controller.leaveType.value,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withOpacity(0.2),
                  ),
                  CommonText(
                    text: 'Leave From',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 12,
                    color: AppColors.color6B6D7A,
                  ),
                  CommonText(
                    text: controller.leaveFromDt.value,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonText(
                      text: 'Leave To',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color6B6D7A),
                  CommonText(
                    text: controller.leaveToDt.value,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 14,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  Divider(
                    color: AppColors.colorBlack.withOpacity(0.2),
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
                    color: AppColors.colorBlack.withOpacity(0.2),
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
              visible:
                  controller.leaveAppStatus.value.toString().toUpperCase() ==
                      'P',
              child: CommonButton(
                buttonText: 'Delete',
                onPressed: () {
                  controller.deleteWithAPI();
                },
                isLoading: controller.isDeleteLoading.value,
                isDisable: controller.isDisable.value,
              )),
          Visibility(
              visible:
                  controller.leaveAppStatus.value.toString().toUpperCase() ==
                      'A',
              child: controller.isLoading.isTrue
                  ? SizedBox(
                      height: 350,
                      child: Center(child: Utils.commonCircularProgress()))
                  : controller.leaveDetailsListResponse.value.data != null
                      ? _leaveCancelListUI(context)
                      : SizedBox(
                          height: 350,
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
                          ))),
        ],
      ),
    );
  }

  Widget _leaveCancelListUI(BuildContext context) {
    return SizedBox(
      height: 350,
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
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.colorBlack,
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
              const SizedBox(height: 10),
              // Dropdown for leave type selection
              Visibility(
                visible: controller.leaveTypesDay.isNotEmpty,
                child: CommonDropdown(
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
              ),
              const SizedBox(height: 10),
              // Display leave duration
              Obx(() => CommonText(
                    text: leaveDurationText.value,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.colorBlack,
                  )),
              const SizedBox(height: 10),
              // Input field for reason
              CommonInputField(
                textEditingController: reasonController,
                hintText: "Reason *",
                focusNode: reasonFocusNode, // Assign focus node
                onChanged: (value) {
                  data.approvalComments = value;
                },
              ),
              Visibility(
                  visible: data.appstatus.toString().substring(0, 1) != 'A',
                  child: const SizedBox(height: 10)),
              // Cancel button
              Visibility(
                visible: data.appstatus.toString().substring(0, 1) != 'A',
                child: CommonButton(
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
    if (status == null) return AppColors.colorRed.withOpacity(0.1);
    switch (status.toUpperCase().substring(0, 1)) {
      case 'A':
        return AppColors.colorGreen.withOpacity(0.1);
      case 'P':
        return AppColors.colorAmber.withOpacity(0.1);
      default:
        return AppColors.colorRed.withOpacity(0.1);
    }
  }

  Color _getStatusTextColor(String? status) {
    if (status == null) return AppColors.colorRed;
    switch (status.toUpperCase().substring(0, 1)) {
      case 'A':
        return AppColors.colorGreen;
      case 'P':
        return AppColors.colorAmber;
      default:
        return AppColors.colorRed;
    }
  }
}
