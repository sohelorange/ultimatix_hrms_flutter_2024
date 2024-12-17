import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

import '../../../api/dio_client.dart';
import '../../../app/app_url.dart';
import '../../../utility/network.dart';

class DrawerDashController extends GetxController {
  RxString userImageUrl = "".obs;
  RxString userName = "".obs;
  RxString designation = "".obs;
  var isLoading = false.obs;
  var isDisable = false.obs;

  final List<Map<String, dynamic>> exploreItems = [
    {'id': 1, 'icon': AppImages.drawerHomeIcon, 'name': 'Home'},
    {'id': 2, 'icon': AppImages.drawerExploreIcon, 'name': 'Explore'},
    {'id': 3, 'icon': AppImages.drawerQRIcon, 'name': 'QR Code\nAttendance'},
    {'id': 4, 'icon': AppImages.drawerApprovalsIcon, 'name': 'Approvals'},
    {'id': 5, 'icon': AppImages.drawerSalaryIcon, 'name': 'Salary'},
    {
      'id': 6,
      'icon': AppImages.drawerPhotoGalleryIcon,
      'name': 'Photo Gallery'
    },
    {
      'id': 7,
      'icon': AppImages.drawerLiveTrackingIcon,
      'name': 'Live Tracking'
    },
    {
      'id': 8,
      'icon': AppImages.drawerBirthdayIcon,
      'name': 'Birthday &\nAnniversary'
    },
    {'id': 9, 'icon': AppImages.drawerHolidayIcon, 'name': 'Holiday'},
    {'id': 10, 'icon': AppImages.drawerSurveyIcon, 'name': 'Survey'},
    {
      'id': 11,
      'icon': AppImages.drawerPolicyIcon,
      'name': 'Policy &\nDocument'
    },
    {
      'id': 12,
      'icon': AppImages.drawerTeamAttendanceIcon,
      'name': 'My Team\nAttendance'
    },
    {'id': 13, 'icon': AppImages.drawerSettingIcon, 'name': 'Setting'},
  ];

  final RxInt selectedIndex = 0.obs;

  void handleNavigation(int index) {
    // Retrieve the selected item dynamically based on index
    final selectedItem = exploreItems[index];

    // Use 'id' to handle navigation dynamically
    switch (selectedItem['id']) {
      case 1: // Home
        Get.offAllNamed(AppRoutes.dashBoardRoute);
        break;
      case 2: // Explore
        Get.toNamed(AppRoutes.exploreTabRoute);
        break;
      case 3: // QR Code Attendance
        break;
      case 4: // Approvals
        break;
      case 5: // Salary
        break;
      case 6: // Photo Gallery
        break;
      case 7: // Live Tracking
        Get.toNamed(AppRoutes.liveTrackingRoute);
        break;
      case 8: // Birthday & Anniversary
        break;
      case 9: // Holiday
        break;
      case 10: // Survey
        break;
      case 11: // Policy & Document
        break;
      case 12: // My Team Attendance
        break;
      case 13: // Setting
        break;
      default:
        AppSnackBar.showGetXCustomSnackBar(
            message: 'This feature is under development.');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    userImageUrl.value = loginData['image_Name'] ?? '';
    userName.value = loginData['emp_Full_Name'] ?? '';
    designation.value = loginData['desig_Name'] ?? '';
  }

  Future<void> logout() async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          'loginToken': PreferenceUtils.getAuthToken().replaceAll('Bearer ', ''),
        };

        var response = await DioClient().post(AppURL.logoutURL, param);
        if (response['code'] == 200 && response['status'] == true) {
          PreferenceUtils.setIsLogin(false).then((_) {
            Get.offAllNamed(AppRoutes.loginRoute);
          });
          
          AppSnackBar.showGetXCustomSnackBar(message: response['message'],backgroundColor: Colors.green);
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isLoading(false);
      isDisable(false);
    }
  }

}
