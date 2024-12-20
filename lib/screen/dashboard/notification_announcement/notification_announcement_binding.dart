import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_announcement_controller.dart';

class NotificationAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationAnnouncementController());
  }
}