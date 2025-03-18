import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:ultimatix_hrms_flutter/screen/attendance_reg/attendance_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_routes.dart';
import '../../app/app_snack_bar.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_app_image_svg.dart';
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
                      Container(
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
                                        ],
                                      ),
                                    ),

                                    Expanded(
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
                                        GestureDetector(
                                          onTap: () {

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
                                    ))
                                  ],
                                ),
                                const SizedBox(height: 16.0),

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

                      if(controller.isShowChart.value==false) ... [

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
                            child: Obx(
                              ()=> ListView.builder(
                                itemCount: controller.expanded.length,
                                itemBuilder: (context, index) {

                                    return Obx(
                                          ()=> Column(
                                          children: [

                                              getTeamAttendanceUi(context, index),

                                              if(controller.expanded[index])
                                                controller.isLoadingOnItem.value==true ?
                                                    const Center(child: CircularProgressIndicator())
                                                    : Column(
                                                  children: List.generate(
                                                    controller.subTeamAttendanceResponse.value.data?.length ?? 0,
                                                        (subIndex) => Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                            color: AppColors.colorEEFAFE,
                                                            border: Border.all(width: 10, color: AppColors.colorDAECF2),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                leading: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(30),
                                                                  child: CommonAppImage(
                                                                    height: 50,width: 50,
                                                                    imagePath: getImageUrl(index),
                                                                    radius: 10,
                                                                  ),
                                                                ),
                                                                title: Text(controller.subTeamAttendanceResponse.value.data?.elementAt(subIndex).empFullName?.trim().toString() ?? ""),
                                                                subtitle: Row(
                                                                  children: [
                                                                    SvgPicture.asset(AppImages.icId),
                                                                    Text(controller.subTeamAttendanceResponse.value.data?.elementAt(subIndex).alphaEmpCode?.trim().toString() ?? ""),
                                                                  ],
                                                                ),
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

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  // Box 1
                                                                  Expanded(
                                                                    child: Container(
                                                                      padding: const EdgeInsets.all(8.0),
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
                                                                                const Text(
                                                                                  'In Time',
                                                                                  style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: AppColors.color1C1F37,
                                                                                      fontWeight: FontWeight.w400),
                                                                                ),
                                                                                Text(
                                                                                  controller.subTeamAttendanceResponse
                                                                                      .value.data!
                                                                                      .elementAt(index)
                                                                                      .status
                                                                                      .toString() ==
                                                                                      ""
                                                                                      ? "--:--"
                                                                                      : controller
                                                                                      .subTeamAttendanceResponse
                                                                                      .value
                                                                                      .data!
                                                                                      .elementAt(index)
                                                                                      .status
                                                                                      .toString(),
                                                                                  style: const TextStyle(
                                                                                      fontSize: 14,
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
                                                                      padding: const EdgeInsets.all(8.0),
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
                                                                                const Text(
                                                                                  'Out Time',
                                                                                  style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: AppColors.color1C1F37,
                                                                                      fontWeight: FontWeight.w400),
                                                                                ),
                                                                                Text(
                                                                                  controller.subTeamAttendanceResponse
                                                                                      .value.data
                                                                                      ?.elementAt(index)
                                                                                      .status2
                                                                                      .toString()
                                                                                      .trim() ==
                                                                                      ""
                                                                                      ? "--:--"
                                                                                      : controller
                                                                                      .subTeamAttendanceResponse
                                                                                      .value
                                                                                      .data!
                                                                                      .elementAt(index)
                                                                                      .status2
                                                                                      .toString(),
                                                                                  style: const TextStyle(
                                                                                      fontSize: 14,
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
                                                              ).paddingOnly(left: 12,right: 12,bottom: 12)
                                                            ],
                                                          ),
                                                    ).paddingOnly(left: 20,right: 20,top: 2),
                                                  ),
                                                ),

                                          ],
                                      ),
                                    );
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
    return Column(
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
                  ],
                );
              },
            ),
          ),
        ],
      );
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
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        Text(
                          controller.expanded.length.toString(),
                          style: const TextStyle(color: AppColors.colorWhite),
                        ),
                        const SizedBox(width: 5,),
                          controller.expanded[index]==false ?
                            SvgPicture.asset(AppImages.svgDropDownAttendance,height: 5,width: 8,)
                              : SvgPicture.asset(AppImages.svgArrowUpAttendance,height: 5,width: 8,)
                      ],),
                    ),
                  )
                ]),
                onPressed: () {
                  controller.expanded[index] = !controller.expanded[index];
                  if(controller.expanded[index]==true) {
                    controller.isLoadingOnItem.value = true;

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
}