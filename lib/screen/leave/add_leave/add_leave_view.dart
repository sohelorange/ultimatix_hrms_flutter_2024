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
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_material_dialog.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_images.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_dropdown.dart';
import '../../../widget/common_input_field.dart';
import '../../../widget/common_text.dart';

class AddLeaveView extends GetView<AddLeaveController> {
  const AddLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(
        title: 'Add Leave',
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: getAddLeaveView(context),
        ),
      ),
    ));
  }

  getAddLeaveView(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: AppColors.colorDarkGray),
                ),
              ),
              child: DropdownButton<LeaveData?>(
                value: controller.selectedDropdownLeave.value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.colorDarkGray),
                underline: const SizedBox(),
                hint: CommonText(
                  text: 'Select Leave',
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
                  // controller.selectedDropdownLeave.value = newValue;
                  // if (newValue != null) {
                  //   controller.selectedDropdownLeaveID.value =
                  //       newValue.leaveID.toString();
                  //   controller.leaveTypesAttachment.value =
                  //       newValue.isDocumentRequired;
                  //
                  //   if (controller.selectedDropdownLeaveID.value ==
                  //       newValue.leaveID.toString()) {
                  //     print('test');
                  //   } else {
                  //     print('success test');
                  //     controller.fromDateController.value.clear();
                  //     controller.periodController.value.clear();
                  //     controller.toDateController.value.clear();
                  //     controller.reasonController.value.clear();
                  //     controller.attachment.value = '';
                  //     controller.docName.value = '';
                  //     controller.selectedLeaveTypesDay?.value = '';
                  //     controller.leaveTypesDay.clear();
                  //     controller.leaveTypesAttachment.value = 0;
                  //   }
                  //}

                  // Check if the new value is different from the currently selected value
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
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              // if (controller.selectedDropdownLeaveID.value.isEmpty) {
              //   AppSnackBar.showGetXCustomSnackBar(
              //       message: 'Please select first leave type.');
              // } else {
              //   Utils.closeKeyboard(context);
              //   AppDatePicker.allDateEnable(
              //       context, controller.fromDateController.value);
              // }

              if (controller.selectedDropdownLeaveID.value.isEmpty) {
                AppSnackBar.showGetXCustomSnackBar(
                  message: 'Please select first leave type.',
                );
              } else {
                Utils.closeKeyboard(context);

                // Check if the selected date is already the same as the last selected date.
                if (controller.lastSelectedDate != null &&
                    controller.lastSelectedDate ==
                        controller.fromDateController.value.text) {
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
                          if (controller
                              .periodController.value.text.isNotEmpty) {
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
            child: CommonInputField(
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
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: controller.selectedDropdownLeaveID.value != '1481',
            child: CommonInputField(
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
              hintText: "Period",
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
            visible: controller.selectedDropdownLeaveID.value == '1481',
            child: Column(
              children: [
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
                  child: CommonInputField(
                    textEditingController: controller.fromTimeController.value,
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
                              ((noOfHours - noOfHours.floor()) * 60).round(),
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
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textEditingController: controller.hourController.value,
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
                  textEditingController: controller.toTimeController.value,
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
                  textEditingController: controller.toDateController.value,
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
                          controller.selectedLeaveTypesDay?.value = value;
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
                      ),
                    ),
                  ],
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
            buttonText: 'Submit',
            onPressed: () {
              controller.validationWithAPI();
            },
            isLoading: controller.isSubmitLoading.value,
            isDisable: controller.isDisable.value,
          )
        ],
      )),
    );
  }
}
