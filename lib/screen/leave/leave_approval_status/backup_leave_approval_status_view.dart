import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_dimensions.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_approval_status/leave_approval_status_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../widget/common_app_image_svg.dart';

class BackupLeaveApprovalStatusView
    extends GetView<LeaveApprovalStatusController> {
  const BackupLeaveApprovalStatusView({super.key});

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
      appBar: const CommonAppBar(
        title: 'Leave Approval',
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: getView(context),
        ),
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
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Utils.commonCircularProgress(),
                  ],
                )
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
      width: width > 600 ? 500 : width - 32, // Responsive width
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First row with an icon and text
          Row(
            children: [
              Visibility(
                visible: false,
                child: Container(
                    width: width * 0.08,
                    height: width * 0.08,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.purpleSwatch,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const CommonAppImageSvg(
                      imagePath: AppImages.leaveApprovalIcon,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    )),
              ),
              const CommonAppImageSvg(
                imagePath: AppImages.leaveApprovalIcon,
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 15.0),
              CommonText(
                text: 'Leave Application Status',
                color: AppColors.colorDarkBlue,
                fontSize: AppDimensions.fontSizeRegular,
                fontWeight: AppFontWeight.w400,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Two boxes below
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Applied Date',
                        color: AppColors.colorDarkGray,
                        fontSize: AppDimensions.fontSizeSmall,
                        fontWeight: AppFontWeight.w400,
                      ),
                      const SizedBox(height: 8.0),
                      CommonText(
                        text: (controller.leaveApprovalResponse.value.data
                                    ?.dataResponse?.effectiveDate?.isNotEmpty ??
                                false)
                            ? AppDatePicker.convertDateFormatInputOutputDate(
                                controller.leaveApprovalResponse.value.data
                                        ?.dataResponse?.effectiveDate
                                        ?.trim() ??
                                    "",
                              )
                            : '',
                        color: AppColors.colorDarkBlue,
                        fontSize: AppDimensions.fontSizeSmall,
                        fontWeight: AppFontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Leave Type',
                        color: AppColors.colorDarkGray,
                        fontSize: AppDimensions.fontSizeSmall,
                        fontWeight: AppFontWeight.w400,
                      ),
                      const SizedBox(height: 8.0),
                      CommonText(
                        text: controller.leaveApprovalResponse.value.data
                                ?.dataResponse?.schemeName
                                ?.trim() ??
                            "",
                        color: AppColors.colorDarkBlue,
                        fontSize: AppDimensions.fontSizeSmall,
                        fontWeight: AppFontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
                        child: Container(
                          height: width * 0.1,
                          width: width * 0.1,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: index == 0
                                ? AppColors.purpleSwatch.withValues(alpha: 0.10)
                                : AppColors.colorE1E1E1.withValues(alpha: 0.10),
                            // Replace with AppColors.colorF68C1F
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              index == 0 ? "A" : "$index",
                              style: TextStyle(
                                color: index == 0
                                    ? AppColors.purpleSwatch
                                    : AppColors.colorBlack,
                                // Replace with AppColors.colorF68C1F
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: width * 0.1,
                        width: width * 0.1,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: index == 0
                              ? AppColors.purpleSwatch.withValues(alpha: 0.10)
                              : controller.leaveApprovalResponse.value.data
                                          ?.data1
                                          ?.elementAt(index)
                                          .applicationStatus
                                          ?.trim() ==
                                      "A"
                                  ? Colors.green.withValues(alpha: 0.10)
                                  : AppColors.colorE1E1E1
                                      .withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            index == 0
                                ? "A"
                                : controller.leaveApprovalResponse.value.data
                                            ?.data1
                                            ?.elementAt(index)
                                            .applicationStatus
                                            ?.trim() ==
                                        "A"
                                    ? "A"
                                    : "$index",
                            style: TextStyle(
                              color: index == 0
                                  ? AppColors.purpleSwatch
                                  : controller.leaveApprovalResponse.value.data
                                              ?.data1
                                              ?.elementAt(index)
                                              .applicationStatus
                                              ?.trim() ==
                                          "A"
                                      ? Colors.green
                                      : AppColors.colorBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
                                  color: AppColors.colorDarkGray,
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
                                  color: AppColors.colorDarkBlue,
                                  fontSize: 14,
                                  fontWeight: AppFontWeight.w500,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  textAlign: TextAlign.start,
                                  text: 'Status',
                                  color: AppColors.colorDarkGray,
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
                                  color: AppColors.colorDarkBlue,
                                  fontSize: 14,
                                  fontWeight: AppFontWeight.w500,
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
                            color: AppColors.colorDarkGray,
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
                                color: AppColors.colorDarkGray,
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
                                color: AppColors.colorDarkBlue,
                                fontSize: 14,
                                fontWeight: AppFontWeight.w500,
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
