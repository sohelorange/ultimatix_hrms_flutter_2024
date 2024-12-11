import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_app_image_svg.dart';
import '../../widget/common_banner.dart';
import '../../widget/common_bottom_bar.dart';
import '../../widget/common_grid_view.dart';
import '../../widget/common_text.dart';
import '../../widget/dash_app_bar.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  //final NotificationServices _notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DashAppBar(
        name: "Hello",
        designation: "John Doe",
        profileImageUrl: "",
        actions: [
          GestureDetector(
            onTap: () {},
            child: const CommonAppImage(
              imagePath: AppImages.dashRefreshIcon,
              color: AppColors.colorDarkBlue,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: const CommonAppImage(
              imagePath: AppImages.dashNotificationIcon,
              color: AppColors.colorDarkBlue,
            ),
          ),
        ],
      ),
      body: CommonContainer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Obx(() => _buildLocationInfo()),
              const SizedBox(
                height: 15,
              ),
              _buildUpcomingEvent(),
              const SizedBox(
                height: 15,
              ),
              //Obx(() => _buildAttendanceSummary()),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CommonBottomNavBar(
        items: [
          BottomNavItem(
            label: "Home",
            selectedIconPath: AppImages.dashFillHomeIcon,
            unselectedIconPath: AppImages.dashUnFillHomeIcon,
          ),
          BottomNavItem(
            label: "Explore",
            selectedIconPath: AppImages.dashFillExploreIcon,
            unselectedIconPath: AppImages.dashUnFillExploreIcon,
          ),
          BottomNavItem(
            label: "Attendance",
            selectedIconPath: AppImages.dashFillAttendanceIcon,
            unselectedIconPath: AppImages.dashUnFillAttendanceIcon,
          ),
          BottomNavItem(
            label: "Leave",
            selectedIconPath: AppImages.dashFillLeaveIcon,
            unselectedIconPath: AppImages.dashUnFillLeaveIcon,
          ),
        ],
        initialIndex: 0,
        onTabSelected: (index) {
          //setState(() {});
        },
      ),
    ));
  }

  Widget _buildLocationInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0X1C1F370D),
            // Light gray color for shadow
            blurRadius: 4.0,
            // Increase the blur for a more spread-out shadow
            spreadRadius: 1.0,
            // Small spread to create a more pronounced shadow
            offset: Offset(
                0, 0), // Offset to simulate elevation effect (vertical shadow)
          ),
        ],
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Working Hours',
                    color: AppColors.colorDarkBlue,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  const SizedBox(height: 2.5),
                  CommonText(
                    text: controller.workingHours.value,
                    color: AppColors.purpleSwatch,
                    fontSize: 24,
                    fontWeight: AppFontWeight.w700,
                  ),
                  const SizedBox(height: 2.5),
                  CommonText(
                    text: controller.todayDayDate.value,
                    color: AppColors.colorDarkBlue,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                ],
              )),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.liveTrackingRoute);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: AppColors.colorDarkGray,
                    //     blurRadius: 0.0,
                    //     spreadRadius: 0.0,
                    //     offset: Offset(
                    //         0, 0),
                    //   ),
                    // ],
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.purpleSwatch,
                  ),
                  child: Center(
                    child: CommonText(
                      textAlign: TextAlign.center,
                      text: 'Check In/Out',
                      color: AppColors.colorWhite,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w500,
                    ),
                  ),
                ),
              ),
              //SizedBox(width: 120,child: CommonButton(buttonText: 'Check In', onPressed: (){}, isLoading: false))
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: AppColors.colorDarkGray,
                    //     blurRadius: 0.0,
                    //     spreadRadius: 0.0,
                    //     offset: Offset(
                    //         0, 0),
                    //   ),
                    // ],
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.colorF7F8FC,
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CommonAppImageSvg(
                        imagePath: AppImages.dashClockIcon,
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover, // Ensures the image fills the space
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Vertically center the content
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align content to the start (left)
                        children: [
                          CommonText(
                            textAlign: TextAlign.start,
                            text: 'Check In',
                            color: AppColors.color6B6D7A,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w400,
                          ),
                          CommonText(
                            textAlign: TextAlign.start,
                            text: controller.checkInTime.value,
                            color: AppColors.colorDarkBlue,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: AppColors.colorDarkGray,
                    //     blurRadius: 0.0,
                    //     spreadRadius: 0.0,
                    //     offset: Offset(
                    //         0, 0),
                    //   ),
                    // ],
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.colorF7F8FC,
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CommonAppImageSvg(
                        imagePath: AppImages.dashClockIcon,
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover, // Ensures the image fills the space
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            textAlign: TextAlign.start,
                            text: 'Check Out',
                            color: AppColors.color6B6D7A,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w400,
                          ),
                          CommonText(
                            textAlign: TextAlign.start,
                            text: controller.checkOutTime.value,
                            color: AppColors.colorDarkBlue,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CommonText(
            //textAlign: TextAlign.center,
            maxLine: 5,
            text: controller.address.value,
            color: AppColors.colorDarkBlue,
            fontSize: 14,
            fontWeight: AppFontWeight.w400,
          )
        ],
      ),
    );
  }

  Widget _buildUpcomingEvent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            textAlign: TextAlign.start,
            text: 'Upcoming Holiday & Event',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w500,
          ),
          const SizedBox(height: 10),
          CommonCarouselBanner(
            images: controller.listEvent,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            textAlign: TextAlign.start,
            text: controller.currentMonthYear + ' Attendance',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w500,
          ),
          const SizedBox(height: 10),
          CommonGridView(
            statusData: controller.statusData,
          ),
        ],
      ),
    );
  }
}
