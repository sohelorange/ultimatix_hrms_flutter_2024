import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_announcement_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_bar.dart';
import '../../../widget/common_container.dart';
import '../../../widget/common_text.dart';

class NotificationAnnouncementView
    extends GetView<NotificationAnnouncementController> {
  const NotificationAnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(title: 'Notification'),
      body: CommonContainer(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            CommonText(
              text: 'ORGANIZATION ANNOUNCEMENT',
              color: AppColors.colorDarkBlue,
              fontSize: 16,
              fontWeight: AppFontWeight.w700,
            ),
            const SizedBox(
              height: 10,
            ),
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
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0X1C1F370D),
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 0),
                          ),
                        ],
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
                            color: AppColors.colorDarkBlue,
                            fontSize: 16,
                            fontWeight: AppFontWeight.w500,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonText(
                            text: 'Description',
                            color: AppColors.purpleSwatch,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w500,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonText(
                            text: controller.leaveBalListResponse.value
                                    .data![index].description!
                                    .toString()
                                    .isNotEmpty
                                ? controller.leaveBalListResponse.value
                                    .data![index].description!
                                    .toString()
                                : 'N/A',
                            color: AppColors.colorDarkBlue,
                            fontSize: 14,
                            fontWeight: AppFontWeight.w400,
                          ),
                          const SizedBox(
                            height: 10,
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
                            color: AppColors.purpleSwatch,
                            fontSize: 12,
                            fontWeight: AppFontWeight.w400,
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
