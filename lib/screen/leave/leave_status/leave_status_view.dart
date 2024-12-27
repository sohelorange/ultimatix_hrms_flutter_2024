import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_date_picker.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_routes.dart';

class LeaveStatusView extends GetView<LeaveStatusController> {
  const LeaveStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LeaveStatusController());
    return Obx(
      () => Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          _leaveCheckHistoryUI(context),
          controller.isLoading.isTrue
              ? Expanded(child: Center(child: Utils.commonCircularProgress()))
              : controller.leaveStatusListResponse.value.data != null
                  ? _leaveStatusListUI(context)
                  : Expanded(
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
                          text:
                              controller.leaveStatusListResponse.value.message!,
                          // text: controller
                          //     .leaveStatusListResponse.value.message ??
                          //     "No data available",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.colorDarkBlue,
                        ),
                      ],
                    ))
        ],
      ),
    );
  }

  Widget _leaveCheckHistoryUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "From Date",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              CommonDatePicker(
                text: controller.formattedFromDate.value,
                imagePath: AppImages.leaveCalendarIcon,
                // Change the icon as needed
                onTap: () async {
                  final DateTime? selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1999),
                    lastDate: DateTime(
                        int.parse(AppDatePicker.currentYear()), 12, 31),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );

                  if (selected != null) {
                    controller.formattedFromDate.value =
                        AppDatePicker.formatDateWithDDMMYYYY(selected);
                    controller.fromDateController.value.text =
                        controller.formattedFromDate.value;

                    controller.fromAPIDt.value =
                        AppDatePicker.convertDateTimeFormat(
                            controller.formattedFromDate.value,
                            'dd/MM/yyyy',
                            'yyyy-MM-dd');
                  }
                },
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "To Date",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              CommonDatePicker(
                text: controller.formattedToDate.value,
                imagePath: AppImages.leaveCalendarIcon,
                // Change the icon as needed
                onTap: () async {
                  final DateTime? selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1999),
                    lastDate: DateTime(
                        int.parse(AppDatePicker.currentYear()), 12, 31),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );

                  if (selected != null) {
                    controller.formattedToDate.value =
                        AppDatePicker.formatDateWithDDMMYYYY(selected);
                    controller.toDateController.value.text =
                        controller.formattedToDate.value;

                    controller.toAPIDt.value =
                        AppDatePicker.convertDateTimeFormat(
                            controller.formattedToDate.value,
                            'dd/MM/yyyy',
                            'yyyy-MM-dd');
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 120,
          height: 40,
          child: CommonButton(
              buttonText: 'Change',
              onPressed: () {
                controller.onLeaveBalanceAPI(
                    controller.fromAPIDt.value, controller.toAPIDt.value);
              },
              isLoading: controller.isLoading.value),
        ).paddingOnly(top: 18)
      ],
    );
  }

  Widget _leaveStatusListUI(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.leaveStatusListResponse.value.data!.length,
          //physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.leaveRequestDetailRoute,
                            arguments: {
                              'leaveData': controller
                                  .leaveStatusListResponse.value.data![index],
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: controller.leaveStatusListResponse.value
                                .data![index].leaveCode
                                .toString(),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.colorBlack,
                          ),
                          Container(
                            height: 40,
                            //width: 80,
                            decoration: BoxDecoration(
                              color: controller.leaveStatusListResponse.value
                                          .data![index].applicationStatus
                                          .toString() ==
                                      'A'
                                  ? AppColors.colorGreen
                                      .withOpacity(0.1) // Green for status 'A'
                                  : controller.leaveStatusListResponse.value
                                              .data![index].applicationStatus
                                              .toString() ==
                                          'P'
                                      ? AppColors.colorAmber.withOpacity(
                                          0.1) // Amber for status 'P'
                                      : AppColors.colorRed.withOpacity(0.1),
                              // Red for statuses 'C' or 'R',
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: controller
                                              .leaveStatusListResponse
                                              .value
                                              .data![index]
                                              .applicationStatus
                                              .toString() ==
                                          'A'
                                      ? AppColors.colorGreen.withOpacity(
                                          0.1) // Green for status 'A'
                                      : controller
                                                  .leaveStatusListResponse
                                                  .value
                                                  .data![index]
                                                  .applicationStatus
                                                  .toString() ==
                                              'P'
                                          ? AppColors.colorAmber
                                              .withOpacity(0.1)
                                          : AppColors.colorRed.withOpacity(0.1),
                                  blurRadius: 0.0,
                                  spreadRadius: 1.0,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Center(
                              child: CommonText(
                                text: controller.leaveStatusListResponse.value
                                    .data![index].appStatus
                                    .toString(),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: controller.leaveStatusListResponse.value
                                            .data![index].applicationStatus
                                            .toString() ==
                                        'A'
                                    ? AppColors
                                        .colorGreen // Green for status 'A'
                                    : controller.leaveStatusListResponse.value
                                                .data![index].applicationStatus
                                                .toString() ==
                                            'P'
                                        ? AppColors
                                            .colorAmber // Amber for status 'P'
                                        : AppColors.colorRed,
                              ).paddingSymmetric(horizontal: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.colorBlack.withOpacity(0.2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'Leave From',
                                fontWeight: AppFontWeight.w400,
                                fontSize: 12,
                                color: AppColors.colorDarkGray,
                              ),
                              CommonText(
                                text: controller.leaveStatusListResponse.value
                                    .data![index].fromDate
                                    .toString(),
                                fontWeight: AppFontWeight.w500,
                                fontSize: 12,
                                color: AppColors.colorDarkBlue,
                              ).paddingOnly(top: 5)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'Leave To',
                                fontWeight: AppFontWeight.w400,
                                fontSize: 12,
                                color: AppColors.colorDarkGray,
                              ),
                              CommonText(
                                text: controller.leaveStatusListResponse.value
                                    .data![index].toDate
                                    .toString(),
                                fontWeight: AppFontWeight.w500,
                                fontSize: 12,
                                color: AppColors.colorDarkBlue,
                              ).paddingOnly(top: 5)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'Period',
                                fontWeight: AppFontWeight.w400,
                                fontSize: 12,
                                color: AppColors.colorDarkGray,
                              ),
                              CommonText(
                                text: controller.leaveStatusListResponse.value
                                    .data![index].leaveAppDays
                                    .toString(),
                                fontWeight: AppFontWeight.w500,
                                fontSize: 12,
                                color: AppColors.colorDarkBlue,
                              ).paddingOnly(top: 5)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.colorBlack.withOpacity(0.2),
                    ),
                    CommonText(
                      text: 'Reason',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.colorDarkGray,
                    ),
                    CommonText(
                      text: controller.leaveStatusListResponse.value
                          .data![index].leaveReason
                          .toString(),
                      fontWeight: FontWeight.w400,
                      maxLine: 3,
                      fontSize: 12,
                      color: AppColors.colorDarkBlue,
                    ),
                    Divider(
                      color: AppColors.colorBlack.withOpacity(0.2),
                    ),
                    CommonText(
                      text: 'Assigned As',
                      fontWeight: AppFontWeight.w400,
                      fontSize: 12,
                      color: AppColors.color6B6D7A,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.leaveApprovalRoute, arguments: {
                          'LeaveAppId': controller.leaveStatusListResponse.value
                              .data![index].leaveApplicationId,
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CommonAppImageSvg(
                                imagePath: AppImages.svgAvatar,
                                height: 40,
                                width: 40,
                              ).paddingOnly(right: 10),
                              CommonText(
                                text: controller.leaveStatusListResponse.value
                                    .data![index].seniorEmployee
                                    .toString(),
                                fontWeight: AppFontWeight.w500,
                                maxLine: 3,
                                fontSize: 12,
                                color: AppColors.colorDarkBlue,
                              )
                            ],
                          ).paddingOnly(top: 10),
                          const CommonAppImageSvg(
                            imagePath: AppImages.settingsRightArrowIcon,
                            height: 14,
                            width: 8,
                            fit: BoxFit
                                .cover, // Ensures the image fills the space
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
