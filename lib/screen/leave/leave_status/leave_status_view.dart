import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_date_picker.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';

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
              CommonText(
                text: 'From Date',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.color2F2F31,
              ),
              // const Text(
              //   "From Date",
              //   style: TextStyle(fontSize: 14, color: Colors.grey),
              // ),
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
              CommonText(
                text: 'To Date',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.color2F2F31,
              ),
              // const Text(
              //   "To Date",
              //   style: TextStyle(fontSize: 14, color: Colors.grey),
              // ),
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
          child: CommonButtonNew(
              buttonText: 'Change',
              onPressed: () {
                controller.onLeaveBalanceAPI(
                    controller.fromAPIDt.value, controller.toAPIDt.value);
              },
              isLoading: false),
        ).paddingOnly(top: 18)
      ],
    );
  }

  Widget _leaveStatusListUI(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        //height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: AppColors.colorF1EBFB,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.leaveStatusListResponse.value.data!.length,
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(10),
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
                              text:
                                  "${controller.leaveStatusListResponse.value.data![index].leaveName} (${controller.leaveStatusListResponse.value.data![index].leaveCode})",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.color2F2F31,
                            ),
                            Container(
                              height: 24,
                              //width: 80,
                              decoration: BoxDecoration(
                                color: controller.leaveStatusListResponse.value
                                            .data![index].applicationStatus
                                            .toString() ==
                                        'A'
                                    ? const Color(
                                        0XFF00ABA4) // Green for status 'A'
                                    : controller.leaveStatusListResponse.value
                                                .data![index].applicationStatus
                                                .toString() ==
                                            'P'
                                        ? const Color(
                                            0XFFB2AF76) // Amber for status 'P'
                                        : AppColors.colorRed
                                            .withValues(alpha: 0.80),
                                // Red for statuses 'C' or 'R',
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: CommonText(
                                  text: controller.leaveStatusListResponse.value
                                      .data![index].appStatus
                                      .toString(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorWhite,
                                ).paddingSymmetric(horizontal: 10),
                              ),
                            ),
                          ],
                        ),
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
                                  color: AppColors.color7B758E,
                                ),
                                CommonText(
                                  text: controller.leaveStatusListResponse.value
                                      .data![index].fromDate
                                      .toString(),
                                  fontWeight: AppFontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.color2F2F31,
                                ).paddingOnly(top: 2)
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
                                  color: AppColors.color7B758E,
                                ),
                                CommonText(
                                  text: controller.leaveStatusListResponse.value
                                      .data![index].toDate
                                      .toString(),
                                  fontWeight: AppFontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.color2F2F31,
                                ).paddingOnly(top: 2)
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
                                  color: AppColors.color7B758E,
                                ),
                                CommonText(
                                  text: controller.leaveStatusListResponse.value
                                      .data![index].leaveAppDays
                                      .toString(),
                                  fontWeight: AppFontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.color2F2F31,
                                ).paddingOnly(top: 2)
                              ],
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 10),
                      CommonText(
                        text: 'Reason',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 12,
                        color: AppColors.color7B758E,
                      ).paddingOnly(top: 10),
                      CommonText(
                        text: controller.leaveStatusListResponse.value
                            .data![index].leaveReason
                            .toString(),
                        fontWeight: FontWeight.w400,
                        maxLine: 3,
                        fontSize: 12,
                        color: AppColors.color2F2F31,
                      ).paddingOnly(top: 2),
                      CommonText(
                        text: 'Assigned As',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 12,
                        color: AppColors.color7B758E,
                      ).paddingOnly(top: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.leaveApprovalRoute, arguments: {
                            'LeaveAppId': controller.leaveStatusListResponse
                                .value.data![index].leaveApplicationId,
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    '',
                                    height: 40,
                                    width: 10,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const CommonAppImageSvg(
                                        imagePath: AppImages.svgAvatar,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
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
                            ).paddingOnly(top: 5),
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
      ),
    );
  }
}
