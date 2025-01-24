import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_time_format.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_latest.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_grid_view_new.dart';

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
        leadingIcon: Icons.menu, // Menu icon
        onLeadingIconTap: () {
          // Action for menu icon, e.g., open drawer
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
                  color: Colors.grey.withOpacity(0.5),
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

          // IconButton(
          //   icon: Icon(Icons.notifications, color: Colors.white),
          //   onPressed: () {
          //     // Action for notifications icon
          //     print("Notifications tapped");
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.notifications, color: Colors.white),
          //   onPressed: () {
          //     // Action for notifications icon
          //     print("Notifications tapped");
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.notifications, color: Colors.white),
          //   onPressed: () {
          //     // Action for notifications icon
          //     print("Notifications tapped");
          //   },
          // ),
        ],
      ),

      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(90),
      //   child: CommonLatestAppBar(
      //     title: "Dashboard",
      //     leadingIcon: Icons.menu, // Menu icon
      //     onLeadingIconTap: () {
      //       // Action for menu icon, open drawer
      //       Scaffold.of(context).openDrawer();
      //     },
      //     trailingWidgets: [
      //       IconButton(
      //         icon: const Icon(Icons.notifications, color: Colors.white),
      //         onPressed: () {
      //           // Action for notifications icon
      //           print("Notifications tapped");
      //         },
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.settings, color: Colors.white),
      //         onPressed: () {
      //           // Action for settings icon
      //           print("Settings tapped");
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.color303E9F,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Close the drawer and perform an action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Close the drawer and perform an action
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
                        print("Notifications tapped");
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        // Action for settings icon
                        print("Settings tapped");
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
        onPressed: () {},
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
            _buildProfileInfo(),
            //Obx(() => _buildLocationInfo()),
            const SizedBox(
              height: 15,
            ),
            _buildAttendanceSummary(context),
            //Obx(() => _buildAttendanceSummary()),
            const SizedBox(
              height: 15,
            ),
            Visibility(visible: false, child: _buildAttendanceRegulation()),
            const Visibility(
              visible: false,
              child: SizedBox(
                height: 15,
              ),
            ),
            Visibility(visible: false, child: _buildMyKPA()),
            const Visibility(
              visible: false,
              child: SizedBox(
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
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
                      if (controller.isGeofenceEnable == 1) {
                        Get.toNamed(AppRoutes.geofenceRoute);
                      } else {
                        Get.toNamed(AppRoutes.clockInRoute);
                      }
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
                text: AppTimePicker.currentTime12(),
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

  Widget _buildViewMore(BuildContext context) {
    // Helper function to determine if "View More" should be shown
    bool shouldShowViewMore(String text, TextStyle style, double maxWidth) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);

      return textPainter.didExceedMaxLines;
    }

    // Get the maxWidth for the text
    final double maxWidth = MediaQuery.of(context).size.width -
        32; // Adjust for padding or other constraints

    // TextStyle used for the `address` text
    final TextStyle textStyle = TextStyle(
      fontSize: 14,
      fontWeight: AppFontWeight.w400,
      color: AppColors.colorDarkBlue,
    );

    // Check if the "View More" button should be shown
    bool showViewMore =
        shouldShowViewMore(controller.address.value, textStyle, maxWidth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          constraints: BoxConstraints(
            maxHeight: controller.isViewMore.value ? 50 : 50,
          ),
          child: SingleChildScrollView(
            physics: controller.isViewMore.value
                ? null
                : const NeverScrollableScrollPhysics(),
            child: CommonText(
              maxLine: controller.isViewMore.value ? null : 2,
              overflow: controller.isViewMore.value
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              text: controller.address.value,
              color: AppColors.colorDarkBlue,
              fontSize: 14,
              fontWeight: AppFontWeight.w400,
            ),
          ),
        ),
        if (showViewMore)
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                controller.isViewMore.value = !controller.isViewMore.value;
              },
              child: CommonText(
                textAlign: TextAlign.center,
                text: controller.isViewMore.value ? 'View Less' : 'View More',
                color: AppColors.purpleSwatch,
                fontSize: 12,
                fontWeight: AppFontWeight.w500,
              ).paddingOnly(top: 10, bottom: 10),
            ),
          ),
      ],
    );
  }

  Widget _buildUpcomingEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              textAlign: TextAlign.center,
              text: 'Announcement',
              color: AppColors.colorDarkBlue,
              fontSize: 16,
              fontWeight: AppFontWeight.w500,
            ),
            Visibility(
              visible: false,
              child: GestureDetector(
                onTap: () {},
                child: CommonText(
                  textAlign: TextAlign.center,
                  text: 'View All',
                  color: AppColors.purpleSwatch,
                  fontSize: 12,
                  fontWeight: AppFontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CommonCarouselBanner(
          images: controller.bannerListData,
        ),
      ],
    );
  }

  Widget _buildAttendanceSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
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
                height: Utils.getScreenHeight(context: context) / 3.25,
                child: Center(child: Utils.commonCircularProgress()))
            : controller.attendanceStatusData.isEmpty
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
                : CommonGridViewNew(
                    statusData: controller.attendanceStatusData,
                  ),
      ],
    );
  }

  Widget _buildAttendanceRegulation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            textAlign: TextAlign.center,
            text: 'Attendance Regulation',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w500,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              // Gray color for unselected
              borderRadius: BorderRadius.circular(10),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Color(0X1C1F370D),
              //     blurRadius: 4.0,
              //     spreadRadius: 1.0,
              //     offset: Offset(0, 0),
              //   ),
              // ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        textAlign: TextAlign.center,
                        text: 'Target',
                        color: AppColors.colorDarkBlue,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(
                        textAlign: TextAlign.center,
                        text: '5,00,000.00',
                        color: AppColors.colorDarkGray,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 125,
                  height: 40,
                  child: CommonButton(
                      buttonText: 'Regularize',
                      onPressed: () {},
                      isLoading: false),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMyKPA() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            textAlign: TextAlign.center,
            text: 'My KAP',
            color: AppColors.colorDarkBlue,
            fontSize: 16,
            fontWeight: AppFontWeight.w500,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              // Gray color for unselected
              borderRadius: BorderRadius.circular(10),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Color(0X1C1F370D),
              //     blurRadius: 4.0,
              //     spreadRadius: 1.0,
              //     offset: Offset(0, 0),
              //   ),
              // ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      textAlign: TextAlign.center,
                      text: 'Target',
                      color: AppColors.colorDarkBlue,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                    CommonText(
                      textAlign: TextAlign.center,
                      text: '5,00,000.00',
                      color: AppColors.colorDarkGray,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      textAlign: TextAlign.center,
                      text: 'Actual',
                      color: AppColors.colorDarkBlue,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                    CommonText(
                      textAlign: TextAlign.center,
                      text: '2,00,000.00',
                      color: AppColors.colorDarkGray,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
