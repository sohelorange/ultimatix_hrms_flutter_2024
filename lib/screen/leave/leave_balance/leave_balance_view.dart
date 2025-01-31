import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_balance/leave_balance_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_gradient_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../widget/common_app_image_svg.dart';

class LeaveBalanceView extends GetView<LeaveBalanceController> {
  const LeaveBalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LeaveBalanceController());

    return Obx(
      () => Column(
        children: [
          _leaveBalanceUI(context),
          controller.isLoading.isTrue
              ? Expanded(child: Center(child: Utils.commonCircularProgress()))
              : controller.leaveBalListResponse.value.data != null
                  ? _leaveBalanceListUI(context)
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
                          text: controller.leaveBalListResponse.value.message !=
                                  null
                              ? controller.leaveBalListResponse.value.message!
                              : controller.errorMsg.value,
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

  Widget _leaveBalanceUI(BuildContext context) {
    // Get the current year and month or selected ones
    //final int currentYear = DateTime.now().year;
    final int currentMonth = DateTime.now().month;

    // Get selected year, using controller's selected value if available
    // final String selectedYear = controller.selectedYearIndex.value == -1
    //     ? currentYear.toString()
    //     : (currentYear + controller.selectedYearIndex.value).toString();

    // Get the selected month or current month
    final String selectedMonth = controller.selectedMonthIndex.value == -1
        ? [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ][currentMonth - 1] // Convert month index to name
        : [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ][controller.selectedMonthIndex.value];

    return CommonGradientButton(
      text: '$selectedMonth ${controller.selectedYear.toString()} Balance',
      imagePath: AppImages.leaveCalendarIcon,
      onTap: () {
        controller.showYearDialog(context);
      },
    );
  }

  Widget _leaveBalanceListUI(BuildContext context) {
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
            itemCount: controller.leaveBalListResponse.value.data!.length,
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: controller
                              .leaveBalListResponse.value.data![index].leaveName
                              .toString(),
                          fontWeight: AppFontWeight.w400,
                          fontSize: 14,
                          color: AppColors.color2F2F31,
                        ),
                        CommonText(
                          text:
                              '${(double.parse(controller.leaveBalListResponse.value.data![index].leaveOpening.toString()) - double.parse(controller.leaveBalListResponse.value.data![index].leaveUsed.toString())).toStringAsFixed(1)} Days',
                          fontWeight: AppFontWeight.w500,
                          fontSize: 14,
                          color: AppColors.color2F2F31,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'Opening',
                                fontWeight: AppFontWeight.w400,
                                fontSize: 12,
                                color: AppColors.color7B758E,
                              ),
                              CommonText(
                                text: double.parse(controller
                                        .leaveBalListResponse
                                        .value
                                        .data![index]
                                        .leaveOpening
                                        .toString())
                                    .toStringAsFixed(1),
                                fontWeight: AppFontWeight.w400,
                                fontSize: 14,
                                color: AppColors.color2F2F31,
                              ).paddingOnly(top: 2),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'Used',
                                fontWeight: AppFontWeight.w400,
                                fontSize: 12,
                                color: AppColors.color7B758E,
                              ),
                              CommonText(
                                text: double.parse(controller
                                        .leaveBalListResponse
                                        .value
                                        .data![index]
                                        .leaveUsed
                                        .toString())
                                    .toStringAsFixed(1),
                                fontWeight: AppFontWeight.w400,
                                fontSize: 14,
                                color: AppColors.color2F2F31,
                              ).paddingOnly(top: 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ), // Your widget inside the Container
              );
            }),
      ),
    );
  }
}
