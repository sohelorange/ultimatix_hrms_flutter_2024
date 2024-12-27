import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

import '../../app/app_images.dart';

class ExploreController extends GetxController {
  // Dynamic list of explore items (can be 5, 10, or any length)

  int geofence_enable = 0;



  final List<Map<String, dynamic>> exploreItems = [
    {'id': 1, 'icon': AppImages.exploreClockingIcon, 'name': 'Clocking'},
    {'id': 2, 'icon': AppImages.exploreLeaveIcon, 'name': 'Leaves'},
    {'id': 3, 'icon': AppImages.exploreAttendanceIcon, 'name': 'Attendance'},
    {
      'id': 4,
      'icon': AppImages.exploreChangeReqIcon,
      'name': 'Change\nRequest'
    },
    {'id': 5, 'icon': AppImages.exploreTravelIcon, 'name': 'Travel'},
    {'id': 6, 'icon': AppImages.exploreMedicalIcon, 'name': 'Medical'},
    {'id': 7, 'icon': AppImages.exploreGrievanceIcon, 'name': 'Grievance'},
    {'id': 8, 'icon': AppImages.exploreCanteenIcon, 'name': 'Canteen'},
    {'id': 9, 'icon': AppImages.exploreCRMIcon, 'name': 'CRM'},
    {
      'id': 10,
      'icon': AppImages.exploreTicketAppIcon,
      'name': 'Ticket\nApplication'
    },
    {'id': 11, 'icon': AppImages.exploreClaimIcon, 'name': 'Claim'},
    {
      'id': 12,
      'icon': AppImages.exploreExitAppIcon,
      'name': 'Exit\nApplication'
    },
    {
      'id': 13,
      'icon': AppImages.svgRegAttendance,
      'name': 'Regularize Approval'
    },
  ];

  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    geofence_enable = loginData['is_Geofence_enable'];
    print("geofen--${geofence_enable}");

  }

  void handleNavigation(int index) {
    // Retrieve the selected item dynamically based on index
    final selectedItem = exploreItems[index];

    // Use 'id' to handle navigation dynamically
    switch (selectedItem['id']) {
      case 1:// Clocking
        if(geofence_enable == 1){
          Get.toNamed(AppRoutes.geofenceRoute);
          print("geo--${geofence_enable}");
        } else {
          Get.toNamed(AppRoutes.clockInRoute);
          print("geo--${geofence_enable}");
        }
        break;
      case 2: // Leaves
        Get.toNamed(AppRoutes.leaveApplicationRoute);
        break;
      case 3: // Attendance
      Get.toNamed(AppRoutes.attendanceMainRoute);
        break;
      case 4: // Change Request
        break;
      case 5: // Travel
        break;
      case 6: // Medical
        break;
      case 7: // Grievance
        break;
      case 8: // Canteen
        break;
      case 9: // CRM
        break;
      case 10: // Ticket Application
        break;
      case 11: // Claim
        break;
      case 12: // Exit Application
        break;
      case 13:
        Get.toNamed(AppRoutes.regularizeListApprovals);
        break;
      default:
        AppSnackBar.showGetXCustomSnackBar(
            message: 'This feature is under development.');
    }
  }

}
