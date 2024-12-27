import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_status_bar.dart';
import '../../utility/constants.dart';
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
    AppStatusBar.setStatusBarStyle(
      statusBarColor: AppColors.colorAppBar,
    );

    return SafeArea(
        child: Scaffold(
      appBar: DashAppBar(
        name: "Hello",
        designation: controller.userName.value,
        profileImageUrl: controller.userImageUrl.value,
        onProfileImageClick: () {
          Get.toNamed(AppRoutes.drawerRoute);
        },
        actions: [
          GestureDetector(
            onTap: () {
              controller.fetchDataInParallel();
            },
            child: const CommonAppImage(
              imagePath: AppImages.dashRefreshIcon,
              color: AppColors.colorDarkBlue,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.notificationAnnouncementRoute);
            },
            child: const CommonAppImage(
              imagePath: AppImages.dashNotificationIcon,
              color: AppColors.colorDarkBlue,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CommonAppImage(
            height: 30,
            width: 30,
            imagePath: controller.cmpImageUrl.value,
          ),
          Visibility(
            visible: false,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications,
                    // Placeholder for your notification icon
                    color: AppColors.colorBlack,
                    size: 25.0, // Icon size
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 13,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    // Padding around the badge
                    decoration: const BoxDecoration(
                      color: Colors.red, // Badge color (red)
                      shape: BoxShape.circle, // Circular shape for the badge
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 10.0,
                      minHeight: 10.0,
                    ),
                    child: const Text(
                      '9+',
                      style: TextStyle(
                        color: Colors.white, // Text color inside the badge
                        fontSize: 10.0, // Font size for the badge text
                        fontWeight: FontWeight.bold, // Text weight
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // body: IndexedStack(
      //   index: controller.selectedIndex.value,
      //   // Maintains state of selected tab
      //   children: [
      //     _dashboardUI(context),
      //     //const ExploreView(),
      //   ],
      // ),

      body: _dashboardUI(context),
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
        initialIndex: controller.selectedIndex.value,
        onTabSelected: controller.onBottomTabSelected,
      ),
    ));
  }

  Widget _dashboardUI(BuildContext context) {
    return CommonContainer(
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              _buildLocationInfo(),
              //Obx(() => _buildLocationInfo()),
              const SizedBox(
                height: 15,
              ),
              _buildUpcomingEvent(),
              const SizedBox(
                height: 15,
              ),
              _buildAttendanceSummary(context),
              //Obx(() => _buildAttendanceSummary()),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
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
                onTap: () {
                  if(controller.geofence_enable == 1){
                    Get.toNamed(AppRoutes.geofenceRoute);
                    print("geo--${controller.geofence_enable}");
                  } else {
                    Get.toNamed(AppRoutes.clockInRoute);
                    print("geo--${controller.geofence_enable}");
                  }
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
                      text: controller.checkInTime.value == '--:--' &&
                          controller.checkOutTime.value == '--:--'
                          ? 'Check In'
                          : controller.checkInTime.value.isNotEmpty &&
                          controller.checkOutTime.value.isNotEmpty
                          ? 'Check In'
                          : 'Check Out',
                      color: AppColors.colorWhite,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w500,
                    ),
                  ),
                ),
              )
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

  Widget _buildAttendanceSummary(BuildContext context) {
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
          controller.isLoading.value && controller.statusData.isEmpty
              ? SizedBox(
                  height: Utils.getScreenHeight(context: context) / 3.25,
                  child: Center(child: Utils.commonCircularProgress()))
              : controller.statusData.isEmpty
                  ? SizedBox(
                      height: Utils.getScreenHeight(context: context) / 3.25,
                      child: Center(
                        child: CommonText(
                          text: Constants.noDataMsg,
                          color: AppColors.colorDarkBlue,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    )
                  : CommonGridView(
                      statusData: controller.statusData,
                    ),
        ],
      ),
    );
  }
}
