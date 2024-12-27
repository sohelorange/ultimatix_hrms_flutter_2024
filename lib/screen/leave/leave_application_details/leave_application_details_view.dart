import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_dropdown.dart';
import 'package:ultimatix_hrms_flutter/widget/common_input_field.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';

import '../../../widget/common_app_bar.dart';

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
          child: getLeaveDetailsView(context),
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
                    blurRadius: 0.0,
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
              child: _leaveCancelListUI(context)),
        ],
      ),
    );
  }

  Widget _leaveCancelListUI(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          //physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            //Color cardColor =
            //controller.colors[index % controller.colors.length];
            return _cancelListUI();
          }),
    );
  }

  Widget _cancelListUI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            blurRadius: 0.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: '03/12/2024',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.colorBlack,
              ),
              Container(
                height: 30,
                //width: 80,
                decoration: BoxDecoration(
                  color: AppColors.colorAmber.withOpacity(0.1),
                  // Red for statuses 'C' or 'R',
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.colorAmber.withOpacity(0.1),
                      blurRadius: 0.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: CommonText(
                    text: 'Pending',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.colorAmber,
                  ).paddingSymmetric(horizontal: 10),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            //visible: controller.leaveTypesDay.isNotEmpty,
            visible: true,
            child: CommonDropdown(
              items: controller.leaveTypesDay,
              initialValue: controller.leaveTypesDay
                      .contains(controller.selectedLeaveTypesDay?.value)
                  ? controller.selectedLeaveTypesDay?.value
                  : null, // Ensure the value is valid
              hint: "Select Leave Type",
              onChanged: (value) {
                controller.selectedLeaveTypesDay?.value = value;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CommonText(
            text: '(0.0 - Full Day)',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.colorBlack,
          ),
          const SizedBox(
            height: 10,
          ),
          CommonInputField(
            textEditingController: controller.reasonController.value,
            hintText: "Reason *",
            focusNode: controller.reasonFocus,
            labelStyle: const TextStyle(
              color: AppColors.colorDarkBlue,
            ),
            hintStyle: const TextStyle(
              color: AppColors.colorDarkBlue,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CommonButton(buttonText: 'Cancel', onPressed: () {}, isLoading: false)
        ],
      ),
    );
  }
}
