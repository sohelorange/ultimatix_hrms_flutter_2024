import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_time_format.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/leave_manager_approval_details/leave_manager_approval_edit_details/leave_manager_approval_edit_details_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_dropdown.dart';
import 'package:ultimatix_hrms_flutter/widget/common_input_field.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class LeaveManagerApprovalEditDetailsView
    extends GetView<LeaveManagerApprovalEditDetailsController> {
  const LeaveManagerApprovalEditDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(
        title: 'Edit Approval Details',
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
              padding: const EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //   color: AppColors.colorWhite,
              //   borderRadius: BorderRadius.circular(6),
              //   boxShadow: const [
              //     BoxShadow(
              //       color: Color(0X1C1F370D),
              //       blurRadius: 4.0,
              //       spreadRadius: 1.0,
              //       offset: Offset(0, 0),
              //     ),
              //   ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CommonText(
                  //   text: 'Leave Type ',
                  //   fontWeight: AppFontWeight.w400,
                  //   fontSize: 12,
                  //   color: AppColors.color6B6D7A,
                  // ),
                  CommonText(
                    text: controller.leaveName.value,
                    fontWeight: AppFontWeight.w500,
                    fontSize: 16,
                    color: AppColors.colorDarkBlue,
                  ).paddingOnly(top: 5),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInputField(
                    textEditingController: controller.fromDateController.value,
                    hintText: "From Date",
                    suffixIcon: Icons.calendar_month,
                    suffixColor: AppColors.colorDarkBlue,
                    focusNode: controller.fromDtFocus,
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    isEnable: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: controller.leaveId.value != '1481',
                    child: CommonInputField(
                      // onSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus(controller.reasonFocus);
                      // },
                      onChanged: (val) {
                        if (controller.debounce?.isActive ?? false) {
                          controller.debounce?.cancel();
                        }
                        controller.debounce =
                            Timer(const Duration(seconds: 1), () {
                          if (val.isNotEmpty) {
                            controller.getEmployeeLeavePeriod(
                                controller.fromDateController.value.text,
                                controller.periodController.value.text,
                                controller.toDateController.value.text,
                                controller.selectedLeaveTypesDay!.value,
                                controller.reasonController.value.text,
                                controller.attachment.value,
                                controller.docName.value);
                          } else {
                            controller.toDateController.value.clear();
                            controller.periodController.value.clear();
                            controller.leaveTypesDay.clear();
                            controller.selectedLeaveTypesDay!.value = '';
                            controller.leaveHalfDay.clear();
                            controller.selectedLeaveHalfDay!.value = '';
                            controller.selectedAPILeaveHalfDay!.value = '';
                          }
                        });
                      },
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                        // Allows only numbers and one decimal point
                      ],
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textEditingController: controller.periodController.value,
                      hintText: "No Of Days",
                      focusNode: controller.periodFocus,
                      labelStyle: const TextStyle(
                        color: AppColors.colorDarkBlue,
                      ),
                      hintStyle: const TextStyle(
                        color: AppColors.colorDarkBlue,
                      ),
                    ),
                  ),
                  //TODO : Hour Select
                  Visibility(
                    visible: controller.leaveId.value == '1481',
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Utils.closeKeyboard(context);
                            AppTimePicker.allTimeEnable24(
                                context, controller.fromTimeController.value);
                          },
                          child: CommonInputField(
                            textEditingController:
                                controller.fromTimeController.value,
                            hintText: "From Time",
                            suffixIcon: Icons.watch_later_outlined,
                            suffixColor: AppColors.colorDarkBlue,
                            focusNode: controller.fromTimeFocus,
                            labelStyle: const TextStyle(
                              color: AppColors.colorDarkBlue,
                            ),
                            hintStyle: const TextStyle(
                              color: AppColors.colorDarkBlue,
                            ),
                            isEnable: false,
                          ),
                        ),
                        CommonInputField(
                          // onSubmitted: (_) {
                          //   FocusScope.of(context).requestFocus(controller.reasonFocus);
                          // },
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              // Parse "From Time" and "No. of Hours"
                              final fromTimeText =
                                  controller.fromTimeController.value.text;
                              final noOfHours = double.parse(val);

                              if (fromTimeText.isNotEmpty) {
                                // Convert "From Time" to DateTime
                                final fromTime = DateTime.parse(
                                    "${controller.convertToHourFormat(controller.fromDateController.value.text)}T$fromTimeText:00");
                                // Add hours to "From Time"
                                final toTime = fromTime.add(Duration(
                                  hours: noOfHours.floor(),
                                  minutes:
                                      ((noOfHours - noOfHours.floor()) * 60)
                                          .round(),
                                ));

                                // Format "To Time" and set it
                                controller.toTimeController.value.text =
                                    "${toTime.hour.toString().padLeft(2, '0')}:${toTime.minute.toString().padLeft(2, '0')}";

                                controller.toDateController.value =
                                    controller.fromDateController.value;
                              }
                            } else {
                              controller.toTimeController.value.clear();
                            }
                          },
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                            // Allows only numbers and one decimal point
                          ],
                          textInputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textEditingController:
                              controller.hourController.value,
                          hintText: "No.Of Hours",
                          focusNode: controller.hourFocus,
                          labelStyle: const TextStyle(
                            color: AppColors.colorDarkBlue,
                          ),
                          hintStyle: const TextStyle(
                            color: AppColors.colorDarkBlue,
                          ),
                        ),
                        CommonInputField(
                          textEditingController:
                              controller.toTimeController.value,
                          hintText: "To Hour",
                          suffixIcon: Icons.watch_later_outlined,
                          suffixColor: AppColors.colorDarkBlue,
                          focusNode: controller.toTimeFocus,
                          labelStyle: const TextStyle(
                            color: AppColors.colorDarkGray,
                          ),
                          hintStyle: const TextStyle(
                            color: AppColors.colorDarkBlue,
                          ),
                          isEnable: false,
                        ),
                        CommonInputField(
                          textEditingController:
                              controller.toDateController.value,
                          hintText: "To Date",
                          suffixIcon: Icons.calendar_month,
                          suffixColor: AppColors.colorDarkBlue,
                          focusNode: controller.toDtFocus,
                          labelStyle: const TextStyle(
                            color: AppColors.colorDarkGray,
                          ),
                          hintStyle: const TextStyle(
                            color: AppColors.colorDarkBlue,
                          ),
                          isEnable: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.isLoading.value
                      ? Center(child: Utils.commonCircularProgress())
                      : Column(
                          children: [
                            Visibility(
                              visible: controller.leaveTypesDay.isNotEmpty,
                              child: CommonInputField(
                                textEditingController:
                                    controller.toDateController.value,
                                hintText: "To Date",
                                suffixIcon: Icons.calendar_month,
                                suffixColor: AppColors.colorDarkBlue,
                                focusNode: controller.toDtFocus,
                                labelStyle: const TextStyle(
                                  color: AppColors.colorDarkGray,
                                ),
                                hintStyle: const TextStyle(
                                  color: AppColors.colorDarkBlue,
                                ),
                                isEnable: false,
                              ),
                            ),
                            Visibility(
                              visible: controller.leaveTypesDay.isNotEmpty,
                              child: const SizedBox(
                                height: 20,
                              ),
                            ),
                            Visibility(
                              visible: controller.leaveTypesDay.isNotEmpty,
                              child: CommonDropdown(
                                items: controller.leaveTypesDay,
                                initialValue: controller.leaveTypesDay.contains(
                                        controller.selectedLeaveTypesDay?.value)
                                    ? controller.selectedLeaveTypesDay?.value
                                    : null, // Ensure the value is valid
                                hint: "Select Leave Type",
                                onChanged: (value) {
                                  controller.selectedLeaveTypesDay?.value =
                                      value;
                                },
                              ),
                            ),
                            Visibility(
                              visible: controller.leaveTypesDay.isNotEmpty,
                              child: const SizedBox(
                                height: 10,
                              ),
                            ),
                            //TODO : Half Day Date Select
                            Visibility(
                              visible: controller.leaveHalfDay.isNotEmpty,
                              child: const SizedBox(
                                height: 10,
                              ),
                            ),
                            Visibility(
                              visible: controller.leaveHalfDay.isNotEmpty,
                              child: CommonDropdown(
                                items: controller.leaveHalfDay,
                                initialValue: controller.leaveHalfDay.contains(
                                        controller.selectedLeaveHalfDay?.value)
                                    ? controller.selectedLeaveHalfDay?.value
                                    : null, // Ensure the value is valid
                                hint: "Select Half Day Date",
                                onChanged: (value) {
                                  controller.selectedLeaveHalfDay?.value =
                                      value;
                                  if (controller.selectedLeaveHalfDay?.value !=
                                      '0') {
                                    final selectedDate =
                                        DateFormat("dd/MM/yyyy").parse(
                                            controller.selectedLeaveHalfDay
                                                    ?.value ??
                                                ''); // Parse to DateTime
                                    final isoDate =
                                        DateFormat("yyyy-MM-ddTHH:mm:ss")
                                            .format(selectedDate);
                                    controller.selectedAPILeaveHalfDay?.value =
                                        isoDate;
                                  } else {
                                    controller.selectedAPILeaveHalfDay?.value =
                                        '';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                  CommonInputField(
                    textEditingController: controller.reasonController.value,
                    hintText: "Approval Comment ",
                    focusNode: controller.reasonFocus,
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                  ),
                  Visibility(
                    visible: controller.leaveTypesAttachment.value == 1,
                    child: const SizedBox(
                      height: 15,
                    ),
                  ),
                  Visibility(
                    visible: controller.leaveTypesAttachment.value == 1,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonText(
                            text: controller.docName.value.isEmpty
                                ? 'Browse File *'
                                : controller.docName.value,
                            fontSize: 16,
                            color: AppColors.colorDarkBlue,
                            fontWeight: AppFontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.filePickerFun();
                              },
                              child: const CommonAppImage(
                                imagePath: AppImages.icbrowse,
                                height: 25,
                                width: 25,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.docName.value = '';
                                  controller.attachment.value = '';
                                  controller.extension.value = '';
                                  controller.leaveTypesAttachment.value = 1;
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButton(
                    buttonText: 'Approve',
                    onPressed: () {
                      controller.validationWithAPI();
                    },
                    isLoading: controller.isDialogLoading.value,
                    isDisable: controller.isDisable.value,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
