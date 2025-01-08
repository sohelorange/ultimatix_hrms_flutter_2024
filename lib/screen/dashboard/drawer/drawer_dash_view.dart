import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/drawer/drawer_dash_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/widget/dash_app_bar.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_images.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_container.dart';
import '../../../widget/common_explore_grid_view.dart';
import '../../../widget/common_material_dialog.dart';

class DrawerDashView extends GetView<DrawerDashController> {
  const DrawerDashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DashAppBar(
        name: controller.designation.value,
        designation: controller.userName.value,
        profileImageUrl: controller.userImageUrl.value,
        showEditIcon: false,
        showBackIcon: true,
        onEditIconClick: () {},
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.profileRoute);
            },
            child: const CommonAppImage(
              imagePath: AppImages.draweredit,
              height: 20,
              width: 20,
              color: AppColors.colorBlack,
            ).paddingOnly(right: 10),
          ),
          GestureDetector(
            onTap: () {
              // showCupertinoDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return CommonLogoutDialog(
              //       onLogoutPressed: () {
              //         PreferenceUtils.setIsLogin(false).then((_) {
              //           Get.offAllNamed(AppRoutes.loginRoute);
              //         });
              //       },
              //     );
              //   },
              // );

              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return CommonMaterialDialog(
              //       title: 'Logout',
              //       message: 'Are you sure you want to\nsign out?',
              //       yesButtonText: 'Yes',
              //       noButtonText: 'No',
              //       onConfirm: () {
              //         controller.logout();
              //         // PreferenceUtils.setIsLogin(false).then((_) {
              //         //   Get.offAllNamed(AppRoutes.loginRoute);
              //         // });
              //       },
              //       onCancel: () {
              //         Get.back();
              //       },
              //       isLoading: controller.isLoading,
              //     );
              //   },
              // );

              Get.dialog(CommonMaterialDialog(
                title: 'Logout',
                message: 'Are you sure you want to\nsign out?',
                yesButtonText: 'Yes',
                noButtonText: 'No',
                onConfirm: () {
                  controller.logout();
                  // PreferenceUtils.setIsLogin(false).then((_) {
                  //   Get.offAllNamed(AppRoutes.loginRoute);
                  // });
                },
                onCancel: () {
                  Get.back();
                },
                isLoading: controller.isLoading,
              ));
            },
            child: const CommonAppImage(
              imagePath: AppImages.dashLogoutIcon,
              color: AppColors.colorDarkBlue,
            ),
          ),
        ],
      ),
      body: CommonContainer(
        child: CommonExploreGridView(
          gridItems: controller.exploreItems,
          selectedIndex: controller.selectedIndex,
          onItemTap: (index) {
            controller.selectedIndex.value = index;
            controller.handleNavigation(index);
          },
        ),
      ),
    ));
  }
}
