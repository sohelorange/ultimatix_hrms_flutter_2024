import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_announcement_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_text.dart';

class NotificationAnnouncementView
    extends GetView<NotificationAnnouncementController> {
  const NotificationAnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
        title: 'Notification',
        leadingIconSvg: AppImages.icBack,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              textAlign: TextAlign.start,
              text: 'ORGANIZATION ANNOUNCEMENT',
              color: AppColors.colorDarkBlue,
              fontSize: 16,
              fontWeight: AppFontWeight.w700,
            ).paddingOnly(bottom: 10),
            Obx(() => _notificationUI(context)),
          ],
        ),
      ),
    ));
  }

  Widget _notificationUI(BuildContext context) {
    return controller.isLoading.isTrue
        ? Expanded(child: Center(child: Utils.commonCircularProgress()))
        : controller.leaveBalListResponse.value.data != null
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  //controller: _scrollController,
                  itemCount: controller.leaveBalListResponse.value.data!.length,
                  itemBuilder: (context, index) {
                    Color boxColor = controller
                        .boxColors[index % controller.boxColors.length];
                    Color textColor = controller
                        .textColors[index % controller.textColors.length];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: controller.leaveBalListResponse.value
                                    .data![index].docTitle!
                                    .toString()
                                    .isNotEmpty
                                ? controller.leaveBalListResponse.value
                                    .data![index].docTitle!
                                    .toString()
                                : 'N/A',
                            color: textColor,
                            fontSize: 16,
                            fontWeight: AppFontWeight.w600,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: controller.leaveBalListResponse.value
                                          .data![index].description!
                                          .toString()
                                          .isNotEmpty
                                      ? controller.leaveBalListResponse.value
                                          .data![index].description!
                                          .toString()
                                      : 'N/A',
                                  color: AppColors.color2F2F31,
                                  fontSize: 14,
                                  fontWeight: AppFontWeight.w400,
                                ),
                                CommonText(
                                  text: controller.leaveBalListResponse.value
                                          .data![index].docFromDate!
                                          .toString()
                                          .isNotEmpty
                                      ? controller.leaveBalListResponse.value
                                          .data![index].docFromDate!
                                          .toString()
                                      : 'N/A',
                                  color: AppColors.color7B758E,
                                  fontSize: 12,
                                  fontWeight: AppFontWeight.w400,
                                ).paddingOnly(top: 5),
                              ],
                            ),
                          ),
                        ],
                      ), // Your widget inside the Container
                    );
                  },
                ),
              )
            : Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonAppImageSvg(
                      imagePath: AppImages.svgNoData,
                      height: 100,
                      width: MediaQuery.sizeOf(context).width),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonText(
                    text: controller.leaveBalListResponse.value.message!,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.colorDarkBlue,
                  ),
                ],
              ));
  }
}
