import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_approval_status/leave_approval_status_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import '../../../widget/common_app_image_svg.dart';

class LeaveApprovalStatusView extends GetView<LeaveApprovalStatusController> {
  const LeaveApprovalStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     surfaceTintColor: Colors.transparent,
    //     elevation: 0,
    //     flexibleSpace: Container(
    //       decoration: const BoxDecoration(
    //         gradient: LinearGradient(
    //           colors: [AppColors.colorF18700, AppColors.colorF18700],
    //           // Gradient colors
    //           begin: Alignment.bottomLeft,
    //           end: Alignment.topRight,
    //           stops: [0.3, 0.7],
    //           // Stops for the gradient colors
    //           tileMode: TileMode.clamp,
    //         ),
    //       ),
    //     ),
    //     centerTitle: true,
    //     leading: IconButton(
    //       icon: const Icon(
    //         Icons.arrow_back,
    //         color: Colors.white,
    //       ),
    //       onPressed: () {
    //         Get.back();
    //       },
    //     ),
    //     title: CommonText(
    //       text: 'Leave Approval',
    //       fontWeight: FontWeight.w500,
    //       fontSize: 18,
    //       color: AppColors.colorWhite,
    //     ),
    //   ),
    //   body: getView(context),
    // );

    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
        title: 'Leave Application Status',
        leadingIconSvg: AppImages.icBack,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: getView(context),
      ),
    ));
  }

  getView(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //double padding = constraints.maxWidth > 600 ? 20.0 : 10.0;
        double width = MediaQuery.of(context).size.width;

        return Obx(() {
          return controller.isLoading.isTrue
              ? Center(child: Utils.commonCircularProgress())
              : Column(
                  children: [
                    _headerUI(width),
                    const SizedBox(
                      height: 25,
                    ),
                    _listUI(width),
                  ],
                );
        });
      },
    );
  }

  Widget _headerUI(double width) {
    return Container(
      width: double.infinity,
      //height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
        //width: width > 600 ? 500 : width - 32, // Responsive width
        width: double.infinity, // Responsive width
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.color303E9F, // Center and Right color
                    AppColors.color7A1FA2, // Left color
                  ],
                  stops: [0.30, 0.65],
                  tileMode: TileMode.mirror,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const CommonAppImageSvg(
                imagePath: AppImages.leaveCalendarIcon,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: AppColors.colorWhite,
              ).paddingSymmetric(vertical: 10, horizontal: 10),
            ).paddingOnly(right: 10),
            Expanded(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: 'Application Date',
                          color: AppColors.color7B758E,
                          fontSize: 12,
                          fontWeight: AppFontWeight.w400,
                        ),
                        const SizedBox(height: 2.0),
                        CommonText(
                          text: (controller
                                      .leaveApprovalResponse
                                      .value
                                      .data
                                      ?.dataResponse
                                      ?.effectiveDate
                                      ?.isNotEmpty ??
                                  false)
                              ? AppDatePicker.convertDateFormatInputOutputDate(
                                  controller.leaveApprovalResponse.value.data
                                          ?.dataResponse?.effectiveDate
                                          ?.trim() ??
                                      "",
                                )
                              : '',
                          color: AppColors.color2F2F31,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: 'Leave Type',
                          color: AppColors.color7B758E,
                          fontSize: 12,
                          fontWeight: AppFontWeight.w400,
                        ),
                        const SizedBox(height: 2.0),
                        CommonText(
                          text: controller.leaveApprovalResponse.value.data
                                  ?.dataResponse?.schemeName
                                  ?.trim() ??
                              "",
                          color: AppColors.color2F2F31,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listUI(double width) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount:
              controller.leaveApprovalResponse.value.data?.data1?.length ?? 0,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: false,
                        child: ClipOval(
                          child: Container(
                            height: width * 0.1,
                            width: width * 0.1,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? Colors.transparent
                                  : controller.leaveApprovalResponse.value.data
                                              ?.data1
                                              ?.elementAt(index)
                                              .applicationStatus
                                              ?.trim() ==
                                          "A"
                                      ? const Color(0XFF00ABA4)
                                      : AppColors.colorE1E1E1
                                          .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: index == 0
                                  ? const Icon(Icons.person,
                                      color: AppColors.purpleSwatch, size: 24)
                                  : Text(
                                      "$index",
                                      style: TextStyle(
                                        color: controller.leaveApprovalResponse
                                                    .value.data?.data1
                                                    ?.elementAt(index)
                                                    .applicationStatus
                                                    ?.trim() ==
                                                "A"
                                            ? AppColors.colorWhite
                                            : AppColors.color2F2F31,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: ClipOval(
                          child: Container(
                            height: width * 0.1,
                            width: width * 0.1,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColors.purpleSwatch
                                      .withValues(alpha: 0.10)
                                  : controller.leaveApprovalResponse.value.data
                                              ?.data1
                                              ?.elementAt(index)
                                              .applicationStatus
                                              ?.trim() ==
                                          "A"
                                      ? const Color(0XFF00ABA4)
                                      : AppColors.colorE1E1E1,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                index == 0
                                    ? "A"
                                    : controller.leaveApprovalResponse.value
                                                .data?.data1
                                                ?.elementAt(index)
                                                .applicationStatus
                                                ?.trim() ==
                                            "A"
                                        ? "$index"
                                        : "$index",
                                style: TextStyle(
                                  color: index == 0
                                      ? AppColors.purpleSwatch
                                      : controller.leaveApprovalResponse.value
                                                  .data?.data1
                                                  ?.elementAt(index)
                                                  .applicationStatus
                                                  ?.trim() ==
                                              "A"
                                          ? AppColors.colorWhite
                                          : AppColors.color2F2F31,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  textAlign: TextAlign.start,
                                  text: 'Applicant',
                                  color: AppColors.color7B758E,
                                  fontSize: 12,
                                  fontWeight: AppFontWeight.w400,
                                ),
                                const SizedBox(height: 1.0),
                                CommonText(
                                  textAlign: TextAlign.start,
                                  text: controller.leaveApprovalResponse.value
                                          .data?.data1
                                          ?.elementAt(index)
                                          .applicationDate
                                          ?.trim() ??
                                      "",
                                  color: AppColors.color2F2F31,
                                  fontSize: 14,
                                  fontWeight: AppFontWeight.w400,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  textAlign: TextAlign.start,
                                  text: 'Status',
                                  color: AppColors.color7B758E,
                                  fontSize: 12,
                                  fontWeight: AppFontWeight.w400,
                                ),
                                const SizedBox(height: 2.0),
                                CommonText(
                                  textAlign: TextAlign.start,
                                  text: controller.leaveApprovalResponse.value
                                          .data?.data1
                                          ?.elementAt(index)
                                          .applicationStatus
                                          ?.trim() ??
                                      "",
                                  color: AppColors.color2F2F31,
                                  fontSize: 14,
                                  fontWeight: AppFontWeight.w400,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width * 0.2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: index ==
                            (controller.leaveApprovalResponse.value.data?.data1
                                        ?.length ??
                                    0) -
                                1
                        ? const BoxDecoration() // No decoration for the last item
                        : DottedDecoration(
                            //color: AppColors.colorDarkGray,
                            color: controller
                                        .leaveApprovalResponse.value.data?.data1
                                        ?.elementAt(index)
                                        .applicationStatus
                                        ?.trim() ==
                                    "A"
                                ? const Color(0XFF00ABA4)
                                : AppColors.colorE1E1E1,
                            strokeWidth: 1,
                            linePosition: LinePosition.left,
                          ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: width * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                textAlign: TextAlign.start,
                                text: 'Applicant Name',
                                color: AppColors.color7B758E,
                                fontSize: 12,
                                fontWeight: AppFontWeight.w400,
                              ),
                              const SizedBox(height: 1.0),
                              CommonText(
                                textAlign: TextAlign.start,
                                text: controller
                                        .leaveApprovalResponse.value.data?.data1
                                        ?.elementAt(index)
                                        .name
                                        ?.trim() ??
                                    "",
                                color: AppColors.color2F2F31,
                                fontSize: 14,
                                fontWeight: AppFontWeight.w400,
                              ),
                              const SizedBox(height: 12.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
