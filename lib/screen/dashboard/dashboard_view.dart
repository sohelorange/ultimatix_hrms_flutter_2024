import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_latest.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_drawer.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_explore_grid_view_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_grid_view_new.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_status_bar.dart';
import '../../utility/constants.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_app_image_svg.dart';
import '../../widget/common_bottom_bar.dart';
import '../../widget/common_text.dart';
import 'dash_board_controller.dart';

class DashboardView extends GetView<DashController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusBar.setStatusBarStyle(
      statusBarColor: AppColors.colorWhite,
    );

    return SafeArea(
        child: Scaffold(
      appBar: CommonNewAppBar(
        title: "Dashboard",
        //leadingIconSvg: Icons.menu,
        leadingIconSvg: AppImages.ic_menu, // Menu icon
        onLeadingIconTap: () {
          Scaffold.of(context).openDrawer();
        },
        trailingWidgets: [
          GestureDetector(
            onTap: () {
              controller.fetchDataInParallel();
            },
            child: const CommonAppImage(
              imagePath: AppImages.dashRefreshIcon,
              color: AppColors.colorWhite,
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
              color: AppColors.colorWhite,
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
                      imagePath: AppImages.svgAvatar, // Default SVG image
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover, // Ensures the image fills the space
                    )
                  : CommonAppImageSvg(
                      imagePath:
                          controller.cmpImageUrl.value, // Use profile image URL
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover, // Ensures the image fills the space
                    ),
            ),
          ),
        ],
      ),
      //drawer: const AppDrawer(),
      drawer: CommonAppDrawer(
        items: const [
          CommonDrawerItem(
            icon: AppImages.drawerApprovalsIcon, // Your icon file path
            text: 'Approval',
          ),
          CommonDrawerItem(
            icon: AppImages.drawerSalaryIcon, // Your icon file path
            text: 'Salary',
          ),
          CommonDrawerItem(
            icon: AppImages.drawerLiveTrackingIcon, // Your icon file path
            text: 'Live Tracking',
          ),
          CommonDrawerItem(
            icon: AppImages.drawerHolidayIcon, // Your icon file path
            text: 'Holiday',
          ),
          CommonDrawerItem(
            icon: AppImages.drawerPolicyIcon, // Your icon file path
            text: 'Policy & Document',
          ),
          CommonDrawerItem(
            icon: AppImages.drawerSurveyIcon, // Your icon file path
            text: 'Survey',
          ),
          CommonDrawerItem(
            icon: AppImages.drawerSettingIcon, // Your icon file path
            text: 'Setting',
          ),
          CommonDrawerItem(
            icon: AppImages.dashLogoutIcon, // Your icon file path
            text: 'Logout',
          ),
        ],
        onTabSelected: controller.onDrawerTabSelected,
        profileValueNotifier: controller.profileValueNotifier,
        nameValueNotifier: controller.nameValueNotifier,
        designationValueNotifier: controller.designationValueNotifier,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Visibility(
              visible: false,
              child: PreferredSize(
                preferredSize: const Size.fromHeight(58),
                child: CommonLatestAppBar(
                  title: "Dashboard",
                  leadingIcon: Icons.menu, // Menu icon
                  onLeadingIconTap: () {
                    // Action for menu icon, open drawer
                    Scaffold.of(context).openDrawer();
                  },
                  trailingWidgets: [
                    IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {
                        // Action for notifications icon
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        // Action for settings icon
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: _dashboardUI(context)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            isScrollControlled: true, // Allow full-screen behavior
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.65, // Full height on opening
                //maxChildSize: 0.8, // Full height allowed
                //minChildSize: 0.5, // Minimum height
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: CommonExploreGridViewNew(
                      gridItems: controller.exploreItems,
                      selectedIndex: controller.selectedExploreIndex.value,
                      onItemTap: (index) {
                        Get.back();
                        controller.selectedExploreIndex.value = index;
                        controller.handleMenuNavigation(index);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
        shape: const CircleBorder(),
        child: const CommonAppImageSvg(
          imagePath: AppImages.svgMenu, // Default SVG image
          height: 60,
          width: 60,
          fit: BoxFit.cover, // Ensures the image fills the space
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
            label: "Setting",
            selectedIconPath: AppImages.dashFillSettingIcon,
            unselectedIconPath: AppImages.dashUnFillSettingIcon,
          ),
        ],
        initialIndex: controller.selectedIndex.value,
        onTabSelected: controller.onBottomTabSelected,
      ),
    ));
  }

  Widget _dashboardUI(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileInfoUI(),
            const SizedBox(
              height: 10,
            ),
            attendanceInfoUI(context),
            const SizedBox(
              height: 10,
            ),
            _leaveApprovalInfoUI(),
            const SizedBox(
              height: 5,
            ),
            _regularizationApprovalInfoUI(),
            const SizedBox(
              height: 5,
            ),
            _cancellationApprovalInfoUI(),
            const SizedBox(
              height: 10,
            ),
            _locationInfoUI(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfoUI() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: ValueListenableBuilder<String>(
                  valueListenable: controller.profileValueNotifier,
                  // A ValueNotifier wrapping profileImageUrl
                  builder: (context, profileImageUrl, child) {
                    if (profileImageUrl.isNotEmpty) {
                      return Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: AppColors.color303E9F,
                            width: 2, // Set border width
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            profileImageUrl,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const CommonAppImageSvg(
                                imagePath: AppImages.svgAvatar,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: AppColors.color303E9F,
                            width: 2,
                          ),
                        ),
                        child: const CommonAppImageSvg(
                          imagePath: AppImages.svgAvatar,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    text: 'Last Update : ${AppDatePicker.currentDate()}',
                    color: AppColors.color2F2F31,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  const SizedBox(height: 2.5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.profileRoute);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.color7A1FA2, // Left color
                            //AppColors.color7A1FA2, // Center and Right color
                            AppColors.color303E9F, // Center and Right color
                          ],
                          stops: [0.05, 0.55],
                          tileMode: TileMode.mirror,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Center(
                        child: CommonText(
                          textAlign: TextAlign.center,
                          text: 'My Profile',
                          color: AppColors.colorWhite,
                          fontSize: 16,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                //text: controller.workingHours.value,
                //text: AppTimePicker.currentTime12(),
                text: controller.currentTime.value,
                color: AppColors.color6D24A1,
                fontSize: 18,
                fontWeight: AppFontWeight.w600,
              ),
              CommonText(
                text: controller.todayDayDate.value,
                color: AppColors.color2F2F31,
                fontSize: 14,
                fontWeight: AppFontWeight.w400,
              ),
            ],
          ).paddingOnly(top: 10),
        ],
      ),
    );
  }

  Widget attendanceInfoUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.color7A1FA2,
                AppColors.color303E9F,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                textAlign: TextAlign.start,
                text: controller.currentMonthYear.value,
                color: AppColors.colorWhite,
                fontSize: 14,
                fontWeight: AppFontWeight.w400,
              ),
              const CommonAppImageSvg(
                imagePath: AppImages.settingsRightArrowIcon,
                height: 14,
                width: 8,
                color: AppColors.colorWhite,
                fit: BoxFit.cover, // Ensures the image fills the space
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        controller.isLoading.value && controller.attendanceStatusData.isEmpty
            ? SizedBox(
                height: Utils.getScreenHeight(context: context) / 6,
                child: Center(child: Utils.commonCircularProgress()))
            : controller.attendanceStatusData.isEmpty
                ? SizedBox(
                    height: Utils.getScreenHeight(context: context) / 6,
                    child: Center(
                      child: CommonText(
                        text: Constants.noDataMsg,
                        color: AppColors.colorDarkBlue,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ),
                  )
                : CommonGridViewNew(
                    statusData: controller.attendanceStatusData,
                  ),
      ],
    );
  }

  Widget _leaveApprovalInfoUI() {
    return GestureDetector(
      onTap: () {
        if (controller.leaveApprovalCount.value == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Leave Approval Request...');
        } else {
          Get.toNamed(AppRoutes.leaveManagerApprovalRoute);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.colorF1EBFB,
          //color: AppColors.color8957DD.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Leave Approval',
              color: AppColors.color8957DD,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ),
            CommonText(
              text: controller.leaveApprovalCount.value,
              color: AppColors.color2F2F31,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ),
          ],
        ), // Your widget inside the Container
      ),
    );
  }

  Widget _regularizationApprovalInfoUI() {
    return GestureDetector(
      onTap: () {
        if (controller.attendanceCount.value == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Regularization Approval Request...');
        } else {
          //Get.toNamed(AppRoutes.leaveManagerApprovalRoute);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.colorEEFAFE,
          //color: AppColors.color0085FF.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Regularization Approval',
              color: AppColors.color0085FF,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ),
            CommonText(
              text: controller.attendanceCount.value,
              color: AppColors.color2F2F31,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ),
          ],
        ), // Your widget inside the Container
      ),
    );
  }

  Widget _cancellationApprovalInfoUI() {
    return GestureDetector(
      onTap: () {
        if (controller.leaveCancelCount.value == '0') {
          AppSnackBar.showGetXCustomSnackBar(
              message: 'No Cancellation Approval Request...');
        } else {
          //Get.toNamed(AppRoutes.leaveManagerApprovalRoute);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          //color: AppColors.color303E9F,
          color: AppColors.color303E9F.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Cancellation Approval',
              color: AppColors.color303E9F,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ),
            CommonText(
              text: controller.leaveCancelCount.value,
              color: AppColors.color2F2F31,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ),
          ],
        ), // Your widget inside the Container
      ),
    );
  }

  Widget _locationInfoUI() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            //text: controller.workingHours.value,
            text: 'Last Clocking',
            color: AppColors.color6D24A1,
            fontSize: 18,
            fontWeight: AppFontWeight.w600,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorWhite,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CommonAppImageSvg(
                            imagePath: AppImages.dashClockingIcon,
                            height: 20,
                            width: 20,
                            fit: BoxFit
                                .cover, // Ensures the image fills the space
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CommonText(
                            text: controller.lstClockingDate.value,
                            color: AppColors.color2F2F31,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w500,
                          ),
                          CommonText(
                            text: '.',
                            color: AppColors.color6D24A1,
                            fontSize: 20,
                            fontWeight: AppFontWeight.w900,
                          ).marginOnly(left: 5, right: 5),
                          CommonText(
                            text: controller.lstClockingTime.value,
                            color: AppColors.color2F2F31,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w500,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(
                        maxLine: 3,
                        overflow: TextOverflow.ellipsis,
                        text: controller.address.value,
                        color: AppColors.color7B758E,
                        fontSize: 12,
                        fontWeight: AppFontWeight.w400,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 80,
                  width: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.color303E9F, // Center and Right color
                        AppColors.color7A1FA2, // Left color
                      ],
                      stops: [0.25, 0.85],
                      tileMode: TileMode.mirror,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Center(
                    child: CommonAppImageSvg(
                      imagePath: AppImages.settingsRightArrowIcon,
                      color: AppColors.colorWhite,
                      height: 14,
                      width: 8,
                      fit: BoxFit.cover, // Ensures the image fills the space
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
