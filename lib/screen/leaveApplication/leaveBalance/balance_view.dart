import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveBalance/balance_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class BalanceView extends GetView<BalanceController> {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BalanceController());
    return SingleChildScrollView(
        child: Obx(
              () => Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width *
                    1.6, // Adjust container width as needed
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width *
                          0.8, // Adjust width as needed
                      child: CommonText(
                        text: 'Leave Balance',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("clickend");
                        _showYearDialog(context);
                      },
                      child: CommonAppImage(
                          height: 20, width: 20, imagePath: AppImages.iccalander2),
                    ),
                  ],
                ).marginOnly(left: 10),
              ),
              // controller.leavebalnceListResponse.value.code == 404 ?
              controller.isLoading.isTrue?
              Center(child: Utils.commonCircularProgress()):
              // Center(
              //   child: Column(
              //     children: [
              //       // CommonAppImage(
              //       //   imagePath: AppImages.icAddNew,
              //       //   height: 100,
              //       // ),
              //       CommonText(
              //         text: 'No Data Available',
              //         fontWeight: FontWeight.normal,
              //         fontSize: 17,
              //         color: AppColors.colorBlack,
              //       ),
              //     ],
              //   ),
              // ).paddingOnly(top: 10)
              // :
              controller.leavebalnceListResponse.value.data != null ?
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.leavebalnceListResponse.value.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Color cardColor = controller.colors[index % controller.colors.length];
                    return Card(
                        elevation: 4,
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: controller.leavebalnceListResponse.value.data![index].leaveName.toString(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.colorBlack,
                                ).paddingOnly(right: 60),
                                CommonText(
                                  text: '10 Days',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: AppColors.colorBlack,
                                ).paddingOnly(left: 50),
                                const SizedBox(
                                  width: 16.0,
                                ),
                              ],
                            ).paddingOnly(right: 10, top: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    CommonText(
                                      text: 'Opening',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color6B6D7A,
                                    ),
                                    CommonText(
                                      text: controller.leavebalnceListResponse.value.data![index].leaveOpening.toString(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.colorBlack,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: [
                                    CommonText(
                                      text: 'used',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color6B6D7A,
                                    ),
                                    CommonText(
                                      text: controller.leavebalnceListResponse.value.data![index].leaveUsed.toString(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.colorBlack,
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                          ],
                        )).paddingOnly(left: 20, right: 20, top: 10);
                  })
                  : Offstage()
            ],
          ),
        ));
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
                              controller.onLeavebalanceAPI(
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
                                    : controller.items.value
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
