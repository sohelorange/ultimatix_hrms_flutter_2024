import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_announcement_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';

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
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: 'ORGANIZATION ANNOUNCEMENT',
                color: AppColors.colorDarkBlue,
                fontSize: 16,
                fontWeight: AppFontWeight.w700,
              ),
              Obx(() => _notificationUI()),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _notificationUI() {
    return controller.isLoading.value && controller.notificationList.isEmpty
        ? Expanded(child: Center(child: Utils.commonCircularProgress()))
        : controller.notificationList.isEmpty
            ? Expanded(
                child: Center(
                  child: Text(controller.statusCode == 0
                      ? Constants.timeOutMsg
                      : controller.statusCode == 204
                          ? Constants.noDataMsg
                          : Constants.somethingWrongMsg),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  //controller: _scrollController,
                  itemCount: controller.notificationList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < controller.notificationList.length) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child:
                            _listUI(index), // Your widget inside the Container
                      );
                    } else {
                      if (controller.isLoading.value) {
                        return Utils.commonCircularProgress();
                      } else {
                        return const SizedBox(); // Return an empty SizedBox if no more data to fetch
                      }
                    }
                  },
                ),
              );
  }

  Widget _listUI(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: controller.notificationList[index]['Doc_Title']
              .toString()
              .isNotEmpty
              ? controller.notificationList[index]['Doc_Title'].toString()
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
          text: controller.notificationList[index]['Description']
                  .toString()
                  .isNotEmpty
              ? controller.notificationList[index]['Description'].toString()
              : 'N/A',
          color: AppColors.colorDarkBlue,
          fontSize: 14,
          fontWeight: AppFontWeight.w400,
        ),
        const SizedBox(
          height: 10,
        ),
        CommonText(
          text: controller.notificationList[index]['Doc_FromDate']
              .toString()
              .isNotEmpty
              ? controller.notificationList[index]['Doc_FromDate'].toString()
              : 'N/A',
          color: AppColors.purpleSwatch,
          fontSize: 12,
          fontWeight: AppFontWeight.w400,
        ),
      ],
    );
  }
}
