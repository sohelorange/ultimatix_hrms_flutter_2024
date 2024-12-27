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
                          text: controller.leaveBalListResponse.value.message!,
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
    return CommonGradientButton(
      text: 'Leave Balance',
      imagePath: AppImages.leaveCalendarIcon, // Change the icon as needed
      onTap: () {
        _showYearDialog(context); // Define your on-tap behavior here
      },
    );
  }

  Widget _leaveBalanceListUI(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.leaveBalListResponse.value.data!.length,
          //physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Color cardColor =
                controller.colors[index % controller.colors.length];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    //color: Color(0X1C1F370D),
                    color: cardColor,
                    blurRadius: 0.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 0),
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
                        text: controller
                            .leaveBalListResponse.value.data![index].leaveName
                            .toString(),
                        fontWeight: AppFontWeight.w400,
                        fontSize: 14,
                        color: AppColors.colorDarkBlue,
                      ),
                      CommonText(
                        text:
                            '${(double.parse(controller.leaveBalListResponse.value.data![index].leaveOpening.toString()) - double.parse(controller.leaveBalListResponse.value.data![index].leaveUsed.toString())).toStringAsFixed(1)} Days',
                        fontWeight: AppFontWeight.w700,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
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
                              color: AppColors.color6B6D7A,
                            ),
                            CommonText(
                              text: controller.leaveBalListResponse.value
                                  .data![index].leaveOpening
                                  .toString(),
                              fontWeight: AppFontWeight.w500,
                              fontSize: 12,
                              color: AppColors.colorDarkBlue,
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
                              color: AppColors.color6B6D7A,
                            ),
                            CommonText(
                              text: controller.leaveBalListResponse.value
                                  .data![index].leaveUsed
                                  .toString(),
                              fontWeight: AppFontWeight.w500,
                              fontSize: 12,
                              color: AppColors.colorDarkBlue,
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
    );
  }

  void _showYearDialog(BuildContext context) {
    controller.selectedYear.value = 0;
    controller.selectedMonth.value = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.3, // 40% of screen height
            width: MediaQuery.of(context).size.width * 0.8,
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                if (constraints.maxWidth < 400) {
                  crossAxisCount = 2; // For smaller screens
                } else if (constraints.maxWidth < 800) {
                  crossAxisCount = 3; // For medium screens
                } else {
                  crossAxisCount = 4; // For larger screens
                }

                return Obx(
                  () => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 2),
                    itemCount: controller.selectedYear.value == 0
                        ? 6
                        : controller.items.length, // Total years
                    itemBuilder: (context, index) {
                      final year = DateTime.now().year + index;
                      return GestureDetector(
                        onTap: () {
                          if (controller.selectedYear.value == 0) {
                            controller.selectedYear.value = year;
                          } else {
                            if (controller.selectedYear.value != 0) {
                              controller.selectedMonth.value = index + 1;
                              controller.onLeaveBalanceAPI(
                                  controller.selectedYear.value,
                                  controller.selectedMonth.value);
                              controller.selectedYear.value = 0;
                              controller.selectedMonth.value = 0;
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Card(
                          child: Center(
                            child: Obx(
                              () => Text(
                                controller.selectedYear.value == 0
                                    ? year.toString()
                                    : controller.items
                                        .elementAt(index)
                                        .toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.selectedYear.value = 0;
                controller.selectedMonth.value = 0;
              },
              child: const Center(
                  child: Text(
                'Close',
                style: TextStyle(
                    color: AppColors.color68C1F,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )),
            ),
          ],
        );
      },
    );
  }
}
