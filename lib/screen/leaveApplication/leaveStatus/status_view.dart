import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveStatus/status_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../widget/common_app_image.dart';

class StatusView extends GetView<StatusController> {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color161F59, AppColors.color631983],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.3, 0.7],
              // Stops for the gradient colors
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              // Set background transparent
              shadowColor: Colors.transparent,
              // Remove shadow to match gradient
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Match container radius
              ),
            ),
            onPressed: () {
              // print('server redirect');
              // Get.offAllNamed(AppRoutes.serverRoute);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonAppImage(
                  imagePath: AppImages.iccalander2,
                  height: 25,
                  width: 25,
                  color: AppColors.colorWhite,
                  fit: BoxFit.fill,
                ).marginOnly(right: 5),
                CommonText(
                  padding: const EdgeInsets.only(left: 15),
                  text: 'Check Leave History',
                  color: AppColors.colorWhite,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w500,
                ),
              ],
            ),
          ),
        ).paddingOnly(left: 20, right: 20, top: 20),
        CommonText(
          padding: const EdgeInsets.only(left: 15),
          text: 'Upcomming Leave Request',
          color: AppColors.colorBlack,
          fontSize: 14,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 20, right: 20),
        Expanded(
            child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              // itemCount: controller.travelAppListResponse.value.data!.length,
              itemCount: 18,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 290,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.leaveRequestDetailRoute);
                    },
                    child:Card(
                        elevation: 4,
                        color: AppColors.colorWhite,
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
                                  text: 'Annual Leave  ',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.colorBlack,
                                ),
                                Container(
                                  height: 40,
                                  width: 90,
                                  child:Card(
                                      color: AppColors.colorac6cc,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: CommonText(
                                          text: 'Pending',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: AppColors.colorF68C1F,
                                        ),
                                      )

                                  ),
                                ),
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 10),
                            Divider(
                              color:
                              AppColors.colorBlack.withOpacity(0.2),
                            ).paddingOnly(left: 10, right: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    CommonText(
                                      text: 'Leave From',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color9C9BA2,
                                    ),
                                    CommonText(
                                      text: '06/09/2024',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(top: 5)
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: [
                                    CommonText(
                                      text: 'Leave To',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color9C9BA2,
                                    ),
                                    CommonText(
                                      text: '07/12/2024',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(top: 5)
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: [
                                    CommonText(
                                      text: 'Period',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color9C9BA2,
                                    ),
                                    CommonText(
                                      text: '1 Days',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(top: 5)
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 10, right: 50, top: 5),
                            Divider(
                              color:
                              AppColors.colorBlack.withOpacity(0.2),
                            ).paddingOnly(left: 10, right: 10),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CommonText(
                                      text: 'Reason',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color9C9BA2,
                                    ),
                                    CommonText(
                                      text: 'Testing',
                                      fontWeight: FontWeight.w500,
                                      maxLine: 3,
                                      fontSize: 13,
                                      color: AppColors.colorBlack,
                                    ).paddingOnly(top: 5)
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 5),
                            Divider(
                              color:
                              AppColors.colorBlack.withOpacity(0.2),
                            ).paddingOnly(left: 10, right: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: 'Assigned As',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: AppColors.color6B6D7A,
                                    ).paddingOnly(right:100),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        CommonAppImage(
                                          imagePath: AppImages.icavtar,
                                          height: 40,
                                          width: 40,
                                        ),
                                        CommonText(
                                          text: '0058-Mr. Jai Singh',
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                          fontSize: 13,
                                          color: AppColors.colorBlack,
                                        ).paddingOnly(left: 20)
                                      ],
                                    ).paddingOnly(top: 5)
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 10, right: 10, top: 5),
                          ],
                        )).paddingOnly(left: 20, right: 20, top: 10)
                  )

                );
              }),
        )),
        CommonText(
          padding: const EdgeInsets.only(left: 15),
          text: 'Leave History',
          color: AppColors.colorBlack,
          fontSize: 14,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 20, right: 20),
        Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  // itemCount: controller.travelAppListResponse.value.data!.length,
                  itemCount: 18,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 290,
                        child:  Card(
                            elevation: 4,
                            color: AppColors.colorWhite,
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
                                      text: 'Sick Leave  ',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.colorBlack,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 90,
                                      child:Card(
                                          color: AppColors.color79C12D,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                          child: Center(
                                            child: CommonText(
                                              text: 'Approve',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: AppColors.color53A100,
                                            ),
                                          )

                                      ),
                                    ),
                                  ],
                                ).paddingOnly(left: 10, right: 10, top: 10),
                                Divider(
                                  color:
                                  AppColors.colorBlack.withOpacity(0.2),
                                ).paddingOnly(left: 10, right: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        CommonText(
                                          text: 'Leave From',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: AppColors.color9C9BA2,
                                        ),
                                        CommonText(
                                          text: '06/09/2024',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: AppColors.colorBlack,
                                        ).paddingOnly(top: 5)
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        CommonText(
                                          text: 'Leave To',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: AppColors.color9C9BA2,
                                        ),
                                        CommonText(
                                          text: '07/12/2024',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: AppColors.colorBlack,
                                        ).paddingOnly(top: 5)
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        CommonText(
                                          text: 'Period',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: AppColors.color9C9BA2,
                                        ),
                                        CommonText(
                                          text: '1 Days',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: AppColors.colorBlack,
                                        ).paddingOnly(top: 5)
                                      ],
                                    ),
                                  ],
                                ).paddingOnly(left: 10, right: 50, top: 5),
                                Divider(
                                  color:
                                  AppColors.colorBlack.withOpacity(0.2),
                                ).paddingOnly(left: 10, right: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        CommonText(
                                          text: 'Reason',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: AppColors.color9C9BA2,
                                        ),
                                        CommonText(
                                          text: 'Testing',
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                          fontSize: 13,
                                          color: AppColors.colorBlack,
                                        ).paddingOnly(top: 5)
                                      ],
                                    ),
                                  ],
                                ).paddingOnly(left: 10, right: 10, top: 5),
                                Divider(
                                  color:
                                  AppColors.colorBlack.withOpacity(0.2),
                                ).paddingOnly(left: 10, right: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: 'Assigned As',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: AppColors.color6B6D7A,
                                        ).paddingOnly(right:100),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            CommonAppImage(
                                              imagePath: AppImages.icavtar,
                                              height: 40,
                                              width: 40,
                                            ),
                                            CommonText(
                                              text: '0058-Mr. Jai Singh',
                                              fontWeight: FontWeight.w500,
                                              maxLine: 3,
                                              fontSize: 13,
                                              color: AppColors.colorBlack,
                                            ).paddingOnly(left: 20)
                                          ],
                                        ).paddingOnly(top: 5)
                                      ],
                                    ),
                                  ],
                                ).paddingOnly(left: 10, right: 10, top: 5),
                              ],
                            )).paddingOnly(left: 20, right: 20, top: 10)
                    );
                  }),
            )),
      ],
    );
  }

}
