import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimatix_hrms_flutter/screen/attendance_reg/user_attendance_regularize/attendance_user_controller.dart';
import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_routes.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_text.dart';
import '../../../widget/new/common_app_bar_new.dart';

class UserAttendanceUi extends GetView<UserAttendanceController> {
  const UserAttendanceUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: const CommonNewAppBar(
          title: 'Attendance',
          leadingIconSvg: AppImages.icBack,
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
          child: Obx(() => controller.isLoading.isTrue
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Utils.commonCircularProgress(),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      // Adjust container width as needed
                      decoration: BoxDecoration(
                        /*gradient: AppColors.gradientBackground,*/
                        // Assign default if null
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorLightPurple3,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CommonAppImage(
                                        width: MediaQuery.of(context).size.width * 0.15,
                                        height: MediaQuery.of(context).size.height * 0.08,
                                        imagePath: controller
                                            .userProfile
                                            .trim()
                                            .toString()),
                                  ),
                                  const SizedBox(width: 14.0),
                                  // Spacer between image and text
                                  // Column for Texts
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 45,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /*const SizedBox(height: 5.0),*/
                                          Obx(
                                            () => CommonText(
                                              text: controller.userName.value,
                                              fontWeight: AppFontWeight.w500,
                                              fontSize: MediaQuery.of(context).size.width * 0.045,
                                              color: AppColors.color2F2F31,
                                            ),
                                          ),
                                          /*const SizedBox(height: 5.0),*/
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  height: MediaQuery.of(context).size.height * 0.02,
                                                    width: MediaQuery.of(context).size.width * 0.03,
                                                    AppImages.svgBagAttendance),
                                                const SizedBox(width: 3.0),
                                                CommonText(
                                                  text: controller
                                                      .userDesignation.value
                                                      .toString(),
                                                  color: AppColors.color2F2F31,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.liveTrackingRoute,
                                          arguments: [
                                            {
                                              "username":
                                                  controller.userName.value,
                                              "empId":
                                                  controller.userEmpId.value,
                                              "cmpId":
                                                  controller.userCmpId.value,
                                              "userImage":
                                                  controller.userProfile.value
                                            }
                                          ]);
                                    },
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: SvgPicture.asset(
                                                AppImages.svgAttendanceLocation)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    /*const SizedBox(height: 10,),*/
                    Container(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        width: MediaQuery.of(context).size.width *
                            0.9, // Adjust container width as needed
                        child: _getAttendanceCalender(context)),
                    /*const SizedBox(height: 16.0),*/
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.attendanceRegularizeDetails.value
                                .data?.length ??
                            1,
                        itemBuilder: (context, index) {
                          return getUserAttendanceUi(context, index);
                        },
                      ),
                    )
                  ],
                )),
        )
      ],
    );
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
                    controller.selectedMonthIndex.value = controller.listOfMonths.indexOf(value.toString())+1;
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
                  value: controller.selectedYears.value.isEmpty || controller.selectedYears.value=="" ? controller.listOfYears.first : controller.selectedYears.value,
                ),
              )
            ),
          )
        ],),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(""),
            GestureDetector(
              onTap: () {
                controller.callUserAttendanceRegularizationDetails(
                    controller.selectedMonthIndex.value,
                    int.tryParse(controller.selectedMonths.value) ?? DateTime.now().year
                );
              },
              child: Container(
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
              ),
            )
          ],),
      ],
    );
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
      ],
    );
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
}
