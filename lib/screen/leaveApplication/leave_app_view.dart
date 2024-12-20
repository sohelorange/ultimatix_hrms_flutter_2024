import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveBalance/balance_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveBalance/balance_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveStatus/status_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leaveStatus/status_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leave_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_bottom_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../app/app_colors.dart';

class LeaveAppView extends GetView<LeaveController> {
  const LeaveAppView({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorAppBars, AppColors.colorAppBars],
          // Gradient colors
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.8, 0.9],
          // Stops for the gradient colors
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GestureDetector(
            onTap: () {
              Utils.closeKeyboard(context);
            },
            child: SafeArea(
              child: Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.colorAppBars,
                              AppColors.colorAppBars
                            ],
                            // Gradient colors
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.3, 0.7],
                            // Stops for the gradient colors
                            tileMode: TileMode.clamp,
                          ),
                        ),
                      ),
                      centerTitle: true,
                      leading: InkWell(
                        splashColor: AppColors.colorWhite,
                        onTap: () {
                          Get.back();
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, bottom: 10, right: 15),
                          child: CommonAppImage(
                            imagePath: AppImages.icarrowback,
                            height: 10,
                            width: 10,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: CommonText(
                        text: 'Leave',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.colorBlack,
                      ),
                      actions: [
                        InkWell(
                          splashColor: AppColors.colorWhite,
                          onTap: () {
                            Get.toNamed(AppRoutes.addLeaveRoute);
                          },
                          radius: 10,
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: CommonAppImage(
                              height: 20,
                              width: 20,
                              imagePath: AppImages.icadd2,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                      // bottom: tabBarView(),
                    ),
                    body: getLeaveView(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getLeaveView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.colorAppBars, AppColors.colorAppBars], // Gradient colors
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.3, 0.7], // Stops for the gradient colors
              tileMode: TileMode.clamp,
            ),
          ),
          height: Utils.getScreenHeight(context: context) / 15,
        ),
        Container(
          height: Utils.getScreenHeight(context: context),
          width: Utils.getScreenWidth(context: context),
          decoration: const BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.all(Radius.circular(25.0))
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.colorF2F2F2,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TabBar(
                  controller: controller.leaveTabController,
                  physics: const ClampingScrollPhysics(),
                  dividerHeight: 0,
                  onTap: (i) {},
                  splashBorderRadius: BorderRadius.circular(30),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.color7B1FA2,
                  ),
                  indicatorColor: AppColors.color7B1FA2,
                  automaticIndicatorColorAdjustment: true,
                  unselectedLabelColor: AppColors.colorBlack,
                  labelColor: AppColors.colorWhite,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
                  labelStyle: TextStyle(
                      fontSize: 14, fontWeight: AppFontWeight.w400),
                  tabs: const [
                    Tab(
                      text: "Balance",
                    ),
                    Tab(
                      text: "Status",
                    ),
                  ],
                ),
              ).paddingOnly(top: 10, left: 20, right: 20),
              Expanded(
                child: TabBarView(
                  controller: controller.leaveTabController,
                  children: const [
                    BalanceView(),
                    StatusView()
                  ],
                ),
              ),
            ],
          ),
        ).marginOnly(top: 10),
      ],
    );

  }


}