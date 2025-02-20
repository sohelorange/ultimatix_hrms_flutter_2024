import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendance_reg/attendance_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_routes.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_bar.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_app_image_svg.dart';
import '../../widget/common_container.dart';
import '../../widget/common_gradient_button.dart';
import '../../widget/common_text.dart';

class AttendanceMainUi extends GetView<AttendanceMainController> {
  const AttendanceMainUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: CommonNewAppBar(
          title: 'Attendance',
          leadingIconSvg: AppImages.icBack,
          trailingWidgets: [
            GestureDetector(
              onTap: () {},
              child: const CommonAppImage(
                imagePath: AppImages.dashRefreshIcon,
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
        body: getView(context),
    ));
  }

  getView(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Utils.getScreenHeight(context: context),
          width: Utils.getScreenWidth(context: context),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Obx(
            () => controller.isLoading.isTrue
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Utils.commonCircularProgress(),
                    ],
                  )
                : Column(
                    children: [
                      /*SizedBox(height: MediaQuery.of(context).size.width * 0.05,),*/
                      GestureDetector(
                        onTap: () {
                          if (controller
                              .teamAttendanceResponse.value.data!.isNotEmpty) {
                            Get.toNamed(AppRoutes.userAttendanceRoute,
                                arguments: [
                                  {
                                    "userPhoto": controller.userProfileUrl.value
                                        .trim()
                                        .toString(),
                                    "userName": controller.userName.value
                                        .trim()
                                        .toString(),
                                    "userDesignation": controller
                                        .userDesignation
                                        .trim()
                                        .toString(),
                                    "userEmpId": controller.userEmpId.value,
                                    "userCmpId": controller.userCmpId.value
                                  }
                                ]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          // Adjust container width as needed
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.color303E9F),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorF1EBFB,
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double fontSize = constraints.maxWidth * 0.04;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /*First Row*/
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Small Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CommonAppImage(
                                          height: 50,width: 50,
                                            imagePath: controller
                                                .userProfileUrl
                                                .trim()
                                                .toString()),
                                      ),
                                      const SizedBox(width: 16.0),
                                      // Spacer between image and text
                                      // Column for Texts
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 10,),
                                            CommonText(
                                              text: controller.userName.value,
                                              fontWeight: AppFontWeight.w500,
                                              fontSize: fontSize,
                                              color: AppColors.color1C1F37,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                            /*const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    AppImages.icId),
                                                const SizedBox(width: 2.0),
                                                Flexible(
                                                  child: CommonText(
                                                    text: controller
                                                        .userDesignation.value,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.color1C1F37,
                                                    fontSize: fontSize,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            )*/
                                          ],
                                        ),
                                      ),

                                      controller.teamAttendanceResponse.value
                                                  .data?.isNotEmpty ==
                                              true
                                          ? const Expanded(
                                              child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(height: 8.0),
                                                Icon(Icons.arrow_forward_ios,color: AppColors.color7A1FA2,)
                                              ],
                                            ))
                                          : GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutes.liveTrackingRoute,
                                                    arguments: [
                                                      {
                                                        "username": controller
                                                            .userName.value,
                                                        "empId": controller
                                                            .userEmpId.value,
                                                        "cmpId": controller
                                                            .userCmpId.value,
                                                        "userImage": controller
                                                            .userProfileUrl
                                                            .value
                                                      }
                                                    ]);
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const SizedBox(height: 8.0),
                                                  SvgPicture.asset(
                                                      AppImages.svgLocation)
                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  /*Second Row*/
                                  /*Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Address:",
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.color1C1F37)),
                                      const SizedBox(width: 2.0),
                                      // Three Texts
                                      Obx(
                                        () => Text(
                                          controller.userAddress.value == ""
                                              ? "N/A"
                                              : controller.userAddress.value,
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.color1C1F37),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  /*const SizedBox(height: 16.0),*/

                                  /*Third Row*/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Box 1
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.colorDCDCDC),
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.colorWhite
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppImages.svgInTimeAttendance,
                                                  height: 20,
                                                  width: 20),
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'In Time',
                                                      style: TextStyle(
                                                          fontSize: fontSize,
                                                          color: AppColors
                                                              .color1C1F37,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Obx(
                                                      () => Text(
                                                        controller
                                                            .userCheckInTime
                                                            .value,
                                                        style: TextStyle(
                                                            fontSize: fontSize,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .color6B6D7A),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      // Spacer between the two boxes
                                      // Box 2
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.colorDCDCDC),
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.colorWhite
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppImages.svgOutTimeAttendance,
                                                  height: 20,
                                                  width: 20), // Location Icon
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Out Time',
                                                      style: TextStyle(
                                                          fontSize: fontSize,
                                                          color: AppColors
                                                              .color1C1F37,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Obx(
                                                      () => Text(
                                                        controller
                                                            .userCheckoutTime
                                                            .value,
                                                        style: TextStyle(
                                                            fontSize: fontSize,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .color6B6D7A),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.teamAttendanceResponse.value.data
                                    ?.isEmpty ==
                                true
                            ? true
                            : false,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.9, // Adjust container width as needed
                            child: _attendanceUi(context)),
                      ),
                      Visibility(
                        visible: controller.teamAttendanceResponse.value.data
                                    ?.isEmpty ==
                                true
                            ? true
                            : false,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: controller.attendanceRegularizeDetails
                                    .value.data?.length ??
                                1,
                            itemBuilder: (context, index) {
                              return getUserAttendanceUi(context, index);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.teamAttendanceResponse.value.data
                                    ?.isNotEmpty ==
                                true
                            ? true
                            : false,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Text(
                                "My Team",
                                style: TextStyle(
                                    color: AppColors.color1C1F37,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.teamAttendanceResponse.value.data
                                    ?.isNotEmpty ==
                                true
                            ? true
                            : false,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: controller.teamAttendanceResponse.value
                                .data?.length, // Number of items in the list
                            itemBuilder: (context, index) {
                              return getTeamAttendanceUi(context, index);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        )
      ],
    );
  }

  getTeamAttendanceUi(BuildContext context, int index) {
    return Column(
      children: [
        index==0 ? const SizedBox(height: 2,) : const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.all(16.0),
          /*margin: const EdgeInsets.all(10),*/
          width: MediaQuery.of(context).size.width * 0.9,
          // Adjust container width as needed
          decoration: BoxDecoration(
            /*boxShadow: const [
              BoxShadow(
                color: Color(0X1C1F370D),
                // Light gray color for shadow
                blurRadius: 4.0,
                // Increase the blur for a more spread-out shadow
                spreadRadius: 1.0,
                // Small spread to create a more pronounced shadow
                offset: Offset(0,
                    0), // Offset to simulate elevation effect (vertical shadow)
              ),
            ],*/
            borderRadius: BorderRadius.circular(6),
            color: AppColors.colorF3FFFB,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxWidth * 0.04;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*First Row*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Small Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CommonAppImage(
                          height: 50,width: 50,
                          imagePath: getImageUrl(index),
                          radius: 10,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Spacer between image and text
                      // Column for Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              text: controller
                                  .teamAttendanceResponse.value.data!
                                  .elementAt(index)
                                  .empFullName
                                  .toString(),
                              fontWeight: AppFontWeight.w500,
                              fontSize: fontSize,
                              color: AppColors.color1C1F37,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.icId),
                                const SizedBox(width: 2.0),
                                CommonText(
                                  text: controller
                                      .teamAttendanceResponse.value.data!
                                      .elementAt(index)
                                      .desigName
                                      .toString(),
                                  color: AppColors.color1C1F37,
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSize,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.userAttendanceRoute,
                              arguments: [
                                {
                                  "userPhoto": controller
                                      .teamAttendanceResponse.value.data!
                                      .elementAt(index)
                                      .imagePath
                                      .toString(),
                                  "userName": controller
                                      .teamAttendanceResponse.value.data!
                                      .elementAt(index)
                                      .empFullName
                                      .toString(),
                                  "userDesignation": controller
                                      .teamAttendanceResponse.value.data!
                                      .elementAt(index)
                                      .desigName
                                      .toString(),
                                  "userEmpId": controller
                                      .teamAttendanceResponse.value.data!
                                      .elementAt(index)
                                      .empId!,
                                  "userCmpId": controller
                                      .teamAttendanceResponse.value.data!
                                      .elementAt(index)
                                      .cmpID!
                                }
                              ]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8.0),
                            SvgPicture.asset(AppImages.svgAttendanceEdit),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.liveTrackingRoute, arguments: [
                            {
                              "username": controller
                                  .teamAttendanceResponse.value.data!
                                  .elementAt(index)
                                  .empFullName
                                  .toString(),
                              "empId": controller
                                  .teamAttendanceResponse.value.data!
                                  .elementAt(index)
                                  .empId!,
                              "cmpId": controller
                                  .teamAttendanceResponse.value.data!
                                  .elementAt(index)
                                  .cmpID!,
                              "userImage": controller
                                  .teamAttendanceResponse.value.data!
                                  .elementAt(index)
                                  .imagePath
                                  .toString()
                            }
                          ]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8.0),
                            SvgPicture.asset(AppImages.svgAttendanceLocation),
                          ],
                        ),
                      ),
                    ],
                  ),
                  teamAttendanceCheckTime(index) == false
                      ? Container()
                      : const SizedBox(height: 16.0),

                  /*Second Row*/
                  teamAttendanceCheckTime(index) == false
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Box 1
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.colorDCDCDC),
                                    color: AppColors.colorWhite),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.svgInTimeAttendance,
                                      height: 20,
                                      width: 20,
                                    ),
                                    // Clock Icon
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'In Time',
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                color: AppColors.color1C1F37,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            controller.teamAttendanceResponse
                                                        .value.data!
                                                        .elementAt(index)
                                                        .status
                                                        .toString() ==
                                                    ""
                                                ? "--:--"
                                                : controller
                                                    .teamAttendanceResponse
                                                    .value
                                                    .data!
                                                    .elementAt(index)
                                                    .status
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.color6B6D7A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            // Spacer between the two boxes
                            // Box 2
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.colorDCDCDC),
                                    color: AppColors.colorWhite),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.svgOutTimeAttendance,
                                      height: 20,
                                      width: 20,
                                    ),
                                    // Location Icon
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Out Time',
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                color: AppColors.color1C1F37,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            controller.teamAttendanceResponse
                                                        .value.data
                                                        ?.elementAt(index)
                                                        .status2
                                                        .toString()
                                                        .trim() ==
                                                    ""
                                                ? "--:--"
                                                : controller
                                                    .teamAttendanceResponse
                                                    .value
                                                    .data!
                                                    .elementAt(index)
                                                    .status2
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.color6B6D7A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                  /*Third Row*/ //TODO:check condition for sub emp data available or not 17-02-2025 If available then visible else Invisible
                  const SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: AppColors.gradientBackgroundNew
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Show Team Members",style: TextStyle(color: AppColors.colorWhite,fontWeight: FontWeight.w500, fontSize: fontSize),),
                      SvgPicture.asset(AppImages.svgDropDownAttendance)
                    ],),
                  )
                ],
              );
            },
          ),
        ),
        /*SizedBox(height: MediaQuery.of(context).size.width * 0.03,),*/
      ],
    );
  }

  getImageUrl(int index) {
    if (controller.teamAttendanceResponse.value.data != null) {
      if (controller.teamAttendanceResponse.value.data!
                  .elementAt(index)
                  .imagePath ==
              null ||
          controller.teamAttendanceResponse.value.data!
                  .elementAt(index)
                  .imagePath ==
              "") {
        return AppImages.imgUserProf;
      } else {
        return controller.teamAttendanceResponse.value.data!
            .elementAt(index)
            .imagePath
            .toString();
      }
    } else {
      return AppImages.imgUserProf;
    }
  }

  getUserAttendanceUi(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          // Adjust container width as needed
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0X1C1F370D),
                // Light gray color for shadow
                blurRadius: 4.0,
                // Increase the blur for a more spread-out shadow
                spreadRadius: 1.0,
                // Small spread to create a more pronounced shadow
                offset: Offset(0,
                    0), // Offset to simulate elevation effect (vertical shadow)
              ),
            ],
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxWidth * 0.04;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*First Row*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Small Image
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: SvgPicture.asset(
                          getImageUrls(index),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Spacer between image and text
                      // Column for Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              text: controller.getWeekDay(controller
                                      .attendanceRegularizeDetails.value.data
                                      ?.elementAt(index)
                                      .forDate
                                      .toString() ??
                                  ""),
                              fontWeight: AppFontWeight.w500,
                              fontSize: fontSize,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: fontSize,
                                ),
                                const SizedBox(width: 2.0),
                                CommonText(
                                  text: controller.setDate(controller
                                          .attendanceRegularizeDetails
                                          .value
                                          .data
                                          ?.elementAt(index)
                                          .forDate
                                          .toString() ??
                                      ""),
                                  color: Colors.black,
                                  fontSize: fontSize,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      Visibility(
                        visible: controller
                                .attendanceRegularizeDetails.value.data
                                ?.elementAt(index)
                                .rowStatus! ??
                            false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8.0),
                            controller.attendanceRegularizeDetails.value.data
                                        ?.elementAt(index)
                                        .chkBySuperior ==
                                    "Pending"
                                ? SvgPicture.asset(AppImages.icPendingReg,
                                    height: 20, width: 20)
                                : controller.attendanceRegularizeDetails.value
                                            .data
                                            ?.elementAt(index)
                                            .chkBySuperior ==
                                        "Approved"
                                    ? SvgPicture.asset(AppImages.icApproveReg,
                                        height: 20, width: 20)
                                    : controller.attendanceRegularizeDetails
                                                .value.data
                                                ?.elementAt(index)
                                                .chkBySuperior ==
                                            "Rejected"
                                        ? SvgPicture.asset(
                                            AppImages.icCancelReg,
                                            height: 20,
                                            width: 20)
                                        : GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .regularizeApplyRoute,
                                                  arguments: [
                                                    {
                                                      "Shift1": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .shInTime ??
                                                          "--:--",
                                                      "Shift2": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .shOutTime ??
                                                          "",
                                                      "empId": controller
                                                          .attendanceRegularizeDetails
                                                          .value
                                                          .data
                                                          ?.elementAt(index)
                                                          .empId,
                                                      "cmpId": controller
                                                          .attendanceRegularizeDetails
                                                          .value
                                                          .data
                                                          ?.elementAt(index)
                                                          .cmpID,
                                                      "forDate": controller
                                                          .attendanceRegularizeDetails
                                                          .value
                                                          .data
                                                          ?.elementAt(index)
                                                          .forDate,
                                                      "halfFullDay": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .pDays ??
                                                          "--:--",
                                                      "cancellationLateIn": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .isCancelLateIn ??
                                                          "--:--",
                                                      "cancellationEarlyOut": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .isCancelEarlyOut ??
                                                          "--:--",
                                                      "inTime1": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .shInTime ??
                                                          "--:--",
                                                      "outTime1": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .shOutTime ??
                                                          "--:--",
                                                      "lateIn": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .earlyMinute ??
                                                          "--:--",
                                                      "earlyOut": controller
                                                              .attendanceRegularizeDetails
                                                              .value
                                                              .data
                                                              ?.elementAt(index)
                                                              .isLeaveApp ??
                                                          "--:--",
                                                      "UiName":
                                                          "AttendanceMainUi"
                                                    }
                                                  ]);
                                            },
                                            child: SvgPicture.asset(
                                              AppImages.svgAttendanceEdit,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                          ],
                        ),
                      )
                    ],
                  ),
                  checkTime(index) == false
                      ? const SizedBox(height: 0)
                      : const SizedBox(height: 16.0),

                  /*Second Row*/
                  /*controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="HO" ? Container()*/
                  checkTime(index) == false
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Box 1
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.colorF8F4FA),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.svgClock,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Check in',
                                            style:
                                                TextStyle(fontSize: fontSize),
                                          ),
                                          Text(
                                            controller
                                                    .attendanceRegularizeDetails
                                                    .value
                                                    .data
                                                    ?.elementAt(index)
                                                    .status
                                                    ?.trim() ??
                                                "",
                                            style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold,
                                              color: getColors(index),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            // Spacer between the two boxes
                            // Box 2
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.colorF8F4FA),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.svgClock,
                                      height: 20,
                                      width: 20,
                                    ),
                                    // Location Icon
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Check out',
                                            style:
                                                TextStyle(fontSize: fontSize),
                                          ),
                                          Text(
                                            controller
                                                    .attendanceRegularizeDetails
                                                    .value
                                                    .data
                                                    ?.elementAt(index)
                                                    .status2
                                                    ?.trim() ??
                                                "",
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                fontWeight: FontWeight.bold,
                                                color: getColors(index)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
        //SizedBox(height: MediaQuery.of(context).size.width * 0.03,),
      ],
    );
  }

  getImageUrls(int index) {
    if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "A") {
      return AppImages.svgAbsentAttendance;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "P") {
      return AppImages.svgPresentAttendance;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "W") {
      return AppImages.svgWeekOffAttendance;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "HO") {
      return AppImages.svgHolidayAttendance;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "OD") {
      return AppImages.svgOdAttendance;
    } else {
      return AppImages.svgAbsentAttendance;
    }
  }

  Widget _attendanceUi(BuildContext context) {
    final int currentMonth = DateTime.now().month;

    // Get the selected month or current month
    final String selectedMonth = controller.selectedMonthIndex.value == -1
        ? [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ][currentMonth - 1] // Convert month index to name
        : [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ][controller.selectedMonthIndex.value];

    return CommonGradientButton(
      text: '$selectedMonth ${controller.selectedYear.toString()} Attendance',
      imagePath: AppImages.leaveCalendarIcon, // Change the icon as needed
      onTap: () {
        controller.showYearDialog(context); // Define your on-tap behavior here
      },
    );
  }

  checkVisible() {
    if (controller.teamAttendanceResponse.value.data != null) {
      return false;
    } else {
      return true;
    }
  }

  checkVisibility() {
    if (controller.teamAttendanceResponse.value.data != null) {
      return true;
    } else {
      return false;
    }
  }

  getColors(int index) {
    num lateMin = controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .lateMinute ??
        0;
    num lateTime = controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .lateTime ??
        0;
    return lateMin > lateTime ? AppColors.colorD33017 : AppColors.color1C1F37;
  }

  bool checkTime(int index) {
    if (controller.attendanceRegularizeDetails.value.data
                ?.elementAt(index)
                .status !=
            null ||
        controller.attendanceRegularizeDetails.value.data
                ?.elementAt(index)
                .status2 !=
            null) {
      if (controller.attendanceRegularizeDetails.value.data
                  ?.elementAt(index)
                  .status !=
              "" ||
          controller.attendanceRegularizeDetails.value.data
                  ?.elementAt(index)
                  .status2 !=
              "") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  teamAttendanceCheckTime(int index) {
    if (controller.teamAttendanceResponse.value.data?.elementAt(index).status !=
            null ||
        controller.teamAttendanceResponse.value.data
                ?.elementAt(index)
                .status2 !=
            null) {
      if (controller.teamAttendanceResponse.value.data
                  ?.elementAt(index)
                  .status !=
              "" ||
          controller.teamAttendanceResponse.value.data
                  ?.elementAt(index)
                  .status2 !=
              "") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
