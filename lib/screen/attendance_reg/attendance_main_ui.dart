import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:ultimatix_hrms_flutter/api/model/team_attendance_response.dart';
import 'package:ultimatix_hrms_flutter/screen/attendance_reg/attendance_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_routes.dart';
import '../../app/app_snack_bar.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_bar.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_app_image_svg.dart';
import '../../widget/common_container.dart';
import '../../widget/common_gradient_button.dart';
import '../../widget/common_text.dart';


Offset tapPosition = Offset.zero;
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
                                              color: AppColors.color2F2F31,
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
                                          ?  Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      controller.isShowChart.value = !controller.isShowChart.value;
                                                    },
                                                    child: controller.isShowChart.value==true ?
                                                        SvgPicture.asset(AppImages.svgCalSmall,)
                                                        : SvgPicture.asset(AppImages.svgChartAttendance,)
                                                ),
                                                const SizedBox(width: 10.0),
                                                const Icon(Icons.arrow_forward_ios,color: AppColors.color7A1FA2,)
                                              ],
                                            ))
                                          : Expanded(
                                            child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          controller.isShowChart.value = !controller.isShowChart.value;
                                                        },
                                                        child: controller.isShowChart.value==true ?
                                                        SvgPicture.asset(AppImages.svgChartAttendance,)
                                                            : SvgPicture.asset(AppImages.svgChartAttendance,)),
                                                    const SizedBox(width: 18.0),
                                                    GestureDetector(
                                                      onTap: () {
                                                        /*Get.toNamed(
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
                                                            ]);*/

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
                                                      },
                                                      child: SvgPicture.asset(
                                                          AppImages.svgArrowRightAttendance,),
                                                    )
                                                  ],
                                                ),
                                          ),

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

                      if(controller.isShowChart.value==false) ... [
                        /*Visibility( //TODO:Commented because not want to show the employee attendance records
                        visible: controller.teamAttendanceResponse.value.data
                                    ?.isEmpty ==
                                true
                            ? true
                            : false,
                        child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.9,
                            padding: const EdgeInsets.only(top: 15,bottom: 15),// Adjust container width as needed
                            child: _getAttendanceCalender(context)),
                      ),*/

                        /*Visibility( //TODO:Commented because not want to show the employee attendance records
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
                      ),*/

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
                        child: /*Expanded(
                          child: ListView.builder(
                            itemCount: controller.teamAttendanceResponse.value
                                .data?.length, // Number of items in the list
                            itemBuilder: (context, index) {
                              return getTeamAttendanceUi(context, index);
                            },
                          ),
                        ),*/
                        Expanded(
                            child: Obx(
                              ()=> ListView.builder(
                                itemCount: controller.expanded.length,
                                itemBuilder: (context, index) {

                                  print("The total count of list is:${controller.teamAttendanceResponse.value.data?.length}");
                                  print("The total count of expand is:${controller.expanded.length}");
                                  print("The total count of index is:$index");

                                    return Column(
                                        children: [
                                          /*ListTile(
                                              leading: CircleAvatar(child: Text('${index + 1}')),
                                              title: Text('Item ${index + 1}'),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  controller.expanded[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                                ),
                                                onPressed: () {
                                                  controller.expanded[index] = !controller.expanded[index];
                                                },
                                                ),
                                              ),*/
                                            getTeamAttendanceUi(context, index),

                                            if(controller.expanded[index])
                                              Column(
                                                children: List.generate(
                                                  controller.subTeamAttendanceResponse.value.data?.length ?? 0,
                                                      (subIndex) => Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color: AppColors.colorEEFAFE,
                                                          border: Border.all(width: 10, color: AppColors.colorDAECF2),
                                                        ),
                                                        child: ListTile(
                                                          leading: ClipRRect(
                                                            borderRadius: BorderRadius.circular(30),
                                                            child: CommonAppImage(
                                                              height: 50,width: 50,
                                                              imagePath: getImageUrl(index),
                                                              radius: 10,
                                                            ),
                                                          ),
                                                          title: Text(controller.subTeamAttendanceResponse.value.data?.elementAt(subIndex).empFullName?.trim().toString() ?? ""),
                                                          subtitle: Text(controller.subTeamAttendanceResponse.value.data?.elementAt(subIndex).alphaEmpCode?.trim().toString() ?? ""),
                                                          trailing: GestureDetector(
                                                            onTapDown: _storePosition,
                                                            onTap: () {
                                                              _showPopupMenu(context,index);
                                                            },
                                                            child: Column(children: [
                                                              const SizedBox(height: 8.0),
                                                              SvgPicture.asset(AppImages.svgMenuAttendance)
                                                            ],),
                                                          ),
                                                        ),
                                                  ).paddingOnly(left: 20,right: 20,top: 2),
                                                ),
                                              ),

                                        ],
                                    );
                                    //return _buildList(controller.teamAttendanceResponse.value.data,index,context);
                                },
                              ),
                            )
                        )
                      ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10,),
                              Text(
                                "Today,${controller.nowDate.value}",
                                style: const TextStyle(
                                    color: AppColors.color2F2F31,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        getPieChart(context),
                      ]

                    ],
                  ),
          ),
        )
      ],
    );
  }

  getTeamAttendanceUi(BuildContext context, int index) {

    return /*Obx(
      ()=>*/ Column(
        children: [
          index==0 ? const SizedBox(height: 2,) : const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(16.0),
            /*margin: const EdgeInsets.all(10),*/
            width: MediaQuery.of(context).size.width * 0.9,
            // Adjust container width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
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
                          onTapDown: _storePosition,
                          onTap: () {
                            _showPopupMenu(context,index);
                          },
                          child: Column(children: [
                            const SizedBox(height: 8.0),
                            SvgPicture.asset(AppImages.svgMenuAttendance)
                          ],),
                        ),

                        /*GestureDetector(
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
                        ),*/
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

                    /*Third Row*/
                    /*const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        AppSnackBar.showGetXCustomSnackBar(message: "Clicked:${
                            controller
                                .teamAttendanceResponse.value.data!
                                .elementAt(index)
                                .empFullName
                                .toString()
                        }", backgroundColor: Colors.green);
                      },
                      child: Container(
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
                      ),
                    )*/
                  ],
                );
              },
            ),
          ),

          /*if(controller.isShowSubEmp.value == true) ...[
            SizedBox(height: MediaQuery.of(context).size.width * 0.03,), //TODO:Need to uncomment
            ChildListView(), //TODO:Need to uncomment
          ]*/

          /*SizedBox(height: MediaQuery.of(context).size.width * 0.03,),*/
        ],
      );
    /*);*/
  }

  _showPopupMenu(BuildContext context, int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.all(
        Radius.circular(10.0),
      ),side: BorderSide(color: AppColors.color7B1FA2,width: 2)),
      position: RelativeRect.fromLTRB(
        tapPosition.dx, // X Position (Horizontal)
        tapPosition.dy + 10, // Y Position (Below the tapped icon)
        overlay.size.width - tapPosition.dx, // Right boundary
        overlay.size.height - tapPosition.dy, // Bottom boundary
      ),
      items: <PopupMenuEntry<dynamic>>[
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Stack(children: [
                  SvgPicture.asset(AppImages.svgBgCon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                      Text("1",style: TextStyle(color: AppColors.colorWhite),),
                      SizedBox(width: 5,),
                      SvgPicture.asset(AppImages.svgDropDownAttendance,height: 5,width: 8,)
                    ],),
                  )
                ]),
                onPressed: () {
                  /*controller.isShowSubEmp.value = !controller.isShowSubEmp.value;*/
                  controller.expanded[index] = !controller.expanded[index];
                  if(controller.expanded[index]==true) {
                    controller.getMyTeamRecords(
                        controller.teamAttendanceResponse.value.data!.elementAt(
                            index).empId.toString(),
                        controller.teamAttendanceResponse.value.data!.elementAt(
                            index).cmpID.toString(),
                        true
                    );
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(AppImages.svgEditNewAttendance),
                onPressed: () {
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
              ),
              IconButton(
                icon: SvgPicture.asset(AppImages.svgLocUserAttendance),
                onPressed: () {
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
              ),
              /*IconButton(
                icon: SvgPicture.asset(AppImages.svgNewLocAttendance),
                onPressed: () {
                  print("Item 3 clicked");
                  Navigator.pop(context);
                },
              ),*/
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
  void _storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }


  getImageUrl(int index) {
    if (controller.teamAttendanceResponse.value.data != null) {
      log("The image path $index is:${controller.teamAttendanceResponse.value.data!
          .elementAt(index)
          .imagePath}");
      if (controller.teamAttendanceResponse.value.data!
                  .elementAt(index)
                  .imagePath ==
              null ||
          controller.teamAttendanceResponse.value.data!
                  .elementAt(index)
                  .imagePath ==
              "") {
        return AppImages.icBackGround;
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
            borderRadius: BorderRadius.circular(6),
            color: AppColors.colorF1EBFB,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxWidth * 0.04;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * (148 / 375),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              getUserAttendanceStatusIcons(index),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
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
                                  fontWeight: AppFontWeight.w400,
                                  fontSize: fontSize,
                                  color: AppColors.color2F2F31,
                                ),
                                const SizedBox(height: 4.0),
                                CommonText(
                                  text: controller.setDate(controller
                                      .attendanceRegularizeDetails
                                      .value
                                      .data
                                      ?.elementAt(index)
                                      .forDate
                                      .toString() ??
                                      ""),
                                  color: AppColors.color7B758E,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (148 / 375),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(getUserAttendanceImage(index)),
                            controller.attendanceRegularizeDetails.value.data
                                ?.elementAt(index)
                                .chkBySuperior ==
                                "Pending"
                                ? SvgPicture.asset(AppImages.svgPendingNew,
                                height: 20, width: 20)
                                : controller.attendanceRegularizeDetails.value
                                .data
                                ?.elementAt(index)
                                .chkBySuperior ==
                                "Approved"
                                ? SvgPicture.asset(AppImages.svgApprovedNew,
                                height: 20, width: 20)
                                : controller.attendanceRegularizeDetails
                                .value.data
                                ?.elementAt(index)
                                .chkBySuperior ==
                                "Rejected"
                                ? SvgPicture.asset(
                                AppImages.svgCancelNew,
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
                                AppImages.svgEditNew,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ],)),
                    ],
                  ),

                  checkTime(index) == false
                      ? const SizedBox(height: 0)
                      : const SizedBox(height: 16.0),

                  checkTime(index) == false
                      ? Container()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Box 1
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * (148 / 375),
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
                                      'In Time',
                                      style:
                                      TextStyle(fontSize: fontSize,color: AppColors.color2F2F31,fontWeight: FontWeight.w500),
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
                                        fontWeight: FontWeight.w400,
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
                          width: MediaQuery.of(context).size.width * (148 / 375),
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
                                      style:
                                      TextStyle(fontSize: fontSize,color: AppColors.color2F2F31,fontWeight: FontWeight.w500),
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
                                          fontWeight: FontWeight.w400,
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

  getUserAttendanceImage(int index) {
    if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "A") {
      return AppImages.svgAbsentNew;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "P") {
      return AppImages.svgPresentNew;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "W") {
      return AppImages.svgWeekOffNew;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "HO") {
      return AppImages.svgHolidayNew;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "OD") {
      return AppImages.svgOnDutyNew;
    } else {
      return AppImages.svgAbsentAttendance;
    }
  }

  getUserAttendanceStatusIcons(int index) {
    if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "A") {
      return AppImages.svgAttendanceAbsentFirst;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "P") {
      return AppImages.svgAttendancePresentFirst;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "W") {
      return AppImages.svgAttendanceWeekOffFirst;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "HO") {
      return AppImages.svgAttendanceHolidayFirst;
    } else if (controller.attendanceRegularizeDetails.value.data
            ?.elementAt(index)
            .mainStatus ==
        "OD") {
      return AppImages.svgAttendanceOnDutyFirst;
    } else {
      return AppImages.svgAbsentAttendance;
    }
  }

  Widget _getAttendanceCalender(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Month",
              style: GoogleFonts.inter(fontSize: MediaQuery.of(context).size.width * 0.035,fontWeight: FontWeight.w400,color: AppColors.color2F2F31),
            ),
            const SizedBox(height: 3,),
            Container(
                width: MediaQuery.of(context).size.width * (115 / 375),
                height: MediaQuery.of(context).size.height * (40 / 812),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorDCDCDC),
                    borderRadius: BorderRadius.circular(6)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: controller.listOfMonths.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Row(
                          children: [
                            Text(
                              e,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },).toList(),
                    onChanged: (value) {
                      log("This item name is:$value");
                      if(value!=null){
                        controller.selectedMonths.value = value;
                      }
                    },
                    dropdownStyleData: DropdownStyleData(
                        offset: const Offset(-10, -10),
                        maxHeight: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.color7A1FA2),
                            borderRadius: const BorderRadius.all(Radius.circular(6))
                        ),
                        width: MediaQuery.of(context).size.width * 0.32,
                        useSafeArea: true),
                    isExpanded: true,
                    iconStyleData: IconStyleData(
                        icon: SvgPicture.asset(AppImages.svgCalenderAttendance)
                    ),
                    value: controller.selectedMonths.value.isEmpty || controller.selectedMonths.value=="" ? controller.listOfMonths.first : controller.selectedMonths.value,
                  ),
                )
            )
          ],),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Year",
              style: GoogleFonts.inter(fontSize: MediaQuery.of(context).size.width * 0.035,fontWeight: FontWeight.w400,color: AppColors.color2F2F31),
            ),
            const SizedBox(height: 3,),
            Obx(
                  ()=> Container(
                  height: MediaQuery.of(context).size.height * (40 / 812),
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * (115 / 375),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.colorDCDCDC),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: controller.listOfYears.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Row(
                            children: [
                              Text(
                                e,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },).toList(),
                      onChanged: (value) {
                        log("This item name is:$value");
                        if(value!=null){
                          controller.selectedYears.value = value;
                        }
                      },
                      dropdownStyleData: DropdownStyleData(
                          offset: const Offset(-10, -10),
                          maxHeight: 200,
                          width: MediaQuery.of(context).size.width * 0.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.color7A1FA2),
                              borderRadius: const BorderRadius.all(Radius.circular(6))
                          ),
                          useSafeArea: true),
                      isExpanded: true,
                      iconStyleData: IconStyleData(
                          icon: SvgPicture.asset(AppImages.svgCalenderAttendance)
                      ),
                      value: controller.selectedYears.value.isEmpty || controller.selectedYears.value=="" ? controller.listOfYears.last : controller.selectedYears.value,
                    ),
                  )
              ),
            )
          ],),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(""),
            Container(
              height: MediaQuery.of(context).size.height * (40 / 812),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: AppColors.gradientBackgroundNew
              ),
              child: Text(
                "Change",
                style: GoogleFonts.inter(fontSize: MediaQuery.of(context).size.width * 0.035,fontWeight: FontWeight.w400,color: AppColors.colorWhite),
                textAlign: TextAlign.center,),
            )
          ],),
      ],
    );
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
    return lateMin > lateTime ? AppColors.colorD33017 : AppColors.color7B758E;
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

  Widget getPieChart(BuildContext context) {
    return Obx(
      () =>  Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border:Border.all(color: AppColors.colorF1EBFB,width: 10),
          ),
          padding: const EdgeInsets.only(top: 25,bottom: 25),
          alignment: Alignment.center,
          child: Column(
            children: [
              PieChart(
                dataMap: <String,double>{
                  "Present":controller.present.value.toDouble(),
                  "Absent":controller.absent.value.toDouble(),
                },
                chartRadius: MediaQuery.of(context).size.width / 2.0,
                legendOptions: const LegendOptions(
                  showLegends: false
                ),
                /*ringStrokeWidth: 80,*/
                chartValuesOptions: const ChartValuesOptions(
                  showChartValues: false
                ),
                chartType: ChartType.disc,
                initialAngleInDegree: -90,
                emptyColor: controller.absent.value==0 ? AppColors.colorECA5F7 : AppColors.colorA5A7FF,
                colorList: const [AppColors.color25D0C9,AppColors.colorF35C5C],
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Present Section
                  getBottomChartResult("Present","isPresent"),
                  // Absent Section
                  getBottomChartResult("Absent","isAbsent"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomChartResult(String txtTitle,String label){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align icon and text properly
      children: [
        label=="isPresent" ? SvgPicture.asset(AppImages.svgColorPresent).marginOnly(top: 5) : SvgPicture.asset(AppImages.svgColorAbsent).marginOnly(top: 5),
        const SizedBox(width: 5), // Space between icon and text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text properly
          children: [
            Row(
              children: [
                Text(txtTitle), // Present text in same line as SVG
              ],
            ),
            label=="isPresent"  ?
              Obx(() => Text("${controller.present.value}%"))
            : Obx(() => Text("${controller.absent.value}%")), // Second line
          ],
        ),
      ],
    );
  }

  Widget ChildListView() {
    return ListView.builder(
      shrinkWrap: true, // Important to prevent infinite height issue
      physics: const NeverScrollableScrollPhysics(), // Prevent scrolling conflict
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.colorF3FFFB,
              ),
              child:Column(
                children: [
                  Text("Hello"),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
          ],
        );
      },
    );
  }

  /*Widget _buildList(List<Data>? data, int index, BuildContext context) {
    log("AttendanceMainUi, ${controller.isShowSubEmp.value}");

      return Obx(
        () =>  ExpansionTile(
          showTrailingIcon: false,
          initiallyExpanded: controller.isShowSubEmp.value ? true : false,
          title: getTeamAttendanceUi(context, index),
          children: const [
            Text("Hello"),
          ],
        ),
      );

  }*/

  /*Widget getTest(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        *//*First Row*//*
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small Image
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
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
                getImageIcons(index),
              ),
            ),
            const SizedBox(width: 5.0),
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
                    fontWeight: AppFontWeight.w400,
                    fontSize: fontSize,
                    color: AppColors.color2F2F31,
                  ),
                  const SizedBox(height: 4.0),
                  CommonText(
                    text: controller.setDate(controller
                        .attendanceRegularizeDetails
                        .value
                        .data
                        ?.elementAt(index)
                        .forDate
                        .toString() ??
                        ""),
                    color: AppColors.color7B758E,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
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
            ),
          ],
        ),
        checkTime(index) == false
            ? const SizedBox(height: 0)
            : const SizedBox(height: 16.0),

        *//*Second Row*//*
        *//*controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="HO" ? Container()*//*
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
  }*/
}


