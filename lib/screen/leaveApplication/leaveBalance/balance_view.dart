import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveBalance/balance_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class BalanceView extends GetView<BalanceController> {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:  Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 1.6, // Adjust container width as needed
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
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
                      // if (controller.fromDate == "") {
                      //   controller.fromDate = await Utils.selectDateNew(
                      //       context: context);
                      // }
                      // else if(controller.toDate == "") {
                      //   controller.toDate = await Utils.selectDateNew(context: context);
                      // }
                    },
                    child: CommonAppImage(
                        height: 20,
                        width: 20,
                        imagePath: AppImages.iccalander2),
                  ),
                ],
              ).marginOnly(left: 10),
            ),
            // controller.travelAppListResponse.value.code == 404
            //     ?
            Center(
              child: Column(
                children: [
                  // CommonAppImage(
                  //   imagePath: AppImages.icAddNew,
                  //   height: 100,
                  // ),
                  // CommonText(
                  //   text: 'No Data Available',
                  //   fontWeight: FontWeight.normal,
                  //   fontSize: 17,
                  //   color: AppColors.colorBlack,
                  // ),
                ],
              ),
            ).paddingOnly(top: 10),
            // :
            ListView.builder(
                shrinkWrap: true,
                // itemCount: controller.travelAppListResponse.value.data!.length,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      elevation: 4,
                      // color: controller.colors[index],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText(
                                text: 'Annual Leave (AL)',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.colorBlack,
                              ),
                              CommonText(
                                text: '10 Days',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppColors.colorBlack,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                            ],
                          ).paddingOnly(left: 10, right: 10, top: 10),
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
                                    text: '10.0',
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
                                    text: '0.0',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: AppColors.colorBlack,
                                  ),
                                ],
                              ),
                            ],
                          ).paddingOnly(left: 10, right: 10, top: 10),
                        ],
                      )
                  ).paddingOnly(left: 20, right: 20, top: 10);
                })
          ],
        )
    );
  }
}