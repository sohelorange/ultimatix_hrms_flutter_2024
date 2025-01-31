import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_balance/leave_balance_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_view.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../app/app_colors.dart';

class LeaveAppView extends GetView<LeaveController> {
  const LeaveAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: getLeaveView(context),
      ),
    ));
  }

  getLeaveView(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          //width: Utils.getScreenWidth(context: context) * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.color303E9F, AppColors.color7A1FA2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) => GestureDetector(
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                Scaffold.of(context).openDrawer();
                              }
                            },
                            child: const CommonAppImageSvg(
                              imagePath: AppImages.icBack,
                              height: 15,
                              width: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        CommonText(
                          text: 'Leave',
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.addLeaveRoute);
                    },
                    child: const CommonAppImageSvg(
                      imagePath: AppImages.profileAddIcon, // Default SVG image
                      height: 15,
                      width: 15,
                      fit: BoxFit.cover, // Ensures the image fills the space
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      // Adjust radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: const Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: controller.cmpImageUrl.value.isEmpty
                          ? const CommonAppImageSvg(
                              imagePath:
                                  AppImages.svgAvatar, // Default SVG image
                              height: 30,
                              width: 30,
                              fit: BoxFit
                                  .cover, // Ensures the image fills the space
                            )
                          : CommonAppImageSvg(
                              imagePath: controller
                                  .cmpImageUrl.value, // Use profile image URL
                              height: 30,
                              width: 30,
                              fit: BoxFit
                                  .cover, // Ensures the image fills the space
                            ),
                    ),
                  ),
                ],
              ),
              Container(
                //height: 40,
                decoration: BoxDecoration(
                    color: AppColors.colorWhite.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                  isScrollable: false,
                  controller: controller.leaveTabController,
                  physics: const ClampingScrollPhysics(),
                  dividerHeight: 0,
                  onTap: (i) {},
                  splashBorderRadius: BorderRadius.circular(10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.colorWhite, // Selected tab background
                  ),
                  indicatorColor: Colors.transparent,
                  // Remove default indicator line
                  automaticIndicatorColorAdjustment: true,
                  unselectedLabelColor: AppColors.colorWhite,
                  // Unselected text color
                  labelColor: AppColors.colorBlack,
                  // Selected text color
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                  labelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  tabs: const [
                    // Tab(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.transparent, // Unselected tab background
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: const Align(
                    //       alignment: Alignment.center,
                    //       child: Text("Balance"),
                    //     ),
                    //   ),
                    // ),
                    // Tab(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.transparent, // Unselected tab background
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: const Align(
                    //       alignment: Alignment.center,
                    //       child: Text("Status"),
                    //     ),
                    //   ),
                    // ),

                    //TODO : Custom Text
                    // CommonText(
                    //   padding: const EdgeInsets.all(12),
                    //   text: 'Balance',
                    //   fontWeight: AppFontWeight.w400,
                    //   fontSize: 14,
                    //   color: AppColors.color2F2F31,
                    // ),
                    // CommonText(
                    //   padding: const EdgeInsets.all(12),
                    //   text: 'Status',
                    //   fontWeight: AppFontWeight.w400,
                    //   fontSize: 14,
                    //   color: AppColors.color2F2F31,
                    // ),

                    Tab(
                      text: "Balance",
                    ),
                    Tab(
                      text: "Status",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).paddingOnly(top: 5),
        Expanded(
          child: TabBarView(
            controller: controller.leaveTabController,
            children: const [LeaveBalanceView(), LeaveStatusView()],
          ),
        ),
      ],
    );
  }
}
