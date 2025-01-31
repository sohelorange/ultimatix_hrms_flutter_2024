import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_time_format.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/add_leave/add_leave_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/add_leave/add_leave_type_dropdown_model.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_material_dialog.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_date_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_dropdown_new.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_images.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_text.dart';

class AddLeaveView extends GetView<AddLeaveController> {
  const AddLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
          title: 'Add Leave', leadingIconSvg: AppImages.icBack),
      body: Obx(() => Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Expanded(child: getAddLeaveView(context)),
                CommonButtonNew(
                  buttonText: 'Submit',
                  onPressed: () {
                    controller.validationWithAPI();
                  },
                  isLoading: controller.isSubmitLoading.value,
                  isDisable: controller.isDisable.value,
                )
              ],
            ),
          )),
    ));
  }

  getAddLeaveView(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonText(
          text: 'Leave Type',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            //height: 45,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: AppColors.colorDCDCDC,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<LeaveData?>(
              value: controller.selectedDropdownLeave.value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.colorDarkGray),
              underline: const SizedBox(),
              hint: CommonText(
                text: 'Select Leave Type',
                fontWeight: AppFontWeight.w400,
                fontSize: 16,
                color: AppColors.colorDarkBlue,
              ),
              items: controller.leaveDropdownList.value.data
                  ?.map((LeaveData leave) {
                return DropdownMenuItem<LeaveData>(
                  value: leave,
                  child: CommonText(
                    text: leave.leaveName,
                    fontWeight: AppFontWeight.w400,
                    fontSize: 16,
                    color: AppColors.colorDarkBlue,
                  ),
                );
              }).toList(),
              menuMaxHeight: 250,
              onChanged: (LeaveData? newValue) {
                if (newValue != null &&
                    controller.selectedDropdownLeaveID.value !=
                        newValue.leaveID.toString()) {
                  // Update the selected dropdown values
                  controller.selectedDropdownLeave.value = newValue;
                  controller.selectedDropdownLeaveID.value =
                      newValue.leaveID.toString();
                  controller.leaveTypesAttachment.value =
                      newValue.isDocumentRequired;

                  // Clear related fields because a new value was selected
                  controller.fromDateController.value.clear();
                  controller.periodController.value.clear();
                  controller.toDateController.value.clear();
                  controller.reasonController.value.clear();
                  controller.attachment.value = '';
                  controller.docName.value = '';
                  controller.selectedLeaveTypesDay?.value = '';
                  controller.leaveTypesDay.clear();
                  controller.leaveHalfDay.clear();
                  controller.selectedLeaveHalfDay?.value = '';
                  controller.selectedAPILeaveHalfDay!.value = '';
                  controller.fromTimeController.value.clear();
                  controller.hourController.value.clear();
                  controller.toTimeController.value.clear();
                  //controller.leaveTypesAttachment.value = 0;

                  if (controller.selectedDropdownLeaveID.value == '1724' ||
                      controller.selectedDropdownLeaveID.value == '1725') {
                    Get.dialog(CommonMaterialDialog(
                      title: 'Confirmation',
                      message:
                          'Your Leave Period Contains Holiday/WeekOff.Are you sure you want to continue?',
                      yesButtonText: 'Ok',
                      noButtonText: 'Cancel',
                      onConfirm: () {
                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                        controller.selectedDropdownLeave.value = null;
                        controller.selectedDropdownLeaveID.value = '';
                        controller.leaveTypesAttachment.value = 0;
                      },
                      isLoading: false.obs,
                    ));
                  }
                }
              },
            ),
          ),
        ).paddingOnly(top: 15),
        CommonText(
          text: 'Form Date',
          color: AppColors.color2F2F31,
          fontSize: 16,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 20),
        GestureDetector(
          onTap: () {
            if (controller.selectedDropdownLeaveID.value.isEmpty) {
              AppSnackBar.showGetXCustomSnackBar(
                message: 'Please select first leave type.',
              );
            } else {
              Utils.closeKeyboard(context);

              // Check if the selected date is already the same as the last selected date.
              if (controller.lastSelectedDate !=
                      null /*&&
                  controller.lastSelectedDate ==
                      controller.fromDateController.value.text*/
                  ) {
                // Call the API directly as the date hasn't changed.
              } else {
                // Open date picker and allow date selection.
                AppDatePicker.allDateChangeEnable(
                  context,
                  controller.fromDateController.value,
                  onDateChanged: (DateTime selectedDate) {
                    controller.lastSelectedDate = selectedDate;

                    if (controller.periodController.value.text.isNotEmpty) {
                      if (controller.debounce?.isActive ?? false) {
                        controller.debounce?.cancel();
                      }

                      controller.debounce =
                          Timer(const Duration(seconds: 1), () {
                        if (controller.periodController.value.text.isNotEmpty) {
                          controller.getEmployeeLeavePeriod(
                              controller.selectedDropdownLeaveID.value,
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
                    }
                  },
                );
              }
            }
          },
          child: CommonAppInputDateNew(
            textEditingController: controller.fromDateController.value,
            hintText: "Enter From Date",
            suffixIcon: Icons.calendar_month,
            suffixColor: AppColors.colorDarkBlue,
            focusNode: controller.fromDtFocus,
            hintColor: AppColors.color7B758E,
            labelStyle: const TextStyle(
              color: AppColors.color2F2F31,
            ),
            isEnable: false,
          ),
        ).paddingOnly(top: 15),

        //TODO : Period Leave
        _periodLeaveUI(),

        //TODO : Hour Select
        _hourLeaveUI(context),
      ],
    ));
  }

  Widget _periodLeaveUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: controller.selectedDropdownLeaveID.value != '1481',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Period',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w400,
              ).paddingOnly(top: 20),
              CommonAppInputDateNew(
                isEnable: controller.fromDateController.value.text.isNotEmpty
                    ? true
                    : false,
                // onSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(controller.reasonFocus);
                // },
                onChanged: (val) {
                  if (controller.fromDateController.value.text.isEmpty) {
                    controller.periodController.value.clear();
                    AppSnackBar.showGetXCustomSnackBar(
                        message: 'Please select first from date.');
                  } else {
                    if (controller.debounce?.isActive ?? false) {
                      controller.debounce?.cancel();
                    }
                    controller.debounce = Timer(const Duration(seconds: 1), () {
                      if (val.isNotEmpty) {
                        controller.getEmployeeLeavePeriod(
                            controller.selectedDropdownLeaveID.value,
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
                  }
                },
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  // Allows only numbers and one decimal point
                ],
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
                textEditingController: controller.periodController.value,
                hintText: "Enter Period",
                focusNode: controller.periodFocus,
                hintColor: AppColors.color7B758E,
              ).paddingOnly(top: 15),
            ],
          ),
        ),
        controller.isLoading.value
            ? Center(child: Utils.commonCircularProgress()).paddingOnly(top: 20)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: controller.leaveTypesDay.isNotEmpty,
                    child: CommonText(
                      text: 'To Date',
                      color: AppColors.color2F2F31,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ).paddingOnly(top: 20),
                  ),
                  Visibility(
                    visible: controller.leaveTypesDay.isNotEmpty,
                    child: CommonAppInputDateNew(
                      textEditingController: controller.toDateController.value,
                      hintText: "To Date",
                      suffixIcon: Icons.calendar_month,
                      suffixColor: AppColors.colorDarkBlue,
                      focusNode: controller.toDtFocus,
                      hintColor: AppColors.color7B758E,
                      labelStyle: const TextStyle(
                        color: AppColors.color2F2F31,
                      ),
                      isEnable: false,
                    ).paddingOnly(top: 15),
                  ),
                  Visibility(
                    visible: controller.leaveTypesDay.isNotEmpty,
                    child: const SizedBox(
                      height: 20,
                    ),
                  ),
                  Visibility(
                    visible: controller.leaveTypesDay.isNotEmpty,
                    child: CommonText(
                      text: 'Leave Type Days',
                      color: AppColors.color2F2F31,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                  Visibility(
                    visible: controller.leaveTypesDay.isNotEmpty,
                    child: CommonDropdownNew(
                      items: controller.leaveTypesDay,
                      initialValue: controller.leaveTypesDay
                              .contains(controller.selectedLeaveTypesDay?.value)
                          ? controller.selectedLeaveTypesDay?.value
                          : null, // Ensure the value is valid
                      hint: "Select Leave Type Days",
                      onChanged: (value) {
                        controller.selectedLeaveTypesDay?.value = value;
                      },
                    ),
                  ).paddingOnly(top: 15),
                  //TODO : Half Day Date Select
                  Visibility(
                    visible: controller.leaveHalfDay.isNotEmpty,
                    child: const SizedBox(
                      height: 20,
                    ),
                  ),
                  Visibility(
                    visible: controller.leaveHalfDay.isNotEmpty,
                    child: CommonText(
                      text: 'Half Days Leave Type Date',
                      color: AppColors.color2F2F31,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                  Visibility(
                    visible: controller.leaveHalfDay.isNotEmpty,
                    child: CommonDropdownNew(
                      items: controller.leaveHalfDay,
                      initialValue: controller.leaveHalfDay
                              .contains(controller.selectedLeaveHalfDay?.value)
                          ? controller.selectedLeaveHalfDay?.value
                          : null, // Ensure the value is valid
                      hint: "Select Half Day Date",
                      onChanged: (value) {
                        controller.selectedLeaveHalfDay?.value = value;
                        if (controller.selectedLeaveHalfDay?.value != '0') {
                          final selectedDate = DateFormat("dd/MM/yyyy").parse(
                              controller.selectedLeaveHalfDay?.value ??
                                  ''); // Parse to DateTime
                          final isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss")
                              .format(selectedDate);
                          controller.selectedAPILeaveHalfDay?.value = isoDate;
                        } else {
                          controller.selectedAPILeaveHalfDay?.value = '';
                        }
                      },
                    ).paddingOnly(top: 15),
                  ),

                  Visibility(
                    visible:
                        controller.selectedDropdownLeaveID.value.isNotEmpty &&
                            controller.leaveTypesDay.isNotEmpty,
                    child: CommonText(
                      text: 'Reason *',
                      color: AppColors.color2F2F31,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ).paddingOnly(top: 20),
                  ),
                  Visibility(
                    visible:
                        controller.selectedDropdownLeaveID.value.isNotEmpty &&
                            controller.leaveTypesDay.isNotEmpty,
                    child: CommonAppInputNew(
                      textEditingController: controller.reasonController.value,
                      hintText: "Enter Reason",
                      focusNode: controller.reasonFocus,
                      hintColor: AppColors.color7B758E,
                    ).paddingOnly(top: 15, bottom: 0),
                  ),
                  Visibility(
                    visible:
                        controller.selectedDropdownLeaveID.value.isNotEmpty &&
                            controller.leaveTypesDay.isNotEmpty &&
                            controller.leaveTypesAttachment.value != 1,
                    child: const SizedBox(
                      height: 15,
                    ),
                  ),
                  Visibility(
                    visible:
                        controller.selectedDropdownLeaveID.value.isNotEmpty &&
                            controller.leaveTypesDay.isNotEmpty &&
                            controller.leaveTypesAttachment.value == 1,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonText(
                            text: controller.docName.value.isEmpty
                                ? 'Browse File *'
                                : controller.docName.value,
                            fontSize: 16,
                            color: AppColors.color2F2F31,
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
                    ).paddingOnly(top: 15, bottom: 15),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _hourLeaveUI(BuildContext context) {
    return Visibility(
      visible: controller.selectedDropdownLeaveID.value == '1481',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'From Hour',
            color: AppColors.color2F2F31,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ),
          GestureDetector(
            onTap: () {
              if (controller.fromDateController.value.text.isEmpty) {
                AppSnackBar.showGetXCustomSnackBar(
                    message: 'Please select from date.');
              } else {
                Utils.closeKeyboard(context);
                AppTimePicker.allTimeEnable24(
                    context, controller.fromTimeController.value);
              }
            },
            child: CommonAppInputDateNew(
              textEditingController: controller.fromTimeController.value,
              hintText: "HH:mm",
              suffixIcon: Icons.watch_later_outlined,
              suffixColor: AppColors.colorDarkBlue,
              focusNode: controller.fromTimeFocus,
              hintColor: AppColors.color7B758E,
              labelStyle: const TextStyle(
                color: AppColors.color2F2F31,
              ),
              isEnable: false,
            ),
          ).paddingOnly(top: 15),
          CommonText(
            text: 'No.Of Hours',
            color: AppColors.color2F2F31,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ).paddingOnly(top: 20),
          CommonAppInputDateNew(
            // onSubmitted: (_) {
            //   FocusScope.of(context).requestFocus(controller.reasonFocus);
            // },
            onChanged: (val) {
              if (val.isNotEmpty) {
                // Parse "From Time" and "No. of Hours"
                final fromTimeText = controller.fromTimeController.value.text;
                final noOfHours = double.parse(val);

                if (fromTimeText.isNotEmpty) {
                  // Convert "From Time" to DateTime
                  final fromTime = DateTime.parse(
                      "${controller.convertToHourFormat(controller.fromDateController.value.text)}T$fromTimeText:00");
                  // Add hours to "From Time"
                  final toTime = fromTime.add(Duration(
                    hours: noOfHours.floor(),
                    minutes: ((noOfHours - noOfHours.floor()) * 60).round(),
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
            isEnable: controller.fromTimeController.value.text.isNotEmpty
                ? true
                : false,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              // Allows only numbers and one decimal point
            ],
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            textEditingController: controller.hourController.value,
            hintText: "Enter No.Of Hours",
            focusNode: controller.hourFocus,
            hintColor: AppColors.color7B758E,
            labelStyle: const TextStyle(
              color: AppColors.color2F2F31,
            ),
          ).paddingOnly(top: 15),
          CommonText(
            text: 'To Hour',
            color: AppColors.color2F2F31,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ).paddingOnly(top: 20),
          CommonAppInputDateNew(
            textEditingController: controller.toTimeController.value,
            hintText: "HH:mm",
            suffixIcon: Icons.watch_later_outlined,
            suffixColor: AppColors.colorDarkBlue,
            focusNode: controller.toTimeFocus,
            hintColor: AppColors.color7B758E,
            labelStyle: const TextStyle(
              color: AppColors.color2F2F31,
            ),
            isEnable: false,
          ).paddingOnly(top: 15),
          CommonText(
            text: 'To Date',
            color: AppColors.color2F2F31,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ).paddingOnly(top: 20),
          CommonAppInputDateNew(
            textEditingController: controller.toDateController.value,
            hintText: "DD/MM/YYYY",
            suffixIcon: Icons.calendar_month,
            suffixColor: AppColors.colorDarkBlue,
            focusNode: controller.toDtFocus,
            hintColor: AppColors.color7B758E,
            labelStyle: const TextStyle(
              color: AppColors.color2F2F31,
            ),
            isEnable: false,
          ).paddingOnly(top: 15),
          CommonText(
            text: 'Reason *',
            color: AppColors.color2F2F31,
            fontSize: 16,
            fontWeight: AppFontWeight.w400,
          ).paddingOnly(top: 20),
          CommonAppInputNew(
            textEditingController: controller.reasonController.value,
            hintText: "Enter Reason",
            focusNode: controller.reasonFocus,
            hintColor: AppColors.color7B758E,
          ).paddingOnly(top: 15, bottom: 15),
        ],
      ),
    );
  }
}
